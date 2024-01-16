unit UfrmProdManagerOld;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, UfrmMain;

type
  TfrmProdManagerOld = class(TForm)
    Panel1: TPanel;
    btnInsert: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    Panel3: TPanel;
    Label1: TLabel;
    edtNome: TEdit;
    btnFind: TButton;
    DBGrid1: TDBGrid;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdManagerOld: TfrmProdManagerOld;

implementation

{$R *.dfm}

uses UfrmProdRegisterOld;

procedure TfrmProdManagerOld.btnDeleteClick(Sender: TObject);
begin
begin
  if (Vcl.Dialogs.MessageDlg('Confirma a exclusão desse registro?',
  TMsgDlgType.mtConfirmation,
  [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
  TMsgDlgBtn.mbYes) = mrYes) then
  begin
    FDQuery1.Delete;
  end;
end;
end;

procedure TfrmProdManagerOld.btnEditClick(Sender: TObject);
begin
  Application.CreateForm(TFrmProdRegisterOld, frmProdRegisterOld);

    frmProdRegisterOld.edtIdProd.Text := FDQuery1.FieldByName('id_prod').AsString;
  FrmProdRegisterOld.edtIdProdExit(Nil);
end;

procedure TfrmProdManagerOld.btnFindClick(Sender: TObject);

begin
  FDQuery1.Close;
  FDQuery1.SQL.Text := 'select * from tb_prod where unaccent(descr) ilike unaccent(:descr) order by descr';
  FDQuery1.ParamByName('descr').AsString := '%' + edtNome.Text + '%';
  FDQuery1.Open;
end;

procedure TfrmProdManagerOld.btnInsertClick(Sender: TObject);
begin
  Application.CreateForm(TFrmProdRegisterOld, frmProdRegisterOld);
end;

procedure TfrmProdManagerOld.DBGrid1DblClick(Sender: TObject);
begin
  btnEditClick(Nil);
end;

procedure TfrmProdManagerOld.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TfrmProdManagerOld.FormCreate(Sender: TObject);
begin
  btnFindClick(Nil);

  DBGrid1.DataSource := DataSource1;
end;

end.
