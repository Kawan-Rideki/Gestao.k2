unit UfrmEmpManager;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmManager, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmEmpManager = class(TfrmManager)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmpManager: TfrmEmpManager;

implementation

uses
  UfrmEmpRegister;

{$R *.dfm}

procedure TfrmEmpManager.FormCreate(Sender: TObject);
begin
  inherited;

  RegisterClass := TfrmEmpRegister;
  TableName     := 'tb_emp';
  FindFieldName := 'nome';

  AddColumn('id_emp', 'Código', 100);
  AddColumn('nome', 'Nome', 300);
  AddColumn('raz_soc', 'Razão Social', 300);
  AddColumn('cpf_cnpj', 'CPF/CNPJ', 100);
  AddColumn('fone', 'Fone', 100);
  AddColumn('uf', 'Unidade Federativa', 100);
end;

end.
