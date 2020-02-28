unit DataUt;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet,FMX.Dialogs,System.IOUtils,DateUtils;

type
  TmyPlanDataModule = class(TDataModule)
    BaseConnection: TFDConnection;
    myPlanQuery1: TFDQuery;
    tableInit: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    function toDayPay(): String;  //今日支出
    function toMonthExpendAndIncome(Out expend:double;Out income:double): string;  //本月支出和收入

  private
    { Private declarations }
    procedure MonthsSettingInit;//预算表初始化,数据库初始化或者每一个月起始需要新增一条数据

    procedure PlanToMonthData;  //把Plan中的月收入，支出的数据同步到MonthsSetting中

    procedure MonthsUpdate(value: double; types : Integer);//1预算2支出3收入 每往日计划表里插入一条数据 ，必须再月计划表中累加统计
  public
    { Public declarations }
    procedure writeLog(logStr:string);
  end;

var
  myPlanDataModule: TmyPlanDataModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TmyPlanDataModule.DataModuleCreate(Sender: TObject);
var sPath,s,ss: String;
begin
   {$IFDEF Android}
    sPath := TPath.GetDownloadsPath;
    s := TPath.GetHomePath;
    ss := TPath.GetTempPath;
    BaseConnection.Params.Values['DataBase'] := TPath.Combine(sPath,'cenPlan.sdb');
   {$ENDIF}
   {$IFDEF MSWINDOWS}
    BaseConnection.Params.Values['DataBase'] := TPath.Combine('\..\','cenPlan.sdb');
  //BaseConnection.Params.Values['DataBase'] := TPath.Combine('C:\Users\76367\Desktop\新建文件夹','cenPlan.sdb');
   {$ENDIF}
   try
      BaseConnection.Connected := True;
      tableInit.ExecSQL;
      MonthsSettingInit;
   except on e : Exception do
     ShowMessage('数据库连接失败');
   end;

end;


function TmyPlanDataModule.toMonthExpendAndIncome(Out expend:double;Out income:double): string;
var sqlStr:   string;
  startDay,endDay: string;
  I: Integer;
begin

   //
  startDay := FormatDateTime('yyyy-mm-dd HH:mm:ss',StartOfTheMonth(Now));
  //
  endDay := FormatDateTime('yyyy-mm-dd HH:mm:ss',EndOfTheMonth(Now));
  sqlStr := 'select classify,sum(money) as m from Plan where plan_time between ''%0:S'' and ''%1:S'' group by classify';
  sqlStr := Format(sqlStr,[startDay,endDay]);
  myPlanQuery1.SQL.Clear;
  myPlanQuery1.SQL.Add(sqlStr);
  myPlanQuery1.Open;
  if myPlanQuery1.RecordCount<=0 then
  begin
   expend := 0;
   income := 0;
  end
  else if myPlanQuery1.RecordCount=1 then
  begin
    case myPlanQuery1.FieldByName('classify').AsInteger of
      0 : begin
            expend := 0;
            income := myPlanQuery1.FieldByName('m').AsFloat;
          end;
      1 : begin
            income := 0;
            expend := myPlanQuery1.FieldByName('m').AsFloat;
          end;
    end;
  end
  else
  begin
      myPlanQuery1.First;
      while not myPlanQuery1.Eof do
      begin
      case myPlanQuery1.FieldByName('classify').AsInteger of
      0 : begin
            income := myPlanQuery1.FieldByName('m').AsFloat;
          end;
      1 : begin
            expend := myPlanQuery1.FieldByName('m').AsFloat;
          end;
      end;
      myPlanQuery1.Next;
      end;
  end;
  Result := 'a';
end;


function TmyPlanDataModule.toDayPay(): string;
var sqlStr,str:String;
    today,startTime,endTime:String;
begin
   today := FormatDateTime('yyyy-mm-dd',now);
   startTime := today + ' 00:00:00';
   endTime   := toDay + ' 23:59:59';
   sqlStr := 'select sum(money) as todayPay from Plan where classify=1 and del=0 and plan_time between ''%0:S'' and ''%1:S''';
   sqlStr := Format(sqlStr,[startTime,endTime]);
   myPlanQuery1.SQL.Clear;
   myPlanQuery1.SQL.Add(sqlStr);
   myPlanQuery1.Open;
  if not SameText(myPlanQuery1.FieldByName('todayPay').AsString,'') then
   Result := myPlanQuery1.FieldByName('todayPay').AsString
   else
   begin
     Result := '0';
   end;
end;


procedure TmyPlanDataModule.MonthsSettingInit;
var sqlStr:String;
    toMonth,toYear,toTime:string;
begin
  toMonth := FormatDateTime('mm',now);
   toYear := FormatDateTime('yyyy',now);
   toTime := FormatDateTime('yyyy-mm-dd HH:mm:ss',now);
   sqlStr := 'select * from MonthsSetting where del=0 and year=''%0:S'' and month=''%1:S''' ;
   sqlStr := Format(sqlStr,[toYear,toMonth]);
   myPlanQuery1.SQL.Clear;
   myPlanQuery1.SQL.Add(sqlStr);
   myPlanQuery1.Open;
   if myPlanQuery1.RecordCount <= 0 then
   begin
     sqlStr := 'insert into MonthsSetting(year,month,budget,income,expend,bz,del,status,create_time,plan_time)'+
     'values(''%0:S'',''%1:S'',500,0,0,''自动生成'',0,1,''%2:S'',''%2:S'')';
     sqlStr := Format(sqlStr,[toYear,toMonth,toTime]);
     myPlanQuery1.SQL.Clear;
     myPlanQuery1.SQL.Add(sqlStr);
     myPlanQuery1.ExecSQL;
   end;
end;

procedure TmyPlanDataModule.PlanToMonthData;
var sqlStr : String;
begin
  //
sqlStr := 'select year,month,sum(budget) as budget,sum(income) as income ,sum(expend) as expend from MonthsSetting '+
          ' where del=0 and year=''2019'' group by month';
     with myPlanQuery1 do
     begin
       SQL.Clear;
       SQL.Add(sqlStr);
       Open;
       First;
       while not Eof do
       begin

       end;
     end;
end;

procedure TmyPlanDataModule.MonthsUpdate(value: Double; types: Integer);
var sqlStr: string;
    toMonth,toYear,toTime:string;
begin
   toMonth := FormatDateTime('mm',now);
   toYear  := FormatDateTime('yyyy',now);
   toTime  := FormatDateTime('yyyy-mm-dd HH:mm:ss',now);
   case types of
       1: begin   //预算数据有变
            sqlStr := 'Update MonthsSetting Set budget = %0:D Where year = ''%1:S'' and month = ''%2:S''';
          end;
       2: begin  //支出数据 新增
            sqlStr := 'Update MonthsSetting Set expend = expend+%0:D Where year = ''%1:S'' and month = ''%2:S''';
          end;
       3: begin  //收入数据 新增
            sqlStr := 'Update MonthsSetting Set income = income+%0:D Where year = ''%1:S'' and month = ''%2:S''';
          end;
   end;

   with myPlanQuery1 do
   begin
     SQL.Clear;
     SQL.Add(sqlStr);
     ExecSQL;
   end;

end;
procedure TmyPlanDataModule.writeLog(logStr: string);
begin
  //
end;
end.
