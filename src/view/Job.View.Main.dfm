object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 554
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Memo1: TMemo
    Left = 48
    Top = 64
    Width = 353
    Height = 321
    TabOrder = 0
  end
  object Button1: TButton
    Left = 48
    Top = 391
    Width = 75
    Height = 25
    Caption = 'Start Timer'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 326
    Top = 391
    Width = 75
    Height = 25
    Caption = 'Finish Timer'
    TabOrder = 2
    OnClick = Button2Click
  end
end
