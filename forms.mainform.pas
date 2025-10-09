unit forms.mainform;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Controls.Presentation, System.ImageList, FMX.ImgList,
  FMX.Objects, FMX.Effects, FMX.Layouts, FMX.Filter.Effects, FMXTee.Series,
  FMXTee.Engine, FMXTee.Procs, FMXTee.Chart, FMX.Edit, System.Actions,
  FMX.ActnList;

type
  TForm1 = class(TForm)
    StyleBook1: TStyleBook;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    ImageList1: TImageList;
    TopPanel: TPanel;
    FilterPanel: TPanel;
    Label1: TLabel;
    CenterPanel: TPanel;
    Circle1: TCircle;
    Label2: TLabel;
    NewAutomationButton: TRoundRect;
    Label3: TLabel;
    NewAutomation: TImage;
    NewTemplateButton: TRoundRect;
    Label4: TLabel;
    Image2: TImage;
    RoundRect1: TRoundRect;
    Label5: TLabel;
    Image3: TImage;
    Line1: TLine;
    Rectangle1: TRectangle;
    Image4: TImage;
    RoundRect2: TRoundRect;
    Label7: TLabel;
    RoundRect3: TRoundRect;
    Label9: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    GridPanelLayout2: TGridPanelLayout;
    Panel1: TPanel;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Panel2: TPanel;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Panel3: TPanel;
    Rectangle6: TRectangle;
    Rectangle7: TRectangle;
    Panel4: TPanel;
    Rectangle8: TRectangle;
    Rectangle9: TRectangle;
    GridPanelLayout3: TGridPanelLayout;
    Panel5: TPanel;
    Rectangle10: TRectangle;
    Rectangle11: TRectangle;
    Panel6: TPanel;
    Rectangle12: TRectangle;
    Rectangle13: TRectangle;
    Panel7: TPanel;
    Rectangle14: TRectangle;
    Rectangle15: TRectangle;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Label8: TLabel;
    TotalIncomeLabel: TLabel;
    Image5: TImage;
    CircleTransitionEffect1: TCircleTransitionEffect;
    Image6: TImage;
    CircleTransitionEffect2: TCircleTransitionEffect;
    Label11: TLabel;
    InquirySuccessRateLabel: TLabel;
    Image7: TImage;
    CircleTransitionEffect3: TCircleTransitionEffect;
    Label13: TLabel;
    NumberOfNewClientsLabel: TLabel;
    Image8: TImage;
    CircleTransitionEffect4: TCircleTransitionEffect;
    Label15: TLabel;
    NumberOfCompletedProjectsLabel: TLabel;
    Label17: TLabel;
    Line2: TLine;
    Line3: TLine;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Chart1: TChart;
    Series1: TPieSeries;
    Chart4: TChart;
    PieSeries1: TPieSeries;
    Chart2: TChart;
    PieSeries2: TBarSeries;
    Chart5: TChart;
    ISBSeries: TBarSeries;
    Chart3: TChart;
    BarSeries2: TBarSeries;
    Chart6: TChart;
    Series2: TBarSeries;
    Series3: TBarSeries;
    Series4: TBarSeries;
    Rectangle16: TRectangle;
    Rectangle17: TRectangle;
    Rectangle18: TRectangle;
    Edit1: TEdit;
    Rectangle19: TRectangle;
    Rectangle20: TRectangle;
    Rectangle21: TRectangle;
    Rectangle22: TRectangle;
    ActionList1: TActionList;
    ZeroValuesAction: TAction;
    FillValuesAction: TAction;
    procedure FormActivate(Sender: TObject);
    procedure ZeroValuesActionExecute(Sender: TObject);
    procedure FillValuesActionExecute(Sender: TObject);
  private
    procedure UpdateStats;
    procedure ClearScreenValues;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses modules.dm1;

{ TForm1 }

procedure TForm1.ClearScreenValues;
begin
  TotalIncomeLabel.Text := '';
  InquirySuccessRateLabel.Text := '';
  NumberOfNewClientsLabel.Text := '';
  NumberOfCompletedProjectsLabel.Text := '';

  Chart1.Series[0].Clear;
  Chart2.Series[0].Clear;
  Chart3.Series[0].Clear;
  Chart4.Series[0].Clear;
  Chart5.Series[0].Clear;
  Chart6.Series[0].Clear;
  Chart6.Series[1].Clear;
  Chart6.Series[2].Clear;

  Chart1.Invalidate;
  Chart2.Invalidate;
  Chart3.Invalidate;
  Chart4.Invalidate;
  Chart5.Invalidate;
  Chart6.Invalidate;
end;

procedure TForm1.FillValuesActionExecute(Sender: TObject);
begin
  UpdateStats;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  if Tag = 0 then
  begin
    Tag := 1;
    ClearScreenValues;
    DataModule1.ActivateDatabase;
  end;
end;

procedure TForm1.UpdateStats;
begin
  TotalIncomeLabel.Text := '$250,000';
  InquirySuccessRateLabel.Text := '36.2%';
  NumberOfNewClientsLabel.Text := '217';
  NumberOfCompletedProjectsLabel.Text := '34';

  DataModule1.GetChartValues('CHART1', Chart1.Series[0], True);
  DataModule1.GetChartValues('CHART2', Chart2.Series[0], False);
  DataModule1.GetChartValues('CHART3', Chart3.Series[0], False);
  DataModule1.GetChartValues('CHART4', Chart4.Series[0], True);
  DataModule1.GetChartValues('CHART5', Chart5.Series[0], False);
  for var LLoop := 0 to 2 do
    DataModule1.GetChartValues('CHART6_' + LLoop.ToString, Chart6.Series[LLoop], False);

  Chart1.Invalidate;
  Chart2.Invalidate;
  Chart3.Invalidate;
  Chart4.Invalidate;
  Chart5.Invalidate;
  Chart6.Invalidate;
end;

procedure TForm1.ZeroValuesActionExecute(Sender: TObject);
begin
  DataModule1.CreateChartValues;
  ClearScreenValues;
end;

end.
