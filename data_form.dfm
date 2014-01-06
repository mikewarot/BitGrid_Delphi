object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Bitgrid Simulator v0.02'
  ClientHeight = 465
  ClientWidth = 773
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 446
    Width = 773
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 180
      end
      item
        Alignment = taRightJustify
        Width = 0
      end>
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 32
    object File1: TMenuItem
      Caption = '&File'
      object Open1: TMenuItem
        Caption = '&Open'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Save1: TMenuItem
        Caption = '&Save'
      end
      object SaveAs1: TMenuItem
        Caption = 'Save &As'
        OnClick = SaveAs1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        OnClick = Exit1Click
      end
    end
    object ools1: TMenuItem
      Caption = '&Tools'
      object Run1: TMenuItem
        Caption = '&Run'
        OnClick = Run1Click
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object AboutBitGrid1: TMenuItem
        Caption = '&About BitGrid'
        OnClick = AboutBitGrid1Click
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 632
    Top = 360
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'bitgrid'
    FileName = 'default'
    Filter = '*.bitgrid'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 8
    Top = 88
  end
end
