unit Database;
{
This unit contains all of the database interaction code.
}
interface

uses
  SysUtils, Forms, Dialogs, Classes, ACRMain, Db, Utility, FileRec, Hash;

type
  TDBModule = class(TDataModule)
    SSA_Database: TACRDatabase;
    UserTable: TACRTable;
    FileTable: TACRTable;

  private
    { Private declarations }
    function  CreateDatabase(): Integer;
    function  CreateFileTable(): Integer;
    function  CreateUserTable(): Integer;
    function  OpenDB(): Integer;
    function  InitializeDatabase(): Integer;

  public
    { Public declarations }
    class function GetInstance(): TDBModule;
    function  InsertToUserTable(username:String; password:String): Integer;
    function  InsertToFileTable(info: TFileRec; whitelisted : Boolean): Integer;
    function  EmptyFileTable(EmptyFileTableQuery: TACRQuery): Integer;
    function  getUserHash(Username: String): Variant;
    function  getFileHash(path : string): Variant;
    function  isFileWhiteListed(Hash : string): Variant;
    procedure RefreshFileTable();
    procedure RefreshUserTable();
  end;

var
  Initialized: Boolean = false;
  DBModule: TDBModule;
  HashObj: THashModule;
implementation

{$R *.DFM}

//return an instance of the db object
//there is only ever one instance
class function TDBModule.GetInstance(): TDBModule;
Begin
   if Initialized = false then
   Begin
   //if the DB has not been initialied this execution, check it to make sure everything is set up correctly
   //we may need hashing capabilities to initialize the User table, so get an instance of it
      HashObj:=THashModule.GetInstance();
      DBModule.InitializeDatabase();
   end;
   //now that everything is initialized, return the instance
   GetInstance:=DBModule;
end;

procedure TDBModule.RefreshFileTable();
Begin
   FileTable.Close();
   FileTable.Open();
end;

procedure TDBModule.RefreshUserTable();
Begin
   UserTable.Close();
   UserTable.Open();
end;

function TDBModule.OpenDB(): Integer;
Begin
   SSA_Database.Open;
   UserTable.Open;
   FileTable.Open;
   OpenDB:=1;
end;

