object frmProdManagerOld: TfrmProdManagerOld
  Left = 0
  Top = 0
  Caption = 'frmProdManagerOld'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
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
    object btnInsert: TButton
      Left = 5
      Top = 4
      Width = 100
      Height = 31
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = btnInsertClick
    end
    object btnEdit: TButton
      Left = 111
      Top = 4
      Width = 100
      Height = 31
      Caption = 'Editar'
      TabOrder = 1
      OnClick = btnEditClick
    end
    object btnDelete: TButton
      Left = 217
      Top = 4
      Width = 100
      Height = 31
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btnDeleteClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 624
    Height = 72
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object edtNome: TEdit
      Left = 8
      Top = 27
      Width = 361
      Height = 23
      TabOrder = 0
    end
    object btnFind: TButton
      Left = 392
      Top = 27
      Width = 105
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 1
      OnClick = btnFindClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 113
    Width = 624
    Height = 328
    Align = alClient
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'id_prod'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descr'
        Title.Caption = 'Descri'#231#227'o'
        Width = 173
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vl_cst'
        Title.Caption = 'Valor de Custo'
        Width = 124
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vl_vnd'
        Title.Caption = 'Valor de Venda'
        Width = 159
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vl_estq'
        Title.Caption = 'Valor de Estoque'
        Width = 223
        Visible = True
      end>
  end
  object FDQuery1: TFDQuery
    Left = 144
    Top = 216
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 376
    Top = 216
  end
end
