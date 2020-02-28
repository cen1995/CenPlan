unit accountUt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,Math,DateUtils,
  System.ImageList, FMX.ImgList;

type
  TaccountFrame = class(TFrame)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    expendLab: TLabel;
    incomeLab: TLabel;
    budgetLab: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Circle1: TCircle;
    Text1: TText;
    ListView1: TListView;
    ImageList2: TImageList;
    ProgressBar2: TProgressBar;
    procedure initPlan;
    procedure Text1Click(Sender: TObject);
  private
    { Private declarations }
    function setMoney(tag: Integer; money: Double): string;
    procedure getList;
  public
    { Public declarations }
  end;

implementation
uses DataUt,writeApen;
{$R *.fmx}

//
procedure TaccountFrame.initPlan;
var sqlStr,year,month,ss: string;
    expend,income: double;
begin
   ListView1.Items.Clear;
   getList;  //今日支出收入列表
  //今日支出
  Label6.Text := myPlanDataModule.toDayPay;
  //本月支出 本月收入
  myPlanDataModule.toMonthExpendAndIncome(expend,income);
  expendLab.Text := expend.ToString;
  incomeLab.Text := income.ToString;

  //本月预算
  year := FormatDateTime('yyyy',now);
  month := FormatDateTime('mm',now);
  sqlStr := 'select * from MonthsSetting where del=0 and year=''%0:S'' and month=''%1:S''';
  sqlStr := Format(sqlStr,[year,month]);
  with myPlanDataModule.myPlanQuery1 do
  begin
    SQL.Clear;
    SQL.Add(sqlStr);
    Open;
    if RecordCount>0 then
    begin
       if FieldByName('budget').AsFloat>0 then
       begin
         budgetLab.Text := FieldByName('budget').AsFloat.ToString;
         //本月可用 = 本月预算-本月支出
         //ProgressBar1.Value := (FieldByName('expend').AsInteger*100) div FieldByName('budget').AsInteger;
           ProgressBar1.Value := (expend.ToString.ToInteger*100) div FieldByName('budget').AsInteger;
            ProgressBar2.Value := (expend.ToString.ToInteger*100) div FieldByName('budget').AsInteger;
         //Label10.Text := (FieldByName('budget').AsInteger- FieldByName('expend').AsInteger).ToString;
          Label10.Text := (FieldByName('budget').AsInteger- expend).ToString;
       end
       else
       begin
         budgetLab.Text := '0';
       end;
      // incomeLab.Text := FieldByName('income').AsString;
      // expendLab.Text := FieldByName('expend').AsFloat.ToString;
    end
    else
    begin
       budgetLab.Text := '0';
      // incomeLab.Text := '0';
     //  expendLab.Text := '0';
       ProgressBar1.Value := 0;
    end;
  end;
end;

//
procedure TaccountFrame.getList;
var sqlStr,nowTime:string;
    AItem : TListViewItem;
    PID:Integer;
  I: Integer;
begin
  Randomize;
  nowTime := FormatDateTime('yyyy-mm-dd',now);
  AItem := ListView1.Items.Add;
  AItem.Data['Text3'] := nowTime;
  sqlStr := 'select * from Plan where classify=1 and del=0 And plan_time between ''%0:S'' And ''%1:S''';
  sqlStr := Format(sqlStr,[nowTime+' 00:00:00',nowTime+' 23:59:59']);

  with myPlanDataModule.myPlanQuery1 do
  begin
    SQL.Clear;
    SQL.Add(sqlStr);
    Open;
    First;
    while not Eof do
    begin
      AItem := ListView1.Items.Add;
      PID := FieldByName('id').AsInteger;
      AItem.Data['Text1'] := FieldByName('name').AsString;
      AItem.Data['Text3'] := FieldByName('bz').AsString;
      AItem.Data['Text4'] :=
             setMoney(FieldByName('classify').AsInteger,FieldByName('money').AsFloat);
      AItem.Data['Text5'] := FormatDateTime('HH:mm',FieldByName('plan_time').AsDateTime);
      AItem.Data['Image2'] := Random(4);
      Next;
    end;
  end;
end;

//
 function TaccountFrame.setMoney(tag: Integer; money: Double): string;
begin
  if tag =1 then //支出
  begin
    Result := '- '+money.ToString;
  end
  else if tag = 0 then   //收入
  begin
    Result := '+ '+money.ToString;
  end
  else
  begin
    Result := '? '+money.ToString;
  end;
end;
procedure TaccountFrame.Text1Click(Sender: TObject);
begin
    //跳转到记一笔页面
   if not Assigned(writeApenFrm) then
   begin
    writeApenFrm := TwriteApenFrm.Create(nil);
   end;
   {$IFDEF MSWINDOWS}
   writeApenFrm.ShowModal;
   {$ENDIF}
   {$IFDEF Android}
    // Form1.Close;
     writeApenFrm.Show;
   {$ENDIF}
   //todo 我自己声明的变量writeApenFrm_01一开始就不为nil ?
end;

end.
