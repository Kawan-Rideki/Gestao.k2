inherited frmManager: TfrmManager
  Caption = 'frmManager'
  ClientHeight = 451
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitHeight = 490
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
      Left = 8
      Top = 8
      Width = 50
      Height = 15
      Caption = 'Pesquisar'
    end
    object edtPesq: TEdit
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
  object dbgitem: TDBGrid
    Left = 0
    Top = 113
    Width = 624
    Height = 297
    Align = alClient
    DataSource = dsItem
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object pnlSel: TPanel
    Left = 0
    Top = 410
    Width = 624
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    ExplicitTop = 416
    object btnSel: TButton
      Left = 8
      Top = 6
      Width = 193
      Height = 35
      Caption = 'Selecionar'
      TabOrder = 0
      OnClick = btnSelClick
    end
  end
  object qItem: TFDQuery
    Left = 128
    Top = 208
  end
  object dsItem: TDataSource
    DataSet = qItem
    Left = 208
    Top = 208
  end
end
