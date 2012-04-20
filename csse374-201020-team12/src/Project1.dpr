program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {SSAForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TSSAForm, SSAForm);
  Application.Run;
end.
