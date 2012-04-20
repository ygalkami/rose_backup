object SSAForm: TSSAForm
  Left = 175
  Top = 34
  Width = 944
  Height = 456
  Caption = 'Main Window'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object CreateDBBtn: TButton
    Left = 128
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Create DB'
    TabOrder = 0
    OnClick = CreateDBBtnClick
  end
  object makeFileTableBtn: TButton
    Left = 56
    Top = 304
    Width = 137
    Height = 25
    Caption = 'Make File Table'
    TabOrder = 1
    OnClick = makeFileTableBtnClick
  end
  object UserTableGrid: TDBGrid
    Left = 216
    Top = 8
    Width = 609
    Height = 89
    DataSource = UserDataSource
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object InsertToUserTableTempBtn: TButton
    Left = 128
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Add to User'
    TabOrder = 3
    OnClick = InsertToUserTableTempBtnClick
  end
  object EmptyUserTableBtn: TButton
    Left = 128
    Top = 44
    Width = 73
    Height = 25
    Caption = 'Empty Table'
    TabOrder = 4
    OnClick = EmptyUserTableBtnClick
  end
  object FileTableGrid: TDBGrid
    Left = 216
    Top = 152
    Width = 1641
    Height = 657
    DataSource = FileDataSource
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object InsertToFileTableTempBtn: TButton
    Left = 80
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Add to File'
    TabOrder = 6
    OnClick = InsertToFileTableTempBtnClick
  end
  object FileNameTxtField: TEdit
    Left = 832
    Top = 76
    Width = 81
    Height = 21
    TabOrder = 7
    Text = 'FileName'
  end
  object GUIDTxtField: TEdit
    Left = 832
    Top = 8
    Width = 81
    Height = 21
    TabOrder = 8
    Text = 'GUID'
  end
  object ScanSystemBtn: TButton
    Left = 56
    Top = 272
    Width = 137
    Height = 25
    Caption = 'Add Files To Database'
    TabOrder = 9
    OnClick = ScanSystemBtnClick
  end
  object EmptyFileTableBtn: TButton
    Left = 56
    Top = 344
    Width = 137
    Height = 25
    Caption = 'Empty Table'
    TabOrder = 10
    OnClick = EmptyFileTableBtnClick
  end
  object UserDataSource: TDataSource
    DataSet = UserTable
    Left = 64
    Top = 80
  end
  object SSA_Database: TACRDatabase
    FormatVersion = 4.2
    DatabaseFileName = 
      'C:\Documents and Settings\owner\Desktop\csse374-201020-team12\sr' +
      'c\SSA_Database2.adb'
    DatabaseName = 'SSA_Database'
    Exclusive = False
    SessionName = 'Default'
    BackupParams.CompressionAlgorithm = caNone
    BackupParams.CompressionMode = 1
    BackupParams.CryptoParams.CryptoAlgorithm = craNone
    BackupParams.CryptoParams.CryptoMode = acmCTS
    BackupParams.CryptoParams.KeySize = 56
    BackupParams.CryptoParams.Password = 'ACRpassword'
    BackupParams.CryptoParams.UseInitVector = False
    BackupParams.BlockSize = 102400
    ConnectionParams.RemoteHost = '127.0.0.1'
    ConnectionParams.RemotePort = 12007
    ConnectionParams.LocalPort = 12008
    ConnectionParams.DatabaseName = 'DBDemos'
    ConnectionParams.CompressionAlgorithm = caNone
    ConnectionParams.CompressionMode = 1
    ConnectionParams.CryptoParams.CryptoAlgorithm = craNone
    ConnectionParams.CryptoParams.CryptoMode = acmCTS
    ConnectionParams.CryptoParams.KeySize = 56
    ConnectionParams.CryptoParams.Password = 'ACRpassword'
    ConnectionParams.CryptoParams.UseInitVector = False
    ConnectionParams.ServerID = 0
    ConnectionParams.NetworkSettings.PacketSize = 8192
    ConnectionParams.NetworkSettings.MaxThreadCount = 100
    ConnectionParams.NetworkSettings.ConnectionParamsTunning = False
    ConnectionParams.NetworkSettings.TestPacketCount = 8
    ConnectionParams.NetworkSettings.DisconnectRetryCount = 12
    ConnectionParams.NetworkSettings.DisconnectDelay = 300
    ConnectionParams.NetworkSettings.ConnectRetryCount = 20
    ConnectionParams.NetworkSettings.ConnectDelay = 500
    ConnectionParams.NetworkSettings.StartReceiveTimeOut = 60000
    ConnectionParams.NetworkSettings.ReceiveTimeOut = 600000
    ConnectionParams.NetworkSettings.ReceiveSleep = 1
    ConnectionParams.NetworkSettings.MinSendTimeOut = 10000
    ConnectionParams.NetworkSettings.SendTimeOut = 180000
    ConnectionParams.NetworkSettings.WaitForSendSleep = 0
    ConnectionParams.NetworkSettings.ResendDelay = 300
    ConnectionParams.NetworkSettings.RequestDelay = 300
    ConnectionParams.NetworkSettings.WaitForTimeOut = 120000
    ConnectionParams.NetworkSettings.ThreadsTerminateDelay = 30000
    LockParams.Delay = 500
    LockParams.RetryCount = 10
    Options.MaxSessionCount = 367
    Options.PageSize = 4096
    Options.ExtentPageCount = 8
    Options.RandomSearchRetryCount = 10
    CryptoParams.CryptoAlgorithm = craNone
    CryptoParams.CryptoMode = acmCTS
    CryptoParams.KeySize = 56
    CryptoParams.Password = 'ACRpassword'
    CryptoParams.UseInitVector = False
    Left = 8
    Top = 8
  end
  object UserTable: TACRTable
    CurrentVersion = '4.20 '
    StoreDefs = True
    DatabaseName = 'SSA_Database'
    InMemory = False
    ReadOnly = False
    IndexDefs = <
      item
        Name = 'PrimaryKey'
        Fields = 'GUID'
        Options = [ixPrimary]
      end>
    FieldDefs = <
      item
        Name = 'GUID'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'username'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'password_hash'
        DataType = ftString
        Size = 30
      end>
    TableName = 'User'
    Exclusive = False
    MemoryTableAllocBy = 1000
    Left = 24
    Top = 80
  end
  object FileDataSource: TDataSource
    DataSet = FileTable
    Left = 152
    Top = 192
  end
  object FileTable: TACRTable
    CurrentVersion = '4.20 '
    StoreDefs = True
    DatabaseName = 'SSA_Database'
    InMemory = False
    ReadOnly = False
    IndexDefs = <
      item
        Name = 'PrimaryKey'
        Fields = 'GUID'
        Options = [ixPrimary]
      end>
    FieldDefs = <
      item
        Name = 'WhiteListed'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Hash'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'LastAccessed'
        DataType = ftDateTime
      end
      item
        Name = 'Location'
        DataType = ftString
        Size = 256
      end
      item
        Name = 'LastSolidified'
        DataType = ftDateTime
      end
      item
        Name = 'Instance'
        DataType = ftInteger
      end
      item
        Name = 'GUID'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Name'
        DataType = ftString
        Size = 128
      end
      item
        Name = 'Size'
        DataType = ftInteger
      end>
    TableName = 'File'
    Exclusive = False
    MemoryTableAllocBy = 1000
    Left = 112
    Top = 192
  end
  object emptyFileTableQuery: TACRQuery
    CurrentVersion = '4.20 '
    DatabaseName = 'SSA_Database'
    InMemory = False
    ReadOnly = False
    Left = 16
    Top = 344
  end
  object attrQuery: TACRQuery
    CurrentVersion = '4.20 '
    DatabaseName = 'SSA_Database'
    InMemory = False
    ReadOnly = True
    SQL.Strings = (
      'select instance, location'
      'from file'
      'where instance <> 16 and instance <> 32'
      'order by instance'
      '')
    Left = 72
    Top = 192
  end
end