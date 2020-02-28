unit HistoryFrameUt;
 {
    历史数据列表




 }
interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  BaseFrameUt, FMX.Controls.Presentation, FMX.ListBox, FMX.Edit, FMX.SearchBox,
  FMX.Layouts, FMX.Objects;

type
  THistoryFrame = class(TBaseFrame)
    Rectangle1: TRectangle;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure InitFrame;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HistoryFrame: THistoryFrame;

implementation
uses DataUt;
{$R *.fmx}
procedure THistoryFrame.Button1Click(Sender: TObject);
var
  I: Integer;
  AItem: TListBoxItem;
begin
  inherited;
  ListBox1.Clear;
  for I := 0 to 11 do
  begin
    AItem := TListBoxItem.Create(nil);
    AItem.Parent := ListBox1;
    AItem.StyleLookup := 'cenListBoxStyle1';
    AItem.Text := 'Aitem'+I.ToString;
    AItem.StylesData['Text1Style'] := I.ToString+'月';
    AItem.StylesData['Text2Style'] := '2019年';
    AItem.StylesData['Text3Style'] := '-3000';
    AItem.StylesData['Text4Style'] := '收入0';
    AItem.StylesData['Text5Style'] := '结余';
    AItem.StylesData['Text6Style'] := '支出3000';
   //  Item.StylesData['visible.OnChange'] := TValue.From<TNotifyEvent>(DoVisibleChange); // set OnChange value
  //Item.StylesData['info.OnClick'] := TValue.From<TNotifyEvent>(DoInfoClick); // set OnClick value
  end;
end;

procedure THistoryFrame.InitFrame;
var sqlStr: String;
    AItem: TListBoxItem;
begin
  //   2019
  ListBox1.Items.Clear;
  //sqlStr := 'select year,month,sum(budget) as budget,sum(income) as income ,sum(expend) as expend from MonthsSetting '+
  //       ' where del=0 and year=''2019'' group by month';
  sqlStr := 'select m.year,m.month,m.budget,sum(p.money) as expend,p.classify from  Plan p '+
            ' left join MonthsSetting m ' +
            ' where m.del = 0 and p.del = 0 and p.classify = 1 and m.id = p.msid group by m.year,m.month' +
            ' order by year desc ';
  with  myPlanDataModule.myPlanQuery1 do
  begin
     SQL.Clear;
     SQL.Add(sqlStr);
     Open;
     First;
     while not Eof do
     begin
        AItem := TListBoxItem.Create(nil);
        AItem.Parent := ListBox1;
        AItem.StyleLookup := 'cenListBoxStyle1';
        AItem.StylesData['Text1Style'] := FieldByName('month').AsString+'月';
        AItem.StylesData['Text2Style'] := FieldByName('year').AsString+'年';
        AItem.StylesData['Text3Style'] := FieldByName('budget').AsString;
        AItem.StylesData['Text4Style'] := '收入'+'--';
        AItem.StylesData['Text5Style'] := '结余';
        AItem.StylesData['Text6Style'] := '支出'+FieldByName('expend').AsString;
        Next;
     end;
  end;
end;
end.
