unit FileRec;
{
This file contains a file record, used to store files pulled out of the database temporarily.
}
interface

uses
   SysUtils, Dialogs, Windows;

type
   TFileRec = Class(TObject)
   //private
   public
      getPath : String;
      getdirInfo : TSearchRec;
   public
      constructor Create(path: String; dirinfo: TSearchRec); overload;
end;

implementation

constructor TFileRec.Create(path: String; dirinfo: TSearchRec);
begin
    self.getpath := path;
    Self.getdirInfo := dirinfo;
end;
end.
 