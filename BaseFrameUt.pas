unit BaseFrameUt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls;

type
  TBaseFrame = class(TFrame)
    procedure FrameClick(Sender: TObject);
    procedure InitFrame;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TBaseFrame.FrameClick(Sender: TObject);
begin
 //ShowMessage(Self.Name);
end;
procedure TBaseFrame.InitFrame;
begin
  //
end;

end.
