unit Hash;
{
This unit contains all of the code necessary for hashing files and strings (passwords).
}
interface

uses
  SysUtils, Forms, Dialogs, Classes, LbCipher, LbUtils, LbClass;

type
  THashModule = class(TDataModule)

  private
    { Private declarations }
    SHA1Inst: TLbSHA1;
    SHA1Digest : TSHA1Digest;
  public
    { Public declarations }
    class function GetInstance():THashModule;
    function HashPassword(pass:String):String;
    function HashFile(path:String):String;
  end;
var
  HashModule: THashModule;

implementation

{$R *.DFM}
//Just like the Database class, this class has a static GetInstance method which returns the single instance of the Hash data module.
class function THashModule.GetInstance(): THashModule;
Begin
   if HashModule.SHA1Inst = nil then
   Begin
      //Since SHA1Inst is private, it is not created automatically when the module is created. We only create it once. It is not freed later on, should it be?
      HashModule.SHA1Inst:=TLbSHA1.Create(nil);
   end;
   GetInstance:=HashModule;
end;

function THashModule.HashPassword(pass:String):String;
Begin
   SHA1Inst.HashString(pass);
   SHA1Inst.GetDigest(SHA1Digest);
   HashPassword := BufferToHex(SHA1Digest, SizeOf(SHA1Digest));
end;

function THashModule.HashFile(path:String):String;
Begin
   SHA1Inst.HashFile(path);
   SHA1Inst.GetDigest(SHA1Digest);
   HashFile := BufferToHex(SHA1Digest, SizeOf(SHA1Digest));
end;

end.
