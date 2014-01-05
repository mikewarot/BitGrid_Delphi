object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Bitgrid Simulator v0.02'
  ClientHeight = 434
  ClientWidth = 773
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 384
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Phase A'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 472
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Phase B'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 24
    Top = 8
    Width = 329
    Height = 409
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object Memo2: TMemo
    Left = 384
    Top = 121
    Width = 329
    Height = 209
    Lines.Strings = (
      'Memo2')
    ScrollBars = ssBoth
    TabOrder = 3
    OnExit = Memo2Exit
  end
  object Button3: TButton
    Left = 384
    Top = 360
    Width = 75
    Height = 25
    Caption = 'To Memo'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 488
    Top = 360
    Width = 75
    Height = 25
    Caption = 'FROM Memo'
    TabOrder = 5
    OnClick = Button4Click
  end
end
