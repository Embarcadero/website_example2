object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 600
  Width = 800
  PixelsPerInch = 120
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Port=3050'
      'DriverID=IB'
      'Database=IB_WEBINAR.IB'
      'Server=127.0.0.1')
    LoginPrompt = False
    Left = 80
    Top = 70
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 210
    Top = 70
  end
  object FDTable1: TFDTable
    Connection = FDConnection1
    Left = 310
    Top = 70
  end
  object FDDeleteContents: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand, rvCmdExecMode]
    Left = 440
    Top = 70
  end
end
