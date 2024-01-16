object frmProdRegisterOld: TfrmProdRegisterOld
  Left = 0
  Top = 0
  Caption = 'frmProdRegisterOld'
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
  object Label1: TLabel
    Left = 16
    Top = 59
    Width = 39
    Height = 15
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel
    Left = 16
    Top = 112
    Width = 51
    Height = 15
    Caption = 'Descri'#231#227'o'
  end
  object Label3: TLabel
    Left = 16
    Top = 168
    Width = 78
    Height = 15
    Caption = 'Pre'#231'o de custo'
  end
  object Label4: TLabel
    Left = 152
    Top = 168
    Width = 81
    Height = 15
    Caption = 'Pre'#231'o de venda'
  end
  object Label5: TLabel
    Left = 288
    Top = 168
    Width = 42
    Height = 15
    Caption = 'Estoque'
  end
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
  object edtIdProd: TEdit
    Left = 16
    Top = 80
    Width = 121
    Height = 23
    TabOrder = 1
    Text = 'edtIdProd'
    OnExit = edtIdProdExit
  end
  object edtNome: TEdit
    Left = 16
    Top = 133
    Width = 306
    Height = 23
    TabOrder = 2
    Text = 'Edit1'
  end
  object edtVlCst: TMaskEdit
    Left = 16
    Top = 189
    Width = 121
    Height = 23
    TabOrder = 3
    Text = 'edtVlCst'
  end
  object edtVlVnd: TMaskEdit
    Left = 152
    Top = 189
    Width = 121
    Height = 23
    TabOrder = 4
    Text = 'MaskEdit1'
  end
  object edtVlEstq: TMaskEdit
    Left = 288
    Top = 189
    Width = 121
    Height = 23
    TabOrder = 5
    Text = 'MaskEdit1'
  end
  object FDQuery1: TFDQuery
    Left = 516
    Top = 280
  end
end
