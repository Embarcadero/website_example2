program darkdash;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  forms.mainform in 'forms.mainform.pas' {Form1},
  modules.dm1 in 'modules.dm1.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
