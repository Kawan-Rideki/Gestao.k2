inherited frmVndRegister: TfrmVndRegister
  Caption = 'Registro de Vendas'
  ClientHeight = 546
  ClientWidth = 802
  Position = poDesigned
  ExplicitWidth = 818
  ExplicitHeight = 585
  TextHeight = 15
  inherited Panel1: TPanel
    Width = 802
    ExplicitWidth = 802
  end
  object Panel2: TPanel [1]
    Left = 0
    Top = 41
    Width = 802
    Height = 88
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 3
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 135
      Top = 6
      Width = 24
      Height = 15
      Caption = 'Data'
    end
    object Label4: TLabel
      Left = 295
      Top = 6
      Width = 37
      Height = 15
      Caption = 'Cliente'
    end
    object edtIdVnd: TEdit
      Left = 8
      Top = 24
      Width = 121
      Height = 23
      TabOrder = 0
      Text = 'edtIdVnd'
    end
    object edtIdCli: TEdit
      Left = 295
      Top = 24
      Width = 97
      Height = 23
      TabOrder = 1
      Text = 'edtIdCli'
      OnExit = edtIdCliExit
    end
    object btnPesqCli: TButton
      Left = 406
      Top = 22
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 2
      OnClick = btnPesqCliClick
    end
    object edtNomeCli: TEdit
      Left = 487
      Top = 23
      Width = 266
      Height = 23
      TabOrder = 3
      Text = 'Edit1'
    end
    object edtDtVnd: TDateTimePicker
      Left = 135
      Top = 24
      Width = 146
      Height = 23
      Date = 45204.000000000000000000
      Time = 0.860928645830426800
      TabOrder = 4
    end
    object btnAddProd: TButton
      Left = 8
      Top = 53
      Width = 129
      Height = 34
      Caption = 'Adicionar Produto'
      TabOrder = 5
      OnClick = btnAddProdClick
    end
    object btnDelProd: TButton
      Left = 143
      Top = 53
      Width = 129
      Height = 34
      Caption = 'Excluir Produto'
      TabOrder = 6
      OnClick = btnDelProdClick
    end
  end
  object Panel3: TPanel [2]
    Left = 0
    Top = 516
    Width = 802
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      802
      30)
    object Label3: TLabel
      Left = 617
      Top = 1
      Width = 25
      Height = 15
      Anchors = [akTop, akRight]
      Caption = 'Total'
    end
    object edtVlTot: TEdit
      Left = 666
      Top = 0
      Width = 130
      Height = 23
      Anchors = [akTop, akRight]
      TabOrder = 0
      Text = 'edtVlTot'
    end
  end
  object Panel4: TPanel [3]
    Left = 0
    Top = 129
    Width = 802
    Height = 387
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 3
    object dbgitem: TDBGrid
      Left = 5
      Top = 5
      Width = 792
      Height = 377
      Align = alClient
      DataSource = dsItem
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'id_prod'
          Title.Caption = 'C'#243'digo'
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descr_prod'
          Title.Caption = 'Descri'#231#227'o'
          Width = 291
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vl_qtd'
          Title.Caption = 'Quantidade'
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vl_unt'
          Title.Caption = 'Valor Unit'#225'rio'
          Width = 124
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vl_tot'
          Title.Caption = 'Total'
          Width = 185
          Visible = True
        end>
    end
  end
  object Panel5: TPanel [4]
    Left = 0
    Top = 129
    Width = 802
    Height = 387
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 4
    object DBGrid1: TDBGrid
      Left = 5
      Top = 5
      Width = 792
      Height = 377
      Align = alClient
      DataSource = dsItem
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'id_prod'
          Title.Caption = 'C'#243'digo'
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descr_prod'
          Title.Caption = 'Descri'#231#227'o'
          Width = 291
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vl_qtd'
          Title.Caption = 'Quantidade'
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vl_unt'
          Title.Caption = 'Valor Unit'#225'rio'
          Width = 124
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vl_tot'
          Title.Caption = 'Total'
          Width = 185
          Visible = True
        end>
    end
  end
  inherited qItem: TFDQuery
    Left = 256
    Top = 224
  end
  object qCli: TFDQuery
    Left = 296
    Top = 224
  end
  object cdsItem: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 208
    Top = 225
    object cdsItemid_prod: TIntegerField
      FieldName = 'id_prod'
    end
    object cdsItemdescr_prod: TStringField
      FieldName = 'descr_prod'
      Size = 255
    end
    object cdsItemvl_qtd: TFloatField
      FieldName = 'vl_qtd'
      DisplayFormat = '###,###,##0.00'
    end
    object cdsItemvl_unt: TFloatField
      FieldName = 'vl_unt'
      DisplayFormat = '###,###,##0.00'
    end
    object cdsItemvl_tot: TFloatField
      FieldName = 'vl_tot'
      DisplayFormat = '###,###,##0.00'
    end
    object cdsItemsum_vl_tot: TAggregateField
      FieldName = 'sum_vl_tot'
      Active = True
      DisplayName = ''
      Expression = 'sum(vl_tot)'
    end
  end
  object dsItem: TDataSource
    DataSet = cdsItem
    Left = 128
    Top = 225
  end
  object qVndItem: TFDQuery
    Left = 424
    Top = 232
  end
end
