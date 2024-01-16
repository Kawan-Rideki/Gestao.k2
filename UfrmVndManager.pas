unit UfrmVndManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmManager, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmVndManager = class(TfrmManager)
    Button1: TButton;
    Button2: TButton;
    qVnd: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure btnFindClick(Sender: TObject); override;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InfRel;
  end;

var
  frmVndManager: TfrmVndManager;

implementation

uses UfrmVndRegister, UfrmVndItemRel, UfrmFilRel, UfrmMain;
{$R *.dfm}

procedure TfrmVndManager.btnFindClick(Sender: TObject);
begin
  //inherited;
  qItem.Close;
  with qItem.Sql do
  begin
    Clear;
    Add('select');
    Add('     tb_vnd.*,');
    Add('     tb_cli.nome as tb_cli__nome');
    Add('from tb_vnd');
    Add('left outer join tb_cli on');
    Add('     tb_vnd.id_cli = tb_cli.id_cli');
    Add('where');
    Add('     unaccent(tb_cli.nome) ilike unaccent(:nome)');
    Add('order by');
    Add('     tb_vnd.dt_vnd,');
    Add('     tb_vnd.id_vnd');
  end;
  qItem.ParamByName('nome').AsString := '%' + edtPesq.Text + '%';
  qItem.Open;
end;


procedure TfrmVndManager.Button1Click(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TfrmFilRel, frmFilRel);
end;

procedure TfrmVndManager.Button2Click(Sender: TObject);
begin
  inherited;
  if not (qItem.IsEmpty) then
  begin
    frmVndItemRel                  := TfrmVndItemRel.Create( self );
    qVnd.Connection := frmMain.FDConnection1;
    frmVndItemRel.dsItem.DataSet := qVnd;
    frmVndItemRel.RelVnd.DataSource := frmVndItemRel.dsItem;
    InfRel;
    frmVndItemRel.RLLabel11.Caption := qItem.FieldByName('vl_tot').AsString;
    frmVndItemRel.RelVnd.Preview();
  end
  else
  begin
    showMessage('Nenhum Registro Encontrado.');
  end;
end;

procedure TfrmVndManager.FormCreate(Sender: TObject);
begin
  inherited;

  RegisterClass := TfrmVndRegister;
  TableName     := 'tb_vnd';
  FindFieldName := 'dt_vnd';

  AddColumn('id_vnd', 'Código', 100);
  AddColumn('dt_vnd', 'Data', 100);
  AddColumn('id_cli', 'Cliente', 100);
  AddColumn('tb_cli__nome', 'Nome Cliente', 300);
  AddColumn('vl_tot', 'Total', 100);

end;

procedure TfrmVndManager.InfRel;
begin
  with qVnd do
  begin
    Close;
    SQL.Clear;

    Sql.Add('Select');
    Sql.Add(' tb_vnd.id_cli, tb_vnd.id_vnd, tb_cli.nome, tb_vnd.vl_tot, tb_vnd.dt_vnd, tb_prod.descr, tb_vnd_item.vl_qtd, tb_vnd_item.vl_unt, (tb_vnd_item.vl_qtd * tb_vnd_item.vl_unt) as Tot ');
    Sql.Add('from tb_vnd');
    Sql.Add('join tb_cli on');
    Sql.Add(' tb_cli.id_cli = tb_vnd.id_cli');
    Sql.Add('join tb_vnd_item on');
    Sql.Add(' tb_vnd_item.id_vnd = tb_vnd.id_vnd');
    Sql.Add('join tb_prod on');
    Sql.Add(' tb_prod.id_prod = tb_vnd_item.id_prod');
    Sql.Add('where 1=1');
    Sql.Add('   and tb_vnd.id_vnd = :id_vnd');
    ParambyName('id_vnd').AsInteger := qItem.FieldByName('id_vnd').AsInteger;


//    Sql.Add('group by');
//    Sql.Add(' tb_vnd.id_cli, tb_vnd.id_vnd, tb_cli.nome, tb_vnd.dt_vnd, tb_prod.descr, tb_vnd_item.vl_qtd, tb_vnd_item.vl_unt, total');
    Sql.Add('order by');
    Sql.Add(' tb_vnd.id_vnd');

    Open;
  end;
end;

end.
