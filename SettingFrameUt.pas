unit SettingFrameUt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  BaseFrameUt, FMX.Objects, FMX.Layouts;

type
  TSettingFrame = class(TBaseFrame)
    VertScrollBox1: TVertScrollBox;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    Layout3: TLayout;
    Circle2: TCircle;
    Circle3: TCircle;
    Text3: TText;
    Rectangle3: TRectangle;
    Text4: TText;
    Text5: TText;
    Text6: TText;
    Text7: TText;
    Text8: TText;
    Text9: TText;
    Text10: TText;
    Text11: TText;
    Rectangle1: TRectangle;
    Line1: TLine;
    GridPanelLayout1: TGridPanelLayout;
    Layout1: TLayout;
    Text1: TText;
    Rectangle4: TRectangle;
    Image1: TImage;
    Text2: TText;
    Rectangle5: TRectangle;
    Image2: TImage;
    Text12: TText;
    Rectangle6: TRectangle;
    Image3: TImage;
    Text13: TText;
    Rectangle7: TRectangle;
    Image4: TImage;
    Text14: TText;
    Rectangle8: TRectangle;
    Image5: TImage;
    Text15: TText;
    Rectangle9: TRectangle;
    Image6: TImage;
    Text16: TText;
    Rectangle10: TRectangle;
    Image7: TImage;
    Text17: TText;
    Rectangle11: TRectangle;
    Image8: TImage;
    Text18: TText;
    Rectangle12: TRectangle;
    Image9: TImage;
    Text19: TText;
    Rectangle13: TRectangle;
    Image10: TImage;
    Text20: TText;
    Rectangle14: TRectangle;
    Image11: TImage;
    Text21: TText;
    Rectangle15: TRectangle;
    Image12: TImage;
    Text22: TText;
    Line2: TLine;
    Layout4: TLayout;
    Text23: TText;
    GridPanelLayout2: TGridPanelLayout;
    Rectangle16: TRectangle;
    Image13: TImage;
    Text24: TText;
    Rectangle17: TRectangle;
    Image14: TImage;
    Text25: TText;
    Rectangle18: TRectangle;
    Image15: TImage;
    Text26: TText;
    Rectangle19: TRectangle;
    Image16: TImage;
    Text27: TText;
    Rectangle20: TRectangle;
    Image17: TImage;
    Text28: TText;
    Rectangle21: TRectangle;
    Image18: TImage;
    Text29: TText;
    Rectangle22: TRectangle;
    Image19: TImage;
    Text30: TText;
    Rectangle23: TRectangle;
    Image20: TImage;
    Text31: TText;
    Rectangle24: TRectangle;
    Image21: TImage;
    Text32: TText;
    Rectangle25: TRectangle;
    Image22: TImage;
    Text33: TText;
    procedure Circle3Click(Sender: TObject);
    procedure InitFrame;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SettingFrame: TSettingFrame;

implementation
 uses loginUt;
{$R *.fmx}

procedure TSettingFrame.Circle3Click(Sender: TObject);
begin
  inherited;
  if not Assigned(loginFrm) then
  loginFrm := TloginFrm.Create(nil);

    {$IFDEF Android}
   loginFrm.Show;
   {$ENDIF}
   {$IFDEF MSWINDOWS}
     loginFrm.ShowModal;
   {$ENDIF}
end;
procedure TSettingFrame.InitFrame;
begin
  //
end;
end.
