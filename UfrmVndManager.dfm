inherited frmVndManager: TfrmVndManager
  Top = 21
  Caption = 'Vendas'
  ClientHeight = 529
  ClientWidth = 764
  Position = poDesigned
  ExplicitWidth = 780
  ExplicitHeight = 568
  TextHeight = 15
  inherited Panel1: TPanel
    Width = 764
    ExplicitWidth = 764
    object Button1: TButton
      Left = 323
      Top = 4
      Width = 100
      Height = 31
      Caption = 'Relat'#243'rio'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 429
      Top = 4
      Width = 100
      Height = 31
      Caption = 'Imprimir'
      TabOrder = 4
      OnClick = Button2Click
    end
  end
  inherited Panel3: TPanel
    Width = 764
    ExplicitWidth = 764
    inherited edtPesq: TEdit
      Top = 29
      ExplicitTop = 29
    end
  end
  inherited dbgitem: TDBGrid
    Width = 764
    Height = 375
  end
  inherited pnlSel: TPanel
    Top = 488
    Width = 764
    ExplicitTop = 488
    ExplicitWidth = 764
  end
  object qVnd: TFDQuery
    Left = 376
    Top = 272
  end
end
