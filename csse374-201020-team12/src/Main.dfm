object SSAForm: TSSAForm
  Left = 275
  Top = 70
  Width = 848
  Height = 693
  Caption = 'Main Window'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UserTableLbl: TLabel
    Left = 8
    Top = 8
    Width = 52
    Height = 13
    Caption = 'User Table'
  end
  object UsernameLbl: TLabel
    Left = 608
    Top = 32
    Width = 51
    Height = 13
    Caption = 'Username:'
  end
  object PasswordLbl: TLabel
    Left = 608
    Top = 64
    Width = 49
    Height = 13
    Caption = 'Password:'
  end
  object FileTableLbl: TLabel
    Left = 8
    Top = 128
    Width = 46
    Height = 13
    Caption = 'File Table'
  end
  object UserTableGrid: TDBGrid
    Left = 8
    Top = 24
    Width = 593
    Height = 89
    DataSource = UserDataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object AddUserBtn: TButton
    Left = 676
    Top = 88
    Width = 81
    Height = 25
    Caption = 'Add New User'
    TabOrder = 1
    OnClick = AddUserBtnClick
  end
  object FileTableGrid: TDBGrid
    Left = 8
    Top = 144
    Width = 593
    Height = 513
    DataSource = FileDataSource
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object ScanSystemBtn: TButton
    Left = 648
    Top = 144
    Width = 137
    Height = 25
    Caption = 'Scan System'
    TabOrder = 3
    OnClick = ScanSystemBtnClick
  end
  object EmptyFileTableBtn: TButton
    Left = 648
    Top = 184
    Width = 137
    Height = 25
    Caption = 'Empty Table'
    TabOrder = 4
    OnClick = EmptyFileTableBtnClick
  end
  object UnloadDriverBtn: TButton
    Left = 648
    Top = 368
    Width = 153
    Height = 33
    Caption = 'Unload Injection Driver'
    TabOrder = 5
    OnClick = UnloadDriverBtnClick
  end
  object LoadDriverBtn: TButton
    Left = 648
    Top = 328
    Width = 153
    Height = 33
    Caption = 'Load Injection Driver'
    TabOrder = 6
    OnClick = LoadDriverBtnClick
  end
  object UsernameTxtFld: TEdit
    Left = 664
    Top = 27
    Width = 105
    Height = 21
    TabOrder = 7
  end
  object PasswordTxtFld: TEdit
    Left = 664
    Top = 62
    Width = 105
    Height = 21
    TabOrder = 8
  end
  object Button1: TButton
    Left = 680
    Top = 456
    Width = 81
    Height = 89
    Caption = 'Test'
    TabOrder = 9
    OnClick = Button1Click
  end
  object UserDataSource: TDataSource
    DataSet = DBModule.UserTable
    Left = 808
    Top = 64
  end
  object FileDataSource: TDataSource
    DataSet = DBModule.FileTable
    Left = 808
    Top = 224
  end
  object emptyFileTableQuery: TACRQuery
    CurrentVersion = '4.20 '
    DatabaseName = 'SSA_Database'
    InMemory = False
    ReadOnly = False
    Left = 808
    Top = 144
  end
end
