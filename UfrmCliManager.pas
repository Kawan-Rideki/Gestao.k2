unit UfrmCliManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmManager, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, RLReport, RLConsts;

type
  TfrmCliManager = class(TfrmManager)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnRelClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InfRel;
  end;

var
  frmCliManager: TfrmCliManager;

implementation

uses UfrmCliRegister, UfrmCliRel, UfrmMain;

{$R *.dfm}

procedure TfrmCliManager.btnRelClick(Sender: TObject);
var
  RelCli: TRLReport;
  BandHeader1: TRLBand;
  BandHeader2: TRLBand;
  BandHeader3: TRLBand;
  BandDetail: TRLBand;
  BandFooter: TRLBand;
begin
  qItem.Connection := frmMain.FDConnection1;
  dsItem.DataSet := qItem;
  RelCli     := Report(dsItem);

  InfRel;

  BandHeader1 := RLBand(RelCli, btHeader, 19, True, false);

  RLLabel(BandHeader1, 16, 3, -13, 'Relatório Gerado em:');
  RLSYStemInfo(BandHeader1, 149, 3, itNow);

  BandHeader2 := RLBand(RelCli, btHeader, 39, True, false);

  RLLabel(BandHeader2, 241, 6, 26, 'Relatório de Cliente');

  BandHeader3 := RLBand(RelCli, btHeader, 32, True, false);

  RLLabel(BandHeader3, 99, 6, -13, 'Código');
  RLLabel(BandHeader3, 326, 6, -13, 'Nome');
  RLLabel(BandHeader3, 577, 6, -13, 'Telefone');

  BandDetail := RLBand(RelCli, btDetail, 24, False, False);

  RLDBText(BandDetail, 99, 6, dsItem, 'id_cli');
  RLDBText(BandDetail, 326, 6, dsItem, 'nome');
  RLDBText(BandDetail, 577, 6, dsItem, 'fone');

  BandDetail.BeforePrint := RLBandBeforePrint;

  BandFooter := RLBand(RelCli, btFooter, 24, False, True);

  RLLabel(BandFooter, 16, 6, -13, 'Total de Clientes:');
  RLDBResult(BandFooter, 126, 6, dsItem, 'id_cli', riCount, '', '');

  RelCli.Preview();
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

procedure TfrmCliManager.InfRel;
begin
  with qItem do
  begin
    Close;
    SQL.Clear;

    Sql.Add('Select');
    Sql.Add(' tb_cli.id_cli, tb_cli.nome, tb_cli.fone ');
    Sql.Add('from tb_cli');
    Sql.Add('order by');
    Sql.Add(' tb_cli.id_cli');
    Open;
  end;
end;

end.
