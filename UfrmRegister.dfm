inherited frmRegister: TfrmRegister
  Caption = 'frmRegister'
  FormStyle = fsMDIChild
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object btnSave: TButton
      Left = 5
      Top = 4
      Width = 100
      Height = 31
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnNew: TButton
      Left = 111
      Top = 4
      Width = 100
      Height = 31
      Caption = 'Novo'
      TabOrder = 1
      OnClick = btnNewClick
    end
  end
  object qItem: TFDQuery
    Left = 152
    Top = 192
  end
end
