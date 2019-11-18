unit PieFrameUt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  BaseFrameUt, FMX.Controls.Presentation, FMXTee.Engine, FMXTee.Procs,
  FMXTee.Chart;

type
  TPieFrame = class(TBaseFrame)
    Button1: TButton;
    Chart1: TChart;
   procedure InitFrame;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PieFrame: TPieFrame;

implementation

{$R *.fmx}
 procedure TPieFrame.InitFrame;
 begin
  //
 end;
end.
