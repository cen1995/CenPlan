unit mainUt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls,accountUt,HistoryFrameUt,PieFrameUt,SettingFrameUt,
  FMX.Objects, System.ImageList, FMX.ImgList;

type
  TmainForm = class(TForm)
    frameLayout: TLayout;
    StyleBook1: TStyleBook;
    bodyLayout: TLayout;
    Rectangle1: TRectangle;
    r1: TRectangle;
    t1: TText;
    Rectangle3: TRectangle;
    r3: TRectangle;
    t3: TText;
    Rectangle5: TRectangle;
    r4: TRectangle;
    t4: TText;
    Rectangle7: TRectangle;
    r2: TRectangle;
    t2: TText;
    ImageList1: TImageList;
    ImageList2: TImageList;
    procedure frameClick(Sender: TObject);
    procedure frameShow(iframe: byte);
    procedure FormCreate(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mainForm: TmainForm;
  accountFrame: TaccountFrame;
  HistoryFrame: THistoryFrame;
  PieFrame: TPieFrame;
  SettingFrame: TSettingFrame;
  lastFrame: Byte;
implementation

{$R *.fmx}

procedure TmainForm.FormCreate(Sender: TObject);
begin
    accountFrame := TaccountFrame.Create(nil);
    HistoryFrame := THistoryFrame.Create(nil);
        PieFrame := TPieFrame.Create(nil);
    SettingFrame := TSettingFrame.Create(nil);
end;

procedure TmainForm.frameClick(Sender: TObject);
var
  I: Integer;
  a: TSizeF;
  s:string;
begin
   //
     a.cx := 32;
     a.cy := 32;
     for I := 1 to 4 do
     begin
       if I = TRectangle(Sender).Tag then
       begin
         // TRectangle(Sender).Fill.Bitmap.Bitmap.CreateFromFile('D:\下载资源\icon\wx\16\tuichu.png');
          TRectangle(Sender).Fill.Bitmap.Bitmap := ImageList1.Bitmap(a,I-1);

       end
       else
       begin
          case I of
            1 : begin
                  r1.Fill.Bitmap.Bitmap := ImageList2.Bitmap(a,I-1);

                 // t1.TextSettings.FontColor := TAlphaColorRec.Yellow;
                end;
            2 : begin
                  r2.Fill.Bitmap.Bitmap := ImageList2.Bitmap(a,I-1);

                //  t2.TextSettings.FontColor := TAlphaColorRec.Yellow;
                end;
            3 : begin
                  r3.Fill.Bitmap.Bitmap := ImageList2.Bitmap(a,I-1);
                 // t3.TextSettings.FontColor := TAlphaColorRec.Yellow;
                end;
            4 : begin
                  r4.Fill.Bitmap.Bitmap := ImageList2.Bitmap(a,I-1);
                //  t4.TextSettings.FontColor := TAlphaColorRec.Yellow;
                end;
          end;
       end;

     end;

 //  for I := 0 to frameLayout.ChildrenCount-1 do
  // begin
   //   if frameLayout.Children[I].Tag =TRectangle(Sender).Tag then
   //   begin
       // TRectangle(Sender).StyleLookup := 'bs1s';
     //      TRectangle(Sender).Fill.Bitmap.Bitmap.CreateFromFile('D:\下载资源\icon\wx\16\tuichu.png');
   //   end
   //   else
   //   begin
        //(frameLayout.Children[I] as TButton).StyleLookup := 'bs1';
   //   end;

  // end;
   frameShow(TRectangle(Sender).Tag);
end;


procedure TmainForm.frameShow(iframe: Byte);
begin
  //bodyLayout.Children.
  case iframe of
    1: begin
       if accountFrame=nil then
          accountFrame := TaccountFrame.Create(nil);
          accountFrame.initPlan;
         HistoryFrame.Parent := nil;
         PieFrame.Parent := nil;
         SettingFrame.Parent := nil;
         accountFrame.Height := bodyLayout.Height;
         accountFrame.Width  := bodyLayout.Width;
         accountFrame.Parent := bodyLayout;
    end;
    2: begin
       if HistoryFrame = nil then
          HistoryFrame := THistoryFrame.Create(nil);
          HistoryFrame.InitFrame;
          accountFrame.Parent := nil;
          PieFrame.Parent := nil;
          SettingFrame.Parent := nil;
          HistoryFrame.Height := bodyLayout.Height;
          HistoryFrame.Width  := bodyLayout.Width;
          HistoryFrame.Parent := bodyLayout;
    end;
    3: begin
       if PieFrame = nil then
          PieFrame := TPieFrame.Create(nil);

          accountFrame.Parent := nil;
          HistoryFrame.Parent := nil;
          SettingFrame.Parent := nil;
          PieFrame.Height := bodyLayout.Height;
          PieFrame.Width  := bodyLayout.Width;
          PieFrame.Parent := bodyLayout;
    end;
    4: begin
       if SettingFrame = nil then
          SettingFrame := TSettingFrame.Create(nil);

          accountFrame.Parent := nil;
          HistoryFrame.Parent := nil;
          PieFrame.Parent     := nil;
          SettingFrame.Height := bodyLayout.Height;
          SettingFrame.Width  := bodyLayout.Width;
          SettingFrame.Parent := bodyLayout;
    end;

  end;
end;
procedure TmainForm.Rectangle1Click(Sender: TObject);
begin
   ShowMessage('rectangle is click');
end;

end.
