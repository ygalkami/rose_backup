program SSA_Project;
{starts the program}
uses
  Forms,
  Main in 'Main.pas' {SSAForm},
  Audit in 'Audit.pas' {AuditForm},
  FileRec in 'FileRec.pas',
  Login in 'Login.pas' {LoginForm},
  Database in 'Database.pas' {DBModule: TDataModule},
  Hash in 'Hash.pas' {HashModule: TDataModule},
  Monitor in 'Monitor.pas',
  Pickle in 'Pickle.pas';

{$R *.RES}
var loginAttempts:Integer;
begin
  Application.Initialize;
  //MUST create this first, both are needed to log in.
  Application.CreateForm(THashModule, HashModule);
  Application.CreateForm(TDBModule, DBModule);
  loginAttempts:=0;
  //allow three login attempts
  while loginAttempts < 3 do
  Begin
    if not TLoginForm.Execute then
    Begin
      loginAttempts := loginAttempts+1;
    end
    else
    Begin
      Break;
    end;
  end;
  if loginAttempts = 3 then
  Begin
     Application.terminate();
  end
  else
  Begin
    //I put these in the 'else' block. If I don't, the forms tend to flash for an instant when Application.Terminate is called.
    Application.CreateForm(TSSAForm, SSAForm);
    Application.CreateForm(TAuditForm, AuditForm);
    Application.Run;
  end;
end.
