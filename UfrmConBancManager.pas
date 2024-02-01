unit UfrmConBancManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmManager, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmConBancManager = class(TfrmManager)
    procedure FormCreate(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConBancManager: TfrmConBancManager;

implementation

uses
  UfrmConBancRegister, UfrmMain;

{$R *.dfm}

procedure TfrmConBancManager.btnFindClick(Sender: TObject);
begin
//  inherited;
  qItem.Close;
  qitem.SQL.Text := 'select * from ' + TableName + ' where unaccent(' + FindFieldName + ') ilike unaccent(:' + FindFieldName + ') and id_emp = :id_emp order by ' + FindFieldName ;
  qItem.ParamByName(FindFieldName).AsString := '%' + edtPesq.Text + '%';
  qItem.ParamByName('id_emp').AsInteger := frmMain.IdEmp;
  qItem.Open;
end;

procedure TfrmConBancManager.FormCreate(Sender: TObject);
begin
  inherited;
  RegisterClass := TfrmConBancRegister;
  TableName     := 'tb_con_banc';
  FindFieldName := 'descr';

  AddColumn('id_con_banc', 'Código', 100);
  AddColumn('descr', 'Descrição', 300);
  AddColumn('cod_ced', 'Código Cedente', 200);
  AddColumn('cod_banc', 'Código do Banco', 200);
  AddColumn('conta', 'Conta', 100);
  AddColumn('agenc', 'Agência', 100);
end;

procedure TfrmConBancManager.FormShow(Sender: TObject);
begin
  inherited;
  btnFindClick(btnFind);
end;

end.
