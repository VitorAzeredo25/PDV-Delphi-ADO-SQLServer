program PDV_Padaria;

uses
  Vcl.Forms,
  Unit_Principal in 'Unit_Principal.pas' {Frm_Principal},
  Vcl.Themes,
  Vcl.Styles,
  uDm in 'uDm.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFrm_Principal, Frm_Principal);
  Application.Run;
end.
