object frmCliManagerOld: TfrmCliManagerOld
  Left = 0
  Top = 0
  Caption = 'Clientes'
  ClientHeight = 458
  ClientWidth = 630
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
    Width = 630
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 624
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
  object Panel2: TPanel
    Left = 0
    Top = 113
    Width = 630
    Height = 345
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 1
    ExplicitWidth = 624
    ExplicitHeight = 328
    object DBGrid1: TDBGrid
      Left = 5
      Top = 5
      Width = 620
      Height = 335
      Align = alClient
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'id_cli'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Caption = 'Nome'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cpf_cnpj'
          Title.Caption = 'CPF/CNPJ'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fone'
          Title.Caption = 'Fone'
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 630
    Height = 72
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 624
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
  object FDQuery1: TFDQuery
    Left = 248
    Top = 160
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 320
    Top = 160
  end
end
