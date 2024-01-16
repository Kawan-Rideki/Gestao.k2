unit UfrmProdManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmManager, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmProdManager = class(TfrmManager)
    procedure FormCreate(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdManager: TfrmProdManager;

implementation

uses UfrmProdRegister;

{$R *.dfm}

procedure TfrmProdManager.btnFindClick(Sender: TObject);
begin
 // inherited;
  qItem.Close;
  with qItem.Sql do
  begin
    Clear;
    Add('select');
    Add('     tb_prod.*,');
    Add('     tb_cat.descr as tb_cat__descr');
    Add('from tb_prod');
    Add('left outer join tb_cat on');
    Add('     tb_prod.id_cat = tb_cat.id_cat');
    Add('where');
    Add('     unaccent(tb_prod.descr) ilike unaccent(:descr)');
    Add('order by');
    Add('     tb_prod.descr');
  end;
  qItem.ParamByName('descr').AsString := '%' + edtPesq.Text + '%';
  qItem.Open;
end;

procedure TfrmProdManager.FormCreate(Sender: TObject);
begin
  inherited;
  RegisterClass := TfrmProdRegister;
  TableName     := 'tb_prod';
  FindFieldName := 'descr';

  AddColumn('id_prod', 'Código', 100);
  AddColumn('descr', 'Descrição', 300);
  AddColumn('vl_cst', 'Valor de Custo', 200);
  AddColumn('vl_vnd', 'Valor de Venda', 200);
  AddColumn('vl_estq', 'Valor de Estoque', 200);
  AddColumn('tb_cat__descr', 'Categoria', 300);

end;

end.
