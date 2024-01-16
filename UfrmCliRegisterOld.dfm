object FrmCliRegisterOld: TFrmCliRegisterOld
  Left = 0
  Top = 0
  Caption = 'Cliente '
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
    Top = 43
    Width = 39
    Height = 15
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel
    Left = 143
    Top = 43
    Width = 33
    Height = 15
    Caption = 'Nome'
  end
  object Label3: TLabel
    Left = 16
    Top = 99
    Width = 53
    Height = 15
    Caption = 'CPF/CNPJ'
  end
  object Label4: TLabel
    Left = 143
    Top = 99
    Width = 26
    Height = 15
    Caption = 'Fone'
  end
  object Label5: TLabel
    Left = 16
    Top = 155
    Width = 21
    Height = 15
    Caption = 'CEP'
  end
  object Label6: TLabel
    Left = 143
    Top = 155
    Width = 49
    Height = 15
    Caption = 'Endere'#231'o'
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
  object edtIdCli: TEdit
    Left = 16
    Top = 64
    Width = 121
    Height = 23
    TabOrder = 1
    Text = 'edtIdCli'
    OnExit = edtIdCliExit
  end
  object edtNome: TEdit
    Left = 143
    Top = 64
    Width = 306
    Height = 23
    TabOrder = 2
    Text = 'Edit1'
  end
  object edtCpfCnpj: TMaskEdit
    Left = 16
    Top = 120
    Width = 121
    Height = 23
    TabOrder = 3
    Text = 'edtCpfCnpj'
  end
  object edtFone: TMaskEdit
    Left = 143
    Top = 120
    Width = 121
    Height = 23
    TabOrder = 4
    Text = 'MaskEdit1'
  end
  object edtCep: TMaskEdit
    Left = 16
    Top = 176
    Width = 121
    Height = 23
    TabOrder = 5
    Text = 'MaskEdit1'
    OnClick = edtCepClick
    OnEnter = edtCepEnter
  end
  object edtEnder: TEdit
    Left = 143
    Top = 176
    Width = 306
    Height = 23
    TabOrder = 6
    Text = 'Edit1'
  end
  object FDQuery1: TFDQuery
    Left = 24
    Top = 232
  end
end