//If the db doesn't exist, create it with the proper fields
function TDBModule.InitializeDatabase(): Integer;
var ret:Integer;
Begin
   //Make sure the Hash object is initialized, otherwise we can't add the default user if necessary.
   
   //check to see if the database file exists, if not create it.
   if (not SSA_Database.Exists) then
   Begin
      ret := CreateDatabase();
      if ret < 0 then
      Begin
         MessageDlg('The database could not be initialized. Error code ' +
                    IntToStr(ret) + AnsiString(#13#10) + 'The program will now exit.',
                    mtInformation, [mbOk], 0);
         InitializeDatabase := ret;
         Exit;
      end;
   end;

   //check to see if the User table is in the database
   if (not UserTable.Exists) then
   Begin
      ret := CreateUserTable();
      if ret < 0 then
      Begin
         MessageDlg('The User table could not be created. Error code ' +
                    IntToStr(ret) + AnsiString(#13#10) + 'The program will now exit.',
                    mtInformation, [mbOk], 0);
         InitializeDatabase := ret;
         Exit;
      end;
      //populate the table with a default user so that we can log in
      UserTable.Open();
      InsertToUserTable('admin', 'tempus');
   end;

   if (not FileTable.Exists) then
   Begin
      ret := CreateFileTable();
      if ret < 0 then
      Begin
         MessageDlg('The File table could not be created. Error code ' +
                    IntToStr(ret) + AnsiString(#13#10) + 'The program will now exit.',
                    mtInformation, [mbOk], 0);
         InitializeDatabase := ret;
         Exit;
      end;
   end;
   // intended to be an error code
   InitializeDatabase := 1;
   OpenDB();
   //now we have initialized the db, so we can skip this step in the future.
   initialized:=true;
end;

function TDBModule.CreateDatabase(): Integer;
Begin
   SSA_Database.CreateDatabase();
   CreateDatabase := 1;
end;

//create the file table and add proper fields to it
function TDBModule.CreateFileTable(): Integer;
Begin
   with FileTable do
   Begin
      if Exists then
      Begin
         Close;
         DeleteTable;
      end;

      TableName:='File';
	  //we need to add some more constraints here, such as non-null fields, unique fields, etc
      with FieldDefs do
      Begin
         Clear;
         Add('WhiteListed', ftBoolean, 0, False);
         Add('Hash', ftString, 41, False);//hash field is stored as a string currently (bad)
         Add('LastAccessed', ftDateTime, 0, False);
         Add('Location', ftString, 256, False);
         Add('LastSolidified', ftDateTime, 0, False);
         Add('Instance', ftInteger, 0, False);
         Add('GUID', ftString, 30, False);
         Add('Name', ftString, 128, False);
         Add('Size', ftInteger, 0, False);
      end;

      with IndexDefs do
      Begin
         Clear;
         Add('PrimaryKey', 'GUID', [ixPrimary]);
      end;

      CreateTable;
      CreateFileTable := 1;
   end;
end;

//create user table and add proper fields to it
function TDBModule.CreateUserTable(): Integer;
Begin
   with UserTable do
   Begin
      if Exists then
      Begin
         Close;
         DeleteTable;
      end;

      TableName:='User';
//we need to add some more constraints here, such as non-null fields, unique fields, etc
      with FieldDefs do
      Begin
         Clear;
         Add('GUID', ftString, 30, False);
         Add('Name', ftString, 30, False);
         Add('Hash', ftString, 41, False);//hash field is stored as a string currently (bad)
     end;

      with IndexDefs do
      Begin
         Clear;
         Add('PrimaryKey', 'GUID', [ixPrimary]);
      end;

      CreateTable;
      CreateUserTable := 1;
   end;
end;

//caller must remember to close and open the table to update the GUI
//the table must be open before calling this function
//Insert a username and password into the db, function will create hash of pw
function TDBModule.InsertToUserTable(username:String; password:String): Integer;
Begin
   with UserTable do
   Begin
      Insert;
      FieldByName('GUID').asstring:=GenerateGUID;
      FieldByName('Name').asstring:=username;
      FieldByName('Hash').asstring:=HashObj.HashPassword(password);
      try
          Post;
      except
         on E:Exception do
         Begin
            Cancel;
            MessageDlg(E.message, mtInformation, [mbOk], 0);
            InsertToUserTable := -1;
            Exit;
         end;
      end;
   end;
   InsertToUserTable := 1;
end;

//caller must remember to close and open the table to update the GUI
//the table must be open before calling this function
//Insert into file table
function TDBModule.InsertToFileTable(info : TFileRec; whitelisted : Boolean): Integer;
var
path : String;
dirinfo : TSearchRec;
Begin
   path := info.getPath;
   dirinfo := info.getdirinfo;

   with FileTable do
   Begin
      Insert;
      Fieldbyname('GUID').asstring:=GenerateGUID;
      Fieldbyname('name').asstring:= DirInfo.Name;
      Fieldbyname('Location').asstring:= Path;
      Fieldbyname('LastAccessed').asdatetime:= ConvertFileTime(DirInfo.FindData.ftLastAccessTime);
      Fieldbyname('Size').asinteger:= dirInfo.Size;
      Fieldbyname('Instance').asinteger:= dirInfo.FindData.dwFileAttributes;
      Fieldbyname('Whitelisted').asboolean := whitelisted;
      Fieldbyname('Hash').asstring := HashObj.HashFile(Path);
      try
         Post;
      except
         on E:Exception do
         Begin
            Cancel;
            MessageDlg(E.message, mtInformation, [mbOk], 0);
            InsertToFileTable := -1;                                                                                     
            Exit;
         end;
      end;

      Close;
      Open;
   end;
   InsertToFileTable := 1;
end;

//caller must remember to close and open the table to update the GUI
function TDBModule.EmptyFileTable(EmptyFileTableQuery: TACRQuery): Integer;
Begin
   EmptyFileTableQuery.Close;
   EmptyFileTableQuery.sql.clear;
   EmptyFileTableQuery.sql.add('delete from file');
   EmptyFileTableQuery.execsql;
   EmptyFileTable := 1;
end;

//return hash of password from username
function TDBModule.getUserHash(Username: String): Variant;
Begin
   with UserTable do
     result := Lookup('Name', Username, 'Hash');
end;

//return hash of file from its path
function TDBModule.getFileHash(path : string): Variant;
Begin
   with FileTable do
     result := Lookup('Location', path, 'Hash');
end;

//return boolean with wether the file is whitelisted or not
function TDBModule.isFileWhiteListed(Hash : string): Variant;
Begin
   with FileTable do
     result := Lookup('Hash', Hash, 'Whitelisted');
end;
end.
