unit myPlanMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Layouts, FMX.TabControl, Data.Cloud.CloudAPI, Data.Cloud.AzureAPI,
  Data.Cloud.AmazonAPI, System.ImageList, FMX.ImgList,Math,DateUtils,
  FMX.DateTimeCtrls;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    expendLab: TLabel;
    incomeLab: TLabel;
    budgetLab: TLabel;
    Label10: TLabel;
    ProgressBar1: TProgressBar;
    Circle1: TCircle;
    Text1: TText;
    ListView1: TListView;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ToolBar2: TToolBar;
    Text2: TText;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    VertScrollBox1: TVertScrollBox;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    ToolBar1: TToolBar;
    Layout3: TLayout;
    Rectangle3: TRectangle;
    Circle2: TCircle;
    Text3: TText;
    Circle3: TCircle;
    Text4: TText;
    Text5: TText;
    Text6: TText;
    Text7: TText;
    Text8: TText;
    Text9: TText;
    Text10: TText;
    Text11: TText;
    StyleBook1: TStyleBook;
    procedure Text1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure getList;
    procedure initPlan;
    procedure Circle3DblClick(Sender: TObject);
  private
    { Private declarations }
    function setMoney(tag: Integer; money: Double): string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
 uses

 writeApen,DataUt;
{$R *.fmx}

procedure TForm1.Circle3DblClick(Sender: TObject);
begin
   ShowMessage('双击头像登录');
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 initPlan;
end;

procedure TForm1.Text1Click(Sender: TObject);
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


procedure TForm1.getList;
var sqlStr,nowTime:string;
    AItem : TListViewItem;
    PID:Integer;
begin
  Randomize;
  nowTime := FormatDateTime('yyyy-mm-dd',now);

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
      AItem.Data['Image2'] := Random(5);
      Next;
    end;
  end;
end;


procedure TForm1.initPlan;
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

  year := FormatDateTime('yyyy',now);
  month := FormatDateTime('mm',now);
  sqlStr := 'select * from MonthsSetting where del=0 and year=''%0:S'' and month=''%1:S''';
  sqlStr := Format(sqlStr,[year,month]);
  //本月预算
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


function TForm1.setMoney(tag: Integer; money: Double): string;
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
end.
