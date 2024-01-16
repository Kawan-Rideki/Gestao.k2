unit UfrmCliRel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, UAppLibrary, System.Generics.Collections;

type
  TfrmCliRel = class(TForm)
    RelCli: TRLReport;
    RLBand1: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLBand3: TRLBand;
    RLBand5: TRLBand;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    qItem: TFDQuery;
    dsItem: TDataSource;
    RLBand2: TRLBand;
    RLLabel6: TRLLabel;
    RLBand4: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel1: TRLLabel;
    RLDBResult1: TRLDBResult;
    procedure FormCreate(Sender: TObject);
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
  end;

var
  frmCliRel: TfrmCliRel;

implementation

{$R *.dfm}

uses
  UfrmMain, UfrmCliManager;

procedure TfrmCliRel.FormCreate(Sender: TObject);
begin
  qItem.Connection := frmMain.FDConnection1;
  dsItem.DataSet := qItem;
  RelCli.DataSource := dsItem;

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

procedure TfrmCliRel.RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  if rlband3.Color=clwhite then
  begin
    rlband3.Color:=cl3dlight
  end
  else
  begin
    rlband3.Color:=clwhite;
  end;
end;

end.
