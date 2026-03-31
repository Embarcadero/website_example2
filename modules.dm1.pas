unit modules.dm1;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FMXTee.Engine, FMXTee.Chart, FireDAC.VCLUI.Wait, FireDAC.Phys.IBLiteDef;

type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDTable1: TFDTable;
    FDDeleteContents: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FMS: TFormatSettings;
    procedure CreateChartData(const TheTable: string; const WithLabels: Boolean; TheVals: array of Integer; TheLabels: array of string);
  public
    procedure ActivateDatabase;
    procedure GetChartValues(const TheTable: string; const TheSeries: TChartSeries; const WithLabels: boolean);
    procedure CreateChartValues;
  end;

var
  DataModule1: TDataModule1;

implementation
uses FMX.Dialogs;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

const
  ///////////////////////////////////////////////////////////////////////////////////
  //                                                                              ///
  // Change these values to match your own details - see the notes later though!  ///
  //                                                                              ///
  //  cDatabase  = 'c:\databases\IB_WEBINAR.IB';                                  ///
  cDatabase  = '..\..\data\IB_WEBINAR.IB';                                        ///
  cServer     = '127.0.0.1';                                                      ///
  cPort       = '3055';                                                           ///
  cUser_Name = 'SYSDBA';                                                          ///
  cPassword  = 'masterkey';                                                       ///
  //                                                                              ///
  ///////////////////////////////////////////////////////////////////////////////////



{ TDataModule1 }

procedure TDataModule1.ActivateDatabase;
begin
  if FDConnection1.Connected then exit;
  try
    var DBName: string := ExpandFileName(cDatabase);  // Necessary if the database is on a relative path like '../something/mydb.ib'
    if not FileExists(DBName) then
      ShowMessage('The database is not in the data folder!' + sLineBreak + sLineBreak + 'Should be here: "' + DBName + '"')
    else
      begin
        ///////////////////////////////////////////////////////////////////////////////////
        //                                                                              ///
        // You should NEVER do this in a production app - it would be VERY easy for     ///
        // someone to examine the strings in your app and get the database credentials! ///
        // We are doing this here for the sake of an easy/configurable demo             ///
        //                                                                              ///
        // You should either store it encrypted (and then decrypt it) or use techniques ///
        // like private encrypted environment variables or indeed anything other than   ///
        // plain text!                                                                  ///
        //                                                                              ///
        FDConnection1.Params.Clear;                                                     ///
        FDConnection1.Params.Add('DriverName=IB');                                      ///
        FDConnection1.Params.Add('DriverID=IB');                                        ///
        FDConnection1.Params.Add('Database='  + DBName);                                ///
        FDConnection1.Params.Add('Server='    + cServer);                               ///
        FDConnection1.Params.Add('Port='      + cPort);                                 ///
        FDConnection1.Params.Add('User_Name=' + cUser_Name);                            ///
        FDConnection1.Params.Add('Password='  + cPassword);                             ///
        //                                                                              ///
        ///////////////////////////////////////////////////////////////////////////////////
        FDConnection1.Open;
      end;
  except On E: Exception do
    ShowMessage('DB Error - "' + E.Message + '"');
  end;
end;

procedure TDataModule1.CreateChartData(const TheTable: string; const WithLabels: Boolean; TheVals: array of Integer; TheLabels: array of string);
begin
  FDTable1.Active := False;
  FDDeleteContents.Sql.Text := 'TRUNCATE TABLE ' + TheTable;
  FDDeleteContents.ExecSQL;
  FDTable1.TableName := TheTable;
  FDTable1.Active := True;
  for var LLoop := Low(TheVals) to High(TheVals) do
  begin
    FDTable1.Append;
    FDTable1.FieldByName('ID').AsInteger := LLoop;
    FDTable1.FieldByName('VAL1').AsInteger := TheVals[LLoop];
    if WithLabels then
      FDTable1.FieldByName('VAL2').AsString := TheLabels[LLoop];
    FDTable1.Post;
  end;
  FDTable1.Active := False;
end;

procedure TDataModule1.CreateChartValues;
begin
  CreateChartData('CHART1', True, [100, 200, 500, 100, 200, 500], ['Direct', 'Email', 'Website', 'Partner', 'Reseller', 'Social']);
  CreateChartData('CHART2', False, [100, 200, 500, 100, 200, 500, 150, 102, 207, 134, 100], []);
  CreateChartData('CHART3', False, [100, 200, 500, 100, 200, 500, 150, 102, 207, 134, 100], []);
  CreateChartData('CHART4', True, [100, 200, 500, 100, 200, 500], ['Books', 'Audio', 'Notes', 'Folders', 'Files', 'Apps']);
  CreateChartData('CHART5', False, [100, 200, 500, 100, 200, 500, 150, 102, 207, 134, 100], []);

  CreateChartData('CHART6_0', False, [14, 22, 53, 88, 29, 51, 15, 12, 37, 14, 18], []);
  CreateChartData('CHART6_1', False, [10, 20, 50, 10, 20, 50, 15, 12, 27, 13, 10], []);
  CreateChartData('CHART6_2', False, [10, 20, 50, 10, 20, 50, 15, 12, 27, 13, 10], []);
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  FMS := TFormatSettings.Create;
end;

procedure TDataModule1.GetChartValues(const TheTable: string; const TheSeries: TChartSeries; const WithLabels: boolean);
var
  LLabel: string;
begin
  TheSeries.Clear;
  FDQuery1.SQL.Text := 'select * from ' + TheTable + ' order by ID';
  FDQuery1.Active := True;
  while not FDQuery1.EOF do
  begin
    if WithLabels then
      LLabel := FDQuery1.FieldByName('VAL2').AsString
    else
      LLabel := FMS.ShortMonthNames[(FDQuery1.RecordCount mod 11) + 1];
    TheSeries.Add(FDQuery1.FieldByName('VAL1').AsInteger, LLabel);
    FDQuery1.Next;
  end;
  FDQuery1.Active := False;
end;


end.
