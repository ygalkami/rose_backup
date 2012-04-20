unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ACRMain, Db, Grids, DBGrids, utility;

type
  TSSAForm = class(TForm)
    UserDataSource: TDataSource;
    SSA_Database: TACRDatabase;
    CreateDBBtn: TButton;
    UserTable: TACRTable;
    MakeFileTableBtn: TButton;
    UserTableGrid: TDBGrid;
    InsertToUserTableTempBtn: TButton;
    EmptyUserTableBtn: TButton;
    FileDataSource: TDataSource;
    FileTable: TACRTable;
    FileTableGrid: TDBGrid;
    InsertToFileTableTempBtn: TButton;
    FileNameTxtField: TEdit;
    GUIDTxtField: TEdit;
    EmptyFileTableQuery: TACRQuery;
    ScanSystemBtn: TButton;
    EmptyFileTableBtn: TButton;
    AttrQuery: TACRQuery;
    procedure CreateDBBtnClick(Sender: TObject);
    procedure MakeFileTableBtnClick(Sender: TObject);
    procedure InsertToUserTableTempBtnClick(Sender: TObject);
    procedure EmptyUserTableBtnClick(Sender: TObject);
    procedure InsertToFileTableTempBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScanSystemBtnClick(Sender: TObject);
    procedure AddFileToDB(path : string; dirInfo: TSearchRec);
    procedure SearchFileTree(path : string);
    procedure EmptyFileTableBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SSAForm: TSSAForm;
  FileCount : Integer;
  FoldCount : Integer;

implementation

{$R *.DFM}

procedure TSSAForm.CreateDBBtnClick(Sender: TObject);
begin
SSA_Database.CreateDatabase;
end;

procedure TSSAForm.MakeFileTableBtnClick(Sender: TObject);
begin
fileTable.close;
  with FileTable do
     begin
     TableName:='File';
     with FieldDefs do
        begin
        Clear;
        Add('WhiteListed',ftString,30,False);
        Add('Hash',ftString,30,False);
        Add('LastAccessed',ftDateTime,0,False);
        Add('Location',ftString,256,False);
        Add('LastSolidified',ftDateTime,0,False);
        Add('Instance',ftInteger,0,False);
        Add('GUID',ftString,30,False);
        Add('Name',ftString,128,False);
        Add('Size',ftInteger,0,False);
        end;
     with IndexDefs do
        begin
        Clear;
        Add('PrimaryKey','GUID',[ixPrimary]);
        end;
     if not Exists then
        CreateTable;
     end;
end;

procedure TSSAForm.InsertToUserTableTempBtnClick(Sender: TObject);
begin
userTable.open;
userTable.insert;
userTable.fieldbyname('GUID').asstring:=GenerateGUID;
try
   userTable.post;
except
   on E:Exception do
   begin
      userTable.cancel;
      MessageDlg(E.message, mtInformation,      [mbOk], 0);
   end;
end;

userTable.close;
userTable.open;
end;

procedure TSSAForm.EmptyUserTableBtnClick(Sender: TObject);
begin

//userTable.Close;
//userTable.EmptyTable;
//userTable.open;
EmptyFileTableQuery.close;
EmptyFileTableQuery.sql.clear;
EmptyFileTableQuery.sql.add('delete from user');
EmptyFileTableQuery.execsql;
EmptyFileTableQuery.close;
EmptyFileTableQuery.open;

end;

procedure TSSAForm.InsertToFileTableTempBtnClick(Sender: TObject);
begin
FileTable.open;
FileTable.insert;
FileTable.fieldbyname('GUID').asstring:=GUIDTxtField.Text;
FileTable.fieldbyname('Name').asstring:=FileNameTxtField.Text;
FileTable.post;
end;

procedure TSSAForm.FormCreate(Sender: TObject);
begin
userTable.open;
fileTable.open;
end;

{   CODE EXAMPLE FOR SCANNING TREE
procedure TForm1.Button2Click(Sender: TObject);
var
   DirInfo  : TSearchRec;
   DelFile  : String;
   Result   : Integer;
begin

   Result := FindFirst('\*', faAnyFile, DirInfo);
   While Result = 0 do begin
      DelFile := DirInfo.Name;
      //deletefile(DelFile);
      Result := FindNext(DirInfo);
   end;
   FindClose(DirInfo);
end;}

procedure TSSAForm.ScanSystemBtnClick(Sender: TObject);
var
        path : string;
begin
        FileCount := 0;
        FoldCount := 0;
        path := 'C:\*';
        //path := 'C:\Documents and Settings\owner\Desktop\stuff_to_add\*';
        searchFileTree(path);
        MessageDlg(IntToStr(FileCount) + ' files added' + AnsiString(#13#10) + IntToStr(FoldCount) + ' folders traversed', mtInformation,      [mbOk], 0);
end;

procedure TSSAForm.SearchFileTree(path : string);
var
   DirInfo  : TSearchRec;
   Result   : Integer;
begin
   Result := FindFirst(Path, faAnyFile, DirInfo);
   While Result = 0 do begin
      if ((DirInfo.FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0) //FILE_ATTRIBUTE_DIRECTORY = 16 means a folder
      then
         begin
           if (DirInfo.Name <> '.') and (DirInfo.Name <> '..') then
           begin
//                MessageDlg(PathOnly(path) + DirInfo.Name + '\*', mtInformation,      [mbOk], 0);
                searchFileTree(PathOnly(path) + DirInfo.Name + '\*');
                inc(FoldCount);
           end;
         end
      else
          begin
               addFileToDB(Path, DirInfo);
               inc(FileCount);
          end;
      //deletefile(DelFile);

      Result := FindNext(DirInfo);
   end;
   FindClose(DirInfo);
end;

procedure TSSAForm.AddFileToDB(path : string; dirInfo: TSearchRec);
begin
FileTable.open;
FileTable.insert;
FileTable.fieldbyname('GUID').asstring:=GenerateGUID;
FileTable.fieldbyname('name').asstring:= DirInfo.Name;
FileTable.fieldbyname('Location').asstring:= PathOnly(Path) + DirInfo.Name;
FileTable.fieldbyname('LastAccessed').asdatetime:= ConvertFileTime(DirInfo.FindData.ftLastAccessTime);
FileTable.fieldbyname('Size').asinteger:= dirInfo.Size;
FileTable.fieldbyname('Instance').asinteger:= dirInfo.FindData.dwFileAttributes;
try
   FileTable.post;
except
   on E:Exception do
   begin
      fileTable.cancel;
      MessageDlg(E.message, mtInformation,      [mbOk], 0);
   end;
end;
end;

procedure TSSAForm.EmptyFileTableBtnClick(Sender: TObject);
begin
EmptyFileTableQuery.close;
EmptyFileTableQuery.sql.clear;
EmptyFileTableQuery.sql.add('delete from file');
EmptyFileTableQuery.execsql;
fileTable.close;
fileTable.open;
attrQuery.close;
attrQuery.open;
end;

end.
