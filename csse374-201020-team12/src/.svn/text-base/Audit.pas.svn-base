unit Audit;
{
This form appears when you click "Scan System" on the main GUI. It handles scanning the system and whitelisting/blacklisting files.
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Db, ACRMain, CheckLst, FileRec, Database;

type
  TAuditForm = class(TForm)
    SelectAll: TButton;
    CheckListBox1: TCheckListBox;
    DeSelectAll: TButton;
    addToDB: TButton;
    procedure SelectAllClick(Sender: TObject);
    procedure DeSelectAllClick(Sender: TObject);
    procedure addToDBClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AuditForm: TAuditForm;
  SSA_DB    : TDBModule;

implementation

{$R *.DFM}
//Select all files in the list
procedure TAuditForm.SelectAllClick(Sender: TObject);
var
   Count : Integer;
begin
for
count := 0 to CheckListBox1.Items.Count - 1 do
begin
    CheckListBox1.Checked[Count] := true;
end;
end;

//Unselect all files in the list
procedure TAuditForm.DeSelectAllClick(Sender: TObject);
var
   Count : Integer;
begin
for
count := 0 to CheckListBox1.Items.Count - 1 do
begin
    CheckListBox1.Checked[Count] := false;
end;
end;

//Add all the files to the db, set the whitelisted field based
//on whether the file is checked or not
procedure TAuditForm.addToDBClick(Sender: TObject);
var
   Count : Integer;
   Temp : TFileRec;
begin
   SSA_DB:=TDBModule.GetInstance();
   for count := 0 to CheckListBox1.Items.Count - 1 do
   begin
      //The list stores objects as TObjects, cast to TFileRec
      Temp := CheckListBox1.Items.Objects[Count] as TFileRec;

      if CheckListBox1.Checked[Count] = true then
      Begin
        SSA_DB.InsertToFileTable(Temp, true);
      end
      else SSA_DB.InsertToFileTable(Temp, false);
   end;
   //clears the box so the next time this form appears, it will be empty
   CheckListBox1.Clear();
   AuditForm.Close;
end;

end.
