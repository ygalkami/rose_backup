unit Login;
{
This unit contains the code for logging into the interface
}
interface

uses
  Windows, Messages, SysUtils,  Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls,
  Database, Hash, Db, ACRMain;

type
  TLoginForm = class(TForm)
    UserNameEdit: TEdit;
    PasswordEdit: TEdit;
    PasswordLabel: TLabel;
    PasswordButton: TButton;
    UserNameLabel: TLabel;
    getUserHashQuery: TACRQuery;
    procedure PasswordButtonClick(Sender: TObject);
  public
    class function Execute : boolean;
  private
    procedure LoginInit();
  end;

var  LoginForm: TLoginForm;
     SSA_DB  : TDBModule; // you need an instance of the DB module
     HashObj : THashModule; // you need an instance of the Hash module
     //note that these instances are created when the project file creates
     //the forms/modules. All we need to do is ask for a reference to the
     //objects. (they are singletons)

implementation

{$R *.dfm}
procedure TLoginForm.LoginInit();
Begin
  HashObj := THashModule.GetInstance(); //returns the singleton object
  SSA_DB  := TDBModule.GetInstance(); //returns the singleton object
  //now our objects are initialized, so you have access to the DB and Hashing
end;

class function TLoginForm.Execute: boolean;
begin
  //since this is a class function (static) there is no implicit object reference
  //we need to get an object (LoginForm) and call its (private) instance method
  LoginForm.LoginInit();
  with TLoginForm.Create(nil) do
  try
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

//Attempt to login with the given credentials
procedure TLoginForm.PasswordButtonClick(Sender: TObject) ;
var
    hashedPassword : String;
    dbhash : Variant;
begin
  //hash given password, and retrieve password hash from db
  hashedPassword := HashObj.HashPassword(passwordEdit.Text);
  dbhash:= SSA_DB.getUserHash(UserNameEdit.text);

  if (vartype(dbhash) and VarTypeMask) <> varString then
  Begin
     MessageDlg('Invalid username/password combination.', mtInformation, [mbOk], 0);
     ModalResult := mrAbort;
  end
  else
  Begin
     //compare two hashes
     if hashedPassword = dbhash then
     Begin
       ModalResult := mrOK;
     end
     else
     Begin
       ModalResult := mrAbort;
     end;
  end;
end;

end.
