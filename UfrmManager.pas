unit UfrmManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmDefault, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmManager = class(TfrmDefault)
    Panel1: TPanel;
    btnInsert: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    Panel3: TPanel;
    Label1: TLabel;
    edtPesq: TEdit;
    btnFind: TButton;
    dbgitem: TDBGrid;
    qItem: TFDQuery;
    dsItem: TDataSource;
    pnlSel: TPanel;
    btnSel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject); virtual;
    procedure FormShow(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSelClick(Sender: TObject);
  private
    { Private declarations }
  public
    RegisterClass: TFormClass;
    TableName: String;
    FindFieldName: String;
    procedure AddColumn(AName, ADescription: String; AWidth: Integer);
  end;

var
  frmManager: TfrmManager;

implementation

uses UfrmMain, UfrmRegister;

{$R *.dfm}

procedure TfrmManager.AddColumn(AName, ADescription: String; AWidth: Integer);
begin
  with dbgItem.Columns.Add do
  begin
    FieldName     := AName;
    Title.Caption := ADescription;
    Width         := AWidth;
  end;
end;

procedure TfrmManager.btnDeleteClick(Sender: TObject);
begin
  inherited;

  if (Vcl.Dialogs.MessageDlg('Confirma a exclusão desse registro?',
  TMsgDlgType.mtConfirmation,
  [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
  TMsgDlgBtn.mbYes) = mrYes) then
  begin
    qItem.Delete;
  end;

end;

procedure TfrmManager.btnEditClick(Sender: TObject);
begin
  inherited;

  with TfrmRegister(RegisterClass.Create(Application)) do
  begin
    Mapping.Items[IdFieldName].SetValue(Self.qItem.FieldByName(IdFieldName).Value);
    idOnExit(Mapping.Items[IdFieldName].Control);
  end;
end;

procedure TfrmManager.btnFindClick(Sender: TObject);
begin
  inherited;

  qItem.Close;
  qitem.SQL.Text := 'select * from ' + TableName + ' where unaccent(' + FindFieldName + ') ilike unaccent(:' + FindFieldName + ') order by ' + FindFieldName ;
  qItem.ParamByName(FindFieldName).AsString := '%' + edtPesq.Text + '%';
  qItem.Open;
end;

procedure TfrmManager.btnInsertClick(Sender: TObject);
begin
  inherited;

  RegisterClass.Create(Application);
end;

procedure TfrmManager.btnSelClick(Sender: TObject);
begin
  inherited;

  ModalResult :=  mrOk;
end;

procedure TfrmManager.FormCreate(Sender: TObject);
begin
  inherited;

  qItem.Connection := frmMain.FDConnection1;
  dsItem.DataSet := qItem;
  dbgItem.DataSource := dsItem;
end;

procedure TfrmManager.FormShow(Sender: TObject);
begin
  inherited;

  btnFindClick(btnFind);

  if (FormStyle = TFormStyle.fsMDIChild) then
  begin
    pnlSel.Visible := False;
  end
  else
  begin
    pnlSel.Visible := True;
  end;
end;

end.
