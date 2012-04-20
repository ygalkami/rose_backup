object LoginForm: TLoginForm
  Left = 852
  Top = 498
  Width = 267
  Height = 153
  Caption = 'Login'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PasswordLabel: TLabel
    Left = 16
    Top = 56
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object UserNameLabel: TLabel
    Left = 16
    Top = 8
    Width = 53
    Height = 13
    Caption = 'User Name'
  end
  object PasswordEdit: TEdit
    Left = 16
    Top = 72
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    Text = 'tempus'
  end
  object PasswordButton: TButton
    Left = 160
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 0
    OnClick = PasswordButtonClick
  end
  object UserNameEdit: TEdit
    Left = 16
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'admin'
  end
  object getUserHashQuery: TACRQuery
    CurrentVersion = '4.20 '
    DatabaseName = 'SSA_Database'
    InMemory = False
    ReadOnly = False
    Left = 184
    Top = 16
  end
end
