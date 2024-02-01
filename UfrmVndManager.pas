unit UfrmVndManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmManager, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, RLReport, RLConsts, RLParser;

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
    Add('     and id_emp = :id_emp');
    Add('order by');
    Add('     tb_vnd.dt_vnd,');
    Add('     tb_vnd.id_vnd');
  end;
  qItem.ParamByName('nome').AsString := '%' + edtPesq.Text + '%';
  qItem.ParamByName('id_emp').AsInteger := frmMain.IdEmp;
  qItem.Open;
end;


procedure TfrmVndManager.Button1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmFilRel, frmFilRel);
end;

procedure TfrmVndManager.Button2Click(Sender: TObject);
var
  RelCli: TRLReport;
  BandHeader1: TRLBand;
  BandHeader2: TRLBand;
  BandHeader3: TRLBand;
  BandDetail: TRLBand;
  BandFooter: TRLBand;
begin
  if not (qItem.IsEmpty) then
  begin
    qVnd.Connection := frmMain.FDConnection1;
    dsItem.DataSet  := qVnd;
    RelCli          := Report(dsItem);

    BandHeader1 := RLBand(RelCli, btHeader, 19, True, false);

    RLLabel(BandHeader1, 16, 3, -13, 'Relatório Gerado em:');
    RLSYStemInfo(BandHeader1, 149, 3, itNow);

    BandHeader2 := RLBand(RelCli, btHeader, 39, True, false);

    RLLabel(BandHeader2, 241, 6, 26, 'Comprovante de Vendas');

    BandHeader3 := RLBand(RelCli, btHeader, 112, True, false);

    RLLabel(BandHeader3, 37, 10, -13, 'Cód. de venda:');
    RLLabel(BandHeader3, 37, 34, -13, 'Cód. de Cliente:');
    RLLabel(BandHeader3, 551, 10, -13, 'Nome:');
    RLLabel(BandHeader3, 551, 34, -13, 'Data:');

    RLDBText(BandHeader3, 128, 10, dsItem, 'id_vnd');
    RLDBText(BandHeader3, 128, 34, dsItem, 'id_cli');
    RLDBText(BandHeader3, 590, 10, dsItem, 'nome');
    RLDBText(BandHeader3, 585, 34, dsItem, 'dt_vnd');

    RLLabel(BandHeader3, 37, 90, -13, 'Descrição');
    RLLabel(BandHeader3, 213, 90, -13, 'Quantidade');
    RLLabel(BandHeader3, 383, 90, -13, 'Preço Unt.');
    RLLabel(BandHeader3, 551, 90, -13, 'Preço Tot.');

    BandDetail := RLBand(RelCli, btDetail, 24, False, False);

    RLDBText(BandDetail, 37, 6, dsItem, 'descr');
    RLDBText(BandDetail, 213, 6, dsItem, 'vl_qtd');
    RLDBText(BandDetail, 383, 6, dsItem, 'vl_unt');
    RLDBText(BandDetail, 551, 6, dsItem, 'tot');

    BandDetail.BeforePrint := RLBandBeforePrint;

    BandFooter := RLBand(RelCli, btFooter, 24, False, True);

    RLLabel(BandFooter, 16, 6, -13, 'Total da Venda:');
    RLDBResult(BandFooter, 126, 6, dsItem, '', riSimple, 'R$ ###,###,###,##0.00', 'sum(tot)');

    InfRel;

    RelCli.Preview();
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
  FindFieldName := 'id_vnd';

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
