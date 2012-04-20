unit Main;
{
This form is the main interface form.
}
interface

{$R *.DFM}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ACRMain, Db, Grids, DBGrids, utility, madCodeHook, Audit, FileRec, Database, Monitor;

const
   ExtensionsToMonitor : array[1..4] of string =
   ('exe', 'cmd', 'bat', 'msi');
   //This is the top of the file tree that will be searched by "Scan System"
   //Change this to another directory for testing (so it is fast)
   RootFilePath = 'C:\Program Files\MSN Gaming Zone\*';      //C:\*

type
  TSSAForm = class(TForm)
    //GUI Labels
    UserTableLbl: TLabel;
    FileTableLbl: TLabel;
    UsernameLbl: TLabel;
    PasswordLbl: TLabel;

    //GUI TextFields
    UsernameTxtFld: TEdit;
    PasswordTxtFld: TEdit;

    //GUI Buttons
    AddUserBtn: TButton;
    EmptyFileTableBtn: TButton;
    ScanSystemBtn: TButton;
    UnloadDriverBtn: TButton;
    LoadDriverBtn: TButton;
    UserDataSource: TDataSource;
    FileDataSource: TDataSource;
    UserTableGrid: TDBGrid;
    FileTableGrid: TDBGrid;
    EmptyFileTableQuery: TACRQuery;
    Button1: TButton;

    //GUI Code
    procedure AddUserBtnClick(Sender: TObject);
    procedure EmptyFileTableBtnClick(Sender: TObject);
    procedure UnloadDriverBtnClick(Sender: TObject);
    procedure LoadDriverBtnClick(Sender: TObject);
    procedure ScanSystemBtnClick(Sender: TObject);

    //Solidify Functions
    procedure SearchFileTree(path : String);
    function  GetFileExtension(Path: String): String;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  end;
var
  SSAForm: TSSAForm;
  SSA_DB    : TDBModule;

implementation

{GUI Code}
//Get an instance of the database
procedure TSSAForm.FormCreate(Sender: TObject);
begin
   SSA_DB := TDBModule.GetInstance();
   if SSA_DB = nil then
   Begin
      MessageDlg('The database could not be initialized. The program will now exit.',
                  mtInformation, [mbOk], 0);
      Exit;
   end;
end;

//Adds a user to the database
procedure TSSAForm.AddUserBtnClick(Sender: TObject);
begin
   SSA_DB.InsertToUserTable(UsernameTxtFld.Text, PasswordTxtFld.Text);
   UsernameTxtFld.SetTextBuf('');
   PasswordTxtFld.SetTextBuf('');
   SSA_DB.RefreshUserTable();
end;

//Scan the system for files that have not been added to the database yet
//Show the audit form when the scan completes
procedure TSSAForm.ScanSystemBtnClick(Sender: TObject);
begin
   //searches the directory/file tree rooted at RootFilePath
   SearchFileTree(RootFilePath);
   if AuditForm.CheckListBox1.Items.Count = 0 then
   begin
        showmessage('No new files were found');
   end
   else
   begin
      AuditForm.Show;
   end;
   SSA_DB.RefreshFileTable();
end;

//Empty the file table
procedure TSSAForm.EmptyFileTableBtnClick(Sender: TObject);
Begin
   SSA_DB.EmptyFileTable(EmptyFileTableQuery);
   SSA_DB.RefreshFileTable();
end;


//Stop hooking
procedure TSSAForm.UnloadDriverBtnClick(Sender: TObject);
begin
    MessageDlg('This will remove the injection driver.', mtInformation,      [mbOk], 0);
    StopMonitor();
end;

//start hooking
procedure TSSAForm.LoadDriverBtnClick(Sender: TObject);
begin
    MessageDlg('This will load the injection driver.', mtInformation,      [mbOk], 0);
    StartMonitor();    
end;



{Solidify Code}

{************************************************************************
Return just the extension of a file name.
Scans from the end of the file name until the first '.' is found
Returns the extension only (not preceded by a '.')
*************************************************************************}
//This is a modified version of a similar function in Utility.pas. This version seaches from the
//end of the file name rather than the beginning for the first '.', so it is more robust.
function TSSAForm.GetFileExtension (Path : String) : String;
var I : Integer;
Begin
   I := length(Path);
   while (I > 0) and (Path[I] <> '.') do
      Dec (I);
   GetFileExtension := COPY(Path, I+1, length(Path));
end;

//Scan the filesystem, if a file is not already in the db add it to the audit form
procedure TSSAForm.SearchFileTree(path : string);
var
   DirInfo  : TSearchRec;
   Result   : Integer;
   i        : Integer;
   temp : variant;
Begin
   Result := FindFirst(Path, faAnyFile, DirInfo);
   while Result = 0 do
   Begin
      if ((DirInfo.FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0) then//FILE_ATTRIBUTE_DIRECTORY = 16 means a folder
      Begin
         if (DirInfo.Name <> '.') and (DirInfo.Name <> '..') then
         Begin
            searchFileTree(PathOnly(path) + DirInfo.Name + '\*');
         end;
      end else
      Begin
         //for loop goes from start to end, inclusive
         for i := low(extensionsToMonitor) to high(extensionsToMonitor) do
         Begin
            if (GetFileExtension(DirInfo.Name) = extensionsToMonitor[i]) then
            Begin
               //Path is the path of the folder we are scanning, followed by a /*
               //PathOnly(Path) removes the *
               temp := SSA_DB.getFileHash(PathOnly(Path) + DirInfo.Name);
               if temp = Null then
               begin
                   AuditForm.CheckListBox1.Items.AddObject(PathOnly(Path)+ DirInfo.Name, TFileRec.Create(PathOnly(Path)+DirInfo.Name, DirInfo));
               end;
               break;
            end;
         end;
      end;
      Result := FindNext(DirInfo);
   end;
   FindClose(DirInfo);
end;

procedure TSSAForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//in case the user forgot
    StopMonitor();
end;

//this tests the functionality of the hook receiver. Although it doesn't actually work yet since our hook isn't passing a file path,
//the idea is that our hook receiver calls fileWhiteListed with a path to determine if the file can run.
//this simulates the user clicking C:\Program Files\MSN Gaming Zone\Windows\bckgzm.exe
//the "right" thing will happen depending on if the file has been added to the DB or not and if it has been whitelisted or not.
procedure TSSAForm.Button1Click(Sender: TObject);
begin
    fileWhitelisted('C:\Program Files\MSN Gaming Zone\Windows\bckgzm.exe');
end;

end.
