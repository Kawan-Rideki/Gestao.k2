unit UfrmEmpRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmRegister, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, UAppLibrary;

type
  TfrmEmpRegister = class(TfrmRegister)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmpRegister: TfrmEmpRegister;

implementation

{$R *.dfm}

procedure TfrmEmpRegister.FormCreate(Sender: TObject);
var
IdEmp: TEdit;
Nome: TEdit;
CpfCnpj: Tedit;
Fone: TEdit;
Ender: TEdit;
Num: TEdit;
Bairro: TEdit;
Munic: TEdit;
Uf: TEdit;
RazSoc: TEdit;
begin
  inherited;
  LLabel(Self, 16, 43, 255 ,'Código');
  LLabel(Self, 143, 43, 255 ,'Nome');
  IdEmp := EEDit(Self, 16, 64, 121);
  Nome  := EEDit(Self, 143, 64, 274);

  LLabel(Self, 16, 93, 255 ,'CPF/CNPJ');
  LLabel(Self, 143, 93, 255 ,'Telefone');
  CpfCnpj := EEDit(Self, 16, 120, 121);
  Fone    := EEDit(Self, 143, 120, 274);

  LLabel(Self, 16, 155, 255 ,'Número');
  LLabel(Self, 143, 155, 255 ,'Ender');
  Num   := EEDit(Self, 16, 176, 121);
  Ender := EEDit(Self, 143, 176, 274);

  LLabel(Self, 16, 211, 255 ,'Munícípio');
  LLabel(Self, 143, 211, 255 ,'Bairro');
  Munic  := EEDit(Self, 16, 232, 121);
  Bairro := EEDit(Self, 143, 232, 274);

  LLabel(Self, 16, 262, 255 ,'Unidade Federal');
  UF := EEDit(Self, 16, 284, 274);

  LLabel(Self, 16, 314, 255 ,'Razão Social');
  RazSoc := EEDit(Self, 16, 334, 274);

  TableName   := 'tb_emp';
  IdFieldname := 'id_emp';

  AddMapping(TNumericFieldExtender.Create('id_emp', IdEmp, 0));
  AddMapping(TFieldExtender.Create('nome', Nome));
  AddMapping(TFieldExtender.Create('cpf_cnpj', CpfCnpj));
  AddMapping(TFieldExtender.Create('fone', Fone));
  AddMapping(TFieldExtender.Create('Uf', Uf));
  AddMapping(TFieldExtender.Create('ender', Ender));
  AddMapping(TFieldExtender.Create('bairro', Bairro));
  AddMapping(TFieldExtender.Create('Num', Num));
  AddMapping(TFieldExtender.Create('munic', Munic));
  AddMapping(TFieldExtender.Create('raz_soc', RazSoc));
end;

end.
