unit UfrmCliManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmManager, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmCliManager = class(TfrmManager)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnRelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCliManager: TfrmCliManager;

implementation

uses UfrmCliRegister, UfrmCliRel;

{$R *.dfm}

procedure TfrmCliManager.btnRelClick(Sender: TObject);
begin
  frmCliRel := TfrmCliRel.Create( self );

  frmCliRel.RelCli.Preview();
end;


procedure TfrmCliManager.FormCreate(Sender: TObject);
begin
  inherited;

  RegisterClass := TfrmCliRegister;
  TableName     := 'tb_cli';
  FindFieldName := 'nome';

  AddColumn('id_cli', 'Código', 100);
  AddColumn('nome', 'Nome', 300);
  AddColumn('cpf_cnpj', 'CPF/CNPJ', 100);
  AddColumn('fone', 'Fone', 100);
end;

end.
