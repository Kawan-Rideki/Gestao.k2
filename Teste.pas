unit Teste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmDefault, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls;

type
  TfrmTeste = class(TfrmDefault)
    dsItem: TDataSource;
    qItem: TFDQuery;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTeste: TfrmTeste;

implementation

uses
  UfrmMain;

{$R *.dfm}

procedure TfrmTeste.Button1Click(Sender: TObject);
begin
  inherited;
//  qItem.Connection := frmMain.FDConnection1;
//  dsItem.DataSet := qItem;
//  RelCli.DataSource := dsItem;
end;

end.
