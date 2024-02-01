inherited frmCliManager: TfrmCliManager
  Caption = 'frmCliManager'
  ClientHeight = 447
  ClientWidth = 685
  Position = poDesigned
  ExplicitWidth = 701
  ExplicitHeight = 486
  TextHeight = 15
  inherited Panel1: TPanel
    Width = 685
    ExplicitWidth = 685
    object Button1: TButton
      Left = 323
      Top = 4
      Width = 100
      Height = 31
      Caption = 'Relat'#243'rio'
      TabOrder = 3
      OnClick = btnRelClick
    end
  end
  inherited Panel3: TPanel
    Width = 685
    ExplicitWidth = 685
  end
  inherited dbgitem: TDBGrid
    Width = 685
    Height = 293
  end
  inherited pnlSel: TPanel
    Top = 406
    Width = 685
    ExplicitTop = 406
    ExplicitWidth = 685
  end
  inherited dsItem: TDataSource
    Left = 280
    Top = 240
  end
end
