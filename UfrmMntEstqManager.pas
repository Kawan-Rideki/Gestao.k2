unit UfrmMntEstqManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmManager, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmMntEstqManager = class(TfrmManager)
    procedure FormCreate(Sender: TObject);
    procedure btnFindClick(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMntEstqManager: TfrmMntEstqManager;

implementation
uses UfrmMntEstqRegister;

{$R *.dfm}

procedure TfrmMntEstqManager.btnFindClick(Sender: TObject);
begin
  //inherited;
 qItem.Close;
  with qItem.Sql do
  begin
    Clear;
      Add('select');
      Add('     tb_mnt_estq.*');
      Add('from tb_mnt_estq');
      Add('where');
    Add('     unaccent(tb_mnt_estq.obs) ilike unaccent(:obs)');
    Add('order by');
    Add('     tb_mnt_estq.dt_mnt_estq,');
    Add('     tb_mnt_estq.id_mnt_estq');
  end;
  qItem.ParamByName('obs').AsString := '%' + edtPesq.Text + '%';
  qItem.Open;
end;

procedure TfrmMntEstqManager.FormCreate(Sender: TObject);
begin
  inherited;
  RegisterClass := TfrmMntEstqRegister;
  TableName     := 'tb_mnt_estq';
  FindFieldName := 'obs';

  AddColumn('id_mnt_estq', 'Código', 100);
  AddColumn('dt_mnt_estq', 'Data', 100);
  AddColumn('op', 'Operação', 100);
  AddColumn('obs', 'Observação', 300);
end;

end.
