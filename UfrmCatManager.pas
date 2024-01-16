unit UfrmCatManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmManager, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, UAppLibrary;

type
  TfrmCatManager = class(TfrmManager)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCatManager: TfrmCatManager;

implementation

uses UfrmCatRegister;

{$R *.dfm}

procedure TfrmCatManager.FormCreate(Sender: TObject);
begin
  inherited;
  RegisterClass := TfrmCatRegister;
  TableName     := 'tb_cat';
  FindFieldName := 'descr';

  AddColumn('id_cat', 'Código', 100);
  AddColumn('descr', 'Descrição', 300);

end;

end.
