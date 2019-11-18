program myPlan;

uses
  System.StartUpCopy,
  FMX.Forms,
  myPlanMain in 'myPlanMain.pas' {Form1},
  writeApen in 'writeApen.pas' {writeApenFrm},
  DataUt in 'DataUt.pas' {myPlanDataModule: TDataModule},
  loginUt in 'loginUt.pas' {loginFrm},
  mainUt in 'mainUt.pas' {mainForm},
  accountUt in 'accountUt.pas' {accountFrame: TFrame},
  BaseFrameUt in 'BaseFrameUt.pas' {BaseFrame: TFrame},
  HistoryFrameUt in 'HistoryFrameUt.pas' {HistoryFrame: TFrame},
  PieFrameUt in 'PieFrameUt.pas' {PieFrame: TFrame},
  SettingFrameUt in 'SettingFrameUt.pas' {SettingFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TmyPlanDataModule, myPlanDataModule);
  //Application.CreateForm(TForm1, Form1);
  //Application.CreateForm(TloginFrm, loginFrm);
  Application.CreateForm(TmainForm, mainForm);
  // Application.CreateForm(TwriteApenFrm, writeApenFrm);
  Application.Run;
end.
