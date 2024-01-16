inherited frmProdRegister: TfrmProdRegister
  Caption = 'frmProdRegister'
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 16
    Top = 59
    Width = 39
    Height = 15
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel [1]
    Left = 16
    Top = 112
    Width = 51
    Height = 15
    Caption = 'Descri'#231#227'o'
  end
  object Label3: TLabel [2]
    Left = 16
    Top = 168
    Width = 78
    Height = 15
    Caption = 'Pre'#231'o de custo'
  end
  object Label4: TLabel [3]
    Left = 152
    Top = 168
    Width = 81
    Height = 15
    Caption = 'Pre'#231'o de venda'
  end
  object Label5: TLabel [4]
    Left = 288
    Top = 168
    Width = 42
    Height = 15
    Caption = 'Estoque'
  end
  object Label6: TLabel [5]
    Left = 19
    Top = 223
    Width = 109
    Height = 15
    Caption = 'C'#243'digo da Categoria'
  end
  object Label7: TLabel [6]
    Left = 308
    Top = 223
    Width = 121
    Height = 15
    Caption = 'Descri'#231#227'o da Categoria'
  end
  object edtIdProd: TEdit [8]
    Left = 16
    Top = 80
    Width = 121
    Height = 23
    TabOrder = 1
    Text = 'edtIdProd'
  end
  object edtDescr: TEdit [9]
    Left = 16
    Top = 133
    Width = 306
    Height = 23
    TabOrder = 2
    Text = 'Edit1'
  end
  object edtVlCst: TMaskEdit [10]
    Left = 16
    Top = 189
    Width = 121
    Height = 23
    TabOrder = 3
    Text = 'edtVlCst'
  end
  object edtVlVnd: TMaskEdit [11]
    Left = 152
    Top = 189
    Width = 121
    Height = 23
    TabOrder = 4
    Text = 'MaskEdit1'
  end
  object edtVlEstq: TMaskEdit [12]
    Left = 288
    Top = 189
    Width = 121
    Height = 23
    TabOrder = 5
    Text = 'MaskEdit1'
  end
  object btnPesqProd: TButton [13]
    Left = 174
    Top = 244
    Width = 99
    Height = 23
    Caption = 'Pesquisar'
    TabOrder = 6
    OnClick = btnPesqProdClick
  end
  object edtDescrCat: TEdit [14]
    Left = 308
    Top = 244
    Width = 268
    Height = 23
    TabOrder = 7
    Text = 'Edit1'
  end
  object edtIdCat: TEdit [15]
    Left = 19
    Top = 244
    Width = 118
    Height = 23
    TabOrder = 8
    Text = 'edtIdProd'
    OnExit = edtIdCatExit
  end
  inherited qItem: TFDQuery
    Left = 192
    Top = 328
  end
  object qCat: TFDQuery
    Left = 304
    Top = 272
  end
end
