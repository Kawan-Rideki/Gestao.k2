unit UfrmVndRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmRegister, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, UAppLibrary, Vcl.ComCtrls, Datasnap.DBClient;

type
  TfrmVndRegister = class(TfrmRegister)
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtIdVnd: TEdit;
    Label4: TLabel;
    edtIdCli: TEdit;
    btnPesqCli: TButton;
    edtNomeCli: TEdit;
    dbgitem: TDBGrid;
    Label3: TLabel;
    edtVlTot: TEdit;
    edtDtVnd: TDateTimePicker;
    qCli: TFDQuery;
    btnAddProd: TButton;
    cdsItem: TClientDataSet;
    dsItem: TDataSource;
    cdsItemid_prod: TIntegerField;
    cdsItemdescr_prod: TStringField;
    cdsItemvl_qtd: TFloatField;
    cdsItemvl_unt: TFloatField;
    cdsItemvl_tot: TFloatField;
    cdsItemsum_vl_tot: TAggregateField;
    qVndItem: TFDQuery;
    Panel5: TPanel;
    DBGrid1: TDBGrid;
    btnDelProd: TButton;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure edtIdCliExit(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnPesqCliClick(Sender: TObject);
    procedure btnAddProdClick(Sender: TObject);
    procedure btnDelProdClick(Sender: TObject);
  private
    { Private declarations }
  public
  procedure AfterSave; override;
  procedure AfterLoad; override;
  end;

var
  frmVndRegister: TfrmVndRegister;

implementation

  uses UfrmMain, UfrmCliManager, UfrmVndItemRegister;

{$R *.dfm}

procedure TfrmVndRegister.AfterLoad;
begin
  inherited;

  qVndItem.Close;
  with qVndItem.SQL do
    begin
      Clear;
      Add('select');
      Add('    tb_vnd_item.*,');
      Add('    tb_prod.descr as descr_prod');
      Add('from tb_vnd_item');
      Add('left outer join tb_prod on');
      Add('	tb_vnd_item.id_prod = tb_prod.id_prod');
      Add('where');
      Add('    tb_vnd_item.id_vnd = :id_vnd');
    end;
  qVndItem.ParamByName('id_vnd').AsInteger := Mapping.Items['id_vnd'].GetValue;
  qVndItem.Open;

  qVndItem.First;

  while not qVndItem.Eof do
  begin
    cdsItem.Append;

    cdsItemid_prod.Value := qVndItem.FieldByName('id_prod').AsInteger;
    cdsItemdescr_prod.Value := qVndItem.FieldByName('descr_prod').AsString;
    cdsItemvl_qtd.Value := qVndItem.FieldByName('vl_qtd').AsFloat;
    cdsItemvl_unt.Value := qVndItem.FieldByName('vl_unt').AsFloat;
    cdsItemvl_tot.Value := qVndItem.FieldByName('vl_tot').AsFloat;

    cdsItem.Post;

    qVndItem.Next;
  end;
end;

procedure TfrmVndRegister.AfterSave;
begin
  inherited;

  qVndItem.Close;
  qVndItem.SQL.Text := 'delete from tb_vnd_item where id_vnd = :id_vnd';
  qVndItem.ParamByName('id_vnd').AsInteger := Mapping.Items['id_vnd'].GetValue;
  qVndItem.ExecSQL;


  qVndItem.Close;
  qVndItem.SQL.Text := 'select * from tb_vnd_item where id_vnd = :id_vnd';
  qVndItem.ParamByName('id_vnd').AsInteger := Mapping.Items['id_vnd'].GetValue;
  qVndItem.Open;

  cdsItem.First;

  while not cdsItem.Eof do
  begin
    qVndItem.Append;

    qVndItem.FieldByName('id_vnd').AsInteger  := Mapping.Items ['id_vnd'].GetValue;
    qVndItem.FieldByName('id_prod').AsInteger := cdsItemid_prod.Value;
    qVndItem.FieldByName('vl_qtd').AsFloat    := cdsItemvl_qtd.Value;
    qVndItem.FieldByName('vl_unt').AsFloat    := cdsItemvl_unt.Value;
    qVndItem.FieldByName('vl_tot').AsFloat    := cdsItemvl_tot.Value;

    qVndItem.Post;

    cdsItem.Next;
  end;

end;

procedure TfrmVndRegister.btnAddProdClick(Sender: TObject);
begin
  inherited;

  try
    frmVndItemRegister := TfrmVndItemRegister.Create(Application);

    if (frmVndItemRegister.ShowModal = mrOk) then
    begin
      cdsItem.Append;
      cdsItemid_prod.AsInteger   := frmVndItemRegister.Mapping.Items['id_prod'].GetValue;
      cdsItemdescr_prod.AsString :=frmVndItemRegister.edtDescrProd.Text;
      cdsItemvl_qtd.AsFloat   := frmVndItemRegister.Mapping.Items['vl_qtd'].GetValue;
      cdsItemvl_unt.AsFloat   := frmVndItemRegister.Mapping.Items['vl_unt'].GetValue;
      cdsItemvl_tot.AsFloat   := frmVndItemRegister.Mapping.Items['vl_tot'].GetValue;
      cdsItem.Post;

      Mapping.Items['vl_tot'].SetValue(
        cdsItemsum_vl_tot.Value
      );

    end;
  finally
    FreeAndNil(frmVndItemRegister);
  end;
end;

procedure TfrmVndRegister.btnDelProdClick(Sender: TObject);
begin
  inherited;

  if (not cdsItem.IsEmpty) then
  begin
    cdsItem.Delete;

    if (not cdsItem.IsEmpty) then
    begin
    Mapping.Items['vl_tot'].SetValue(
        cdsItemsum_vl_tot.Value
      );
    end
    else
    begin
      Mapping.Items['vl_tot'].SetValue(0);
    end;
  end;
end;

procedure TfrmVndRegister.btnNewClick(Sender: TObject);
begin
  inherited;

  edtNomeCLi.Text := '';
end;

procedure TfrmVndRegister.btnPesqCliClick(Sender: TObject);
var
  Manager: TfrmCliManager;
begin
  inherited;

  try
    Manager := TfrmCliManager.Create(Application);

    if (Manager.ShowModal = mrOk) then
    begin
      Mapping.Items['id_cli'].SetValue(Manager.qItem.FieldByName('id_cli').AsInteger);
      edtIdCli.OnExit(edtIdCli);
    end;
  finally
    FreeAndNil(Manager);
  end;
end;


procedure TfrmVndRegister.edtIdCliExit(Sender: TObject);
begin
  inherited;

  if (Mapping.ContainsKey('id_cli')) then
  begin
    if (Mapping.Items['id_cli'].GetValue <> 0) then
    begin
      qCli.Close;
      qCli.SQL.Text := 'select * from tb_cli where id_cli = :id_cli';
      qCli.ParamByName('id_cli').AsInteger := Mapping.Items['id_cli'].GetValue;
      qCli.Open;

      if (qCli.IsEmpty) then
      begin
      edtNomeCli.Text := '';
        ShowMessage('Cliente não encontrado')
      end
      else
      begin
        edtNomeCLi.Text := qCli.FieldByName('nome').AsString;
      end;
    end;
  end;
end;

procedure TfrmVndRegister.FormCreate(Sender: TObject);
begin
  inherited;

  qCli.Connection     := frmMain.FDConnection1;
  qVndItem.Connection := frmMain.FDConnection1;


  cdsItem.CreateDataSet;
  cdsItem.LogChanges := False;

  TableName   := 'tb_vnd';
  IdFieldname := 'id_vnd';
  CodEmp      := True;


  AddMapping(TNumericFieldExtender.Create('id_vnd', edtIdVnd, 0));
  AddMapping(TDateFieldExtender.Create('dt_vnd', edtDtVnd));
  AddMapping(TNumericFieldExtender.Create('id_cli', edtIdCli, 0));
  AddMapping(TNumericFieldExtender.Create('vl_tot', edtVlTot, 2));
end;

end.
