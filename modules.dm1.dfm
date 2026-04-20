object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Port=3050'
      'DriverID=IB'
      'Database=IB_WEBINAR.IB'
      'Server=127.0.0.1')
    LoginPrompt = False
    Left = 64
    Top = 56
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 168
    Top = 56
  end
  object FDTable1: TFDTable
    Connection = FDConnection1
    Left = 248
    Top = 56
  end
  object FDDeleteContents: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand, rvCmdExecMode]
    Left = 352
    Top = 56
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 416
    Top = 144
  end
end
