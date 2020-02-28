unit writeApen;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.DateTimeCtrls, FMX.ScrollBox, FMX.Memo, FMX.Objects, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.EditBox, FMX.NumberBox;

type
  TwriteApenFrm = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    Text1: TText;
    SpeedButton2: TSpeedButton;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Text2: TText;
    Text3: TText;
    Text4: TText;
    Text5: TText;
    Edit1: TEdit;
    Memo1: TMemo;
    DateEdit1: TDateEdit;
    TimeEdit1: TTimeEdit;
    Rectangle2: TRectangle;
    Text6: TText;
    Text7: TText;
    Text8: TText;
    Text9: TText;
    NumberBox1: TNumberBox;
    Rectangle3: TRectangle;
    Text10: TText;
    procedure Text6Click(Sender: TObject);
    procedure Text8Click(Sender: TObject);
    procedure Text9Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  writeApenFrm: TwriteApenFrm;

implementation
 uses mainUt,DataUt;
{$R *.fmx}

procedure TwriteApenFrm.FormCreate(Sender: TObject);
begin
   TimeEdit1.UseNowTime := True;
end;

procedure TwriteApenFrm.FormShow(Sender: TObject);
begin
   TimeEdit1.UseNowTime :=False;
end;

procedure TwriteApenFrm.SpeedButton1Click(Sender: TObject);
begin
  {$IFDEF Android}
    // Form1.initPlan;
    mainForm.Show;          //todo ����showû����ִ��Show����������Ϊ֮ǰû�йرգ�
  {$ENDIF}
end;

procedure TwriteApenFrm.Text6Click(Sender: TObject);
var sqlStr : String;
   checked,msid:Integer;
    dateStr,timeStr,toyear,tomonth:string;
begin
//
  checked := 0;
  if (Text8.Tag=0) and (Text9.Tag=0) then
  begin
    ShowMessage('�㻹δѡ��֧��������');
    Exit;
  end;
 if Text8.Tag=1 then     //֧��
  checked := 1;

 //����֮ǰȡmsid
  toyear := FormatDateTime('yyyy',DateEdit1.DateTime);
  tomonth := FormatDateTime('mm',DateEdit1.DateTime);

  sqlStr := 'select id from MonthsSetting where del = 0 and year = ''%0:S'' and month = ''%1:S''';
  sqlStr := Format(sqlStr,[toyear,tomonth]);
  with myPlanDataModule.myPlanQuery1 do
  begin
    SQl.Clear;
    SQL.Add(sqlStr);
    Open;
    if RecordCount <= 0 then
    begin
      msid := 0;
    end
    else
    begin
      msid := FieldByName('id').AsInteger;
    end;
  end;



 sqlStr := 'insert into Plan (name,classify,money,bz,del,plan_time,create_time,msid)'+
           'values(''%0:S'',%1:D,%2:D,''%3:S'',%4:D,''%5:S'',''%6:S'',%7:D)';
 dateStr := FormatDateTime('yyyy-mm-dd',DateEdit1.DateTime);
 timeStr := FormatDateTime('HH:mm:ss',TimeEdit1.DateTime);
 sqlStr := Format(sqlStr,
 [Edit1.Text,checked,NumberBox1.Text.ToInteger,Memo1.Text,0,dateStr+' '+timeStr,FormatDateTime('yyyy-mm-dd HH:mm:ss',now),msid]);
 myPlanDataModule.myPlanQuery1.SQL.Clear;
 myPlanDataModule.myPlanQuery1.SQL.Add(sqlStr);
 myPlanDataModule.myPlanQuery1.ExecSQL;
 ShowMessage('����ɹ�');
end;

procedure TwriteApenFrm.Text8Click(Sender: TObject);
begin
   Text8.TextSettings.FontColor :=  TAlphaColorRec.Chartreuse;
   Text9.TextSettings.FontColor :=  TAlphaColorRec.Black;
   Text8.Tag := 1;
   Text9.Tag := 0;
end;

procedure TwriteApenFrm.Text9Click(Sender: TObject);
begin
   Text9.TextSettings.FontColor :=  TAlphaColorRec.Chartreuse;
   Text8.TextSettings.FontColor :=  TAlphaColorRec.Black;
   Text9.Tag := 1;
   Text8.Tag := 0;
end;

end.
