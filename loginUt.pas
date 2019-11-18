unit loginUt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, FMX.Controls.Presentation, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client, REST.Authenticator.OAuth;

type
  TloginFrm = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    Rectangle1: TRectangle;
    Text1: TText;
    Edit1: TEdit;
    Edit2: TEdit;
    Rectangle2: TRectangle;
    Text2: TText;
    CheckBox1: TCheckBox;
    Text3: TText;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    Rectangle7: TRectangle;
    Rectangle8: TRectangle;
    Rectangle9: TRectangle;
    OAuth2Authenticator1: TOAuth2Authenticator;
    Text4: TText;
    procedure Rectangle5Click(Sender: TObject);
    procedure Edit1CanFocus(Sender: TObject; var ACanFocus: Boolean);
    procedure Edit1Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  loginFrm: TloginFrm;

implementation

{$R *.fmx}

procedure TloginFrm.Edit1CanFocus(Sender: TObject; var ACanFocus: Boolean);
begin
 // ShowMessage('a');
end;

procedure TloginFrm.Edit1Enter(Sender: TObject);
begin
    // ShowMessage('a');
end;

procedure TloginFrm.Rectangle5Click(Sender: TObject);
begin
    ShowMessage('微信登录功能正在开发中。。。');
end;

end.
