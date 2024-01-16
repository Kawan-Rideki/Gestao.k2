inherited frmCliRegister: TfrmCliRegister
  Caption = 'frmCliRegister'
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 16
    Top = 43
    Width = 39
    Height = 15
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel [1]
    Left = 143
    Top = 43
    Width = 33
    Height = 15
    Caption = 'Nome'
  end
  object Label3: TLabel [2]
    Left = 16
    Top = 99
    Width = 53
    Height = 15
    Caption = 'CPF/CNPJ'
  end
  object Label4: TLabel [3]
    Left = 143
    Top = 99
    Width = 26
    Height = 15
    Caption = 'Fone'
  end
  object Label6: TLabel [4]
    Left = 231
    Top = 155
    Width = 49
    Height = 15
    Caption = 'Endere'#231'o'
  end
  object Label5: TLabel [5]
    Left = 16
    Top = 155
    Width = 21
    Height = 15
    Caption = 'CEP'
  end
  object Label7: TLabel [6]
    Left = 16
    Top = 211
    Width = 31
    Height = 15
    Caption = 'Bairro'
  end
  object Label8: TLabel [7]
    Left = 16
    Top = 259
    Width = 54
    Height = 15
    Caption = 'Munic'#237'pio'
  end
  object edtIdCli: TEdit [9]
    Left = 16
    Top = 64
    Width = 121
    Height = 23
    TabOrder = 1
    Text = 'edtIdCli'
  end
  object edtNome: TEdit [10]
    Left = 143
    Top = 64
    Width = 306
    Height = 23
    TabOrder = 2
    Text = 'Edit1'
  end
  object edtCpfCnpj: TMaskEdit [11]
    Left = 16
    Top = 120
    Width = 121
    Height = 23
    TabOrder = 3
    Text = 'edtCpfCnpj'
  end
  object edtFone: TMaskEdit [12]
    Left = 143
    Top = 120
    Width = 121
    Height = 23
    TabOrder = 4
    Text = 'MaskEdit1'
  end
  object edtCep: TMaskEdit [13]
    Left = 16
    Top = 176
    Width = 121
    Height = 23
    TabOrder = 5
    Text = 'MaskEdit1'
  end
  object edtEnder: TEdit [14]
    Left = 231
    Top = 176
    Width = 306
    Height = 23
    TabOrder = 6
    Text = 'Edit1'
  end
  object edtBairro: TEdit [15]
    Left = 16
    Top = 232
    Width = 306
    Height = 23
    TabOrder = 7
    Text = 'edtBairro'
  end
  object edtMunic: TEdit [16]
    Left = 16
    Top = 280
    Width = 306
    Height = 23
    TabOrder = 8
    Text = 'Edit1'
  end
  object btnBuscarCep: TButton [17]
    Left = 143
    Top = 175
    Width = 75
    Height = 25
    Caption = 'Buscar'
    TabOrder = 9
    OnClick = btnBuscarCepClick
  end
  inherited qItem: TFDQuery
    Left = 424
    Top = 376
  end
  object IdHTTP1: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 384
    Top = 272
  end
end
