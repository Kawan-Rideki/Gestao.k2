unit UfrmCliManagerOld;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, UfrmMain, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmCliManagerOld = class(TForm)
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    btnInsert: TButton;
    Label1: TLabel;
    edtNome: TEdit;
    btnFind: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInsertClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCliManagerOld: TfrmCliManagerOld;

implementation

{$R *.dfm}

uses UfrmCliRegisterOld;

procedure TfrmCliManagerOld.btnDeleteClick(Sender: TObject);
begin
  if (Vcl.Dialogs.MessageDlg('Confirma a exclusão desse registro?',
  TMsgDlgType.mtConfirmation,
  [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
  TMsgDlgBtn.mbYes) = mrYes) then
  begin
    FDQuery1.Delete;
  end;
end;

procedure TfrmCliManagerOld.btnEditClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCliRegisterOld, FrmCliRegisterOld);

  frmCliRegisterOld.edtIdCli.Text := FDQuery1.FieldByName('id_cli').AsString;
  FrmCliRegisterOld.edtIdCliExit(Nil);
end;

procedure TfrmCliManagerOld.btnInsertClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCliRegisterOld, FrmCliRegisterOld);
end;

procedure TfrmCliManagerOld.DBGrid1DblClick(Sender: TObject);
begin
  btnEditClick(Nil);
end;

procedure TfrmCliManagerOld.btnFindClick(Sender: TObject);
begin
  FDQuery1.Close;
  FDQuery1.SQL.Text := 'select * from tb_cli where unaccent(nome) ilike unaccent(:nome) order by nome';
  FDQuery1.ParamByName('nome').AsString := '%' + edtNome.Text + '%';
  FDQuery1.Open;
end;

procedure TfrmCliManagerOld.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TfrmCliManagerOld.FormCreate(Sender: TObject);
begin
  btnFindClick(Nil);

  DBGrid1.DataSource := DataSource1;
end;

end.
