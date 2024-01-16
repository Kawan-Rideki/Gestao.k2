inherited frmCliManager: TfrmCliManager
  Caption = 'frmCliManager'
  TextHeight = 15
  inherited Panel1: TPanel
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
  inherited dsItem: TDataSource
    Left = 280
    Top = 240
  end
end
