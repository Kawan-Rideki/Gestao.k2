unit UfrmMntEstqRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmRegister, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, UAppLibrary, Datasnap.DBClient;

type
  TfrmMntEstqRegister = class(TfrmRegister)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtIdMntEstq: TEdit;
    edtDtMntEstq: TDateTimePicker;
    btnAddProd: TButton;
    btnDelProd: TButton;
    Panel5: TPanel;
    DBGrid1: TDBGrid;
    Label4: TLabel;
    edtObs: TEdit;
    Label3: TLabel;
    cboOp: TComboBox;
    cdsItem: TClientDataSet;
    dsItem: TDataSource;
    qMntEstqItem: TFDQuery;
    cdsItemid_prod: TIntegerField;
    cdsItemdescr_prod: TStringField;
    cdsItemvl_qtd: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure btnAddProdClick(Sender: TObject);
    procedure btnDelProdClick(Sender: TObject);
  private
    { Private declarations }
  public
     procedure AfterSave; override;
  procedure AfterLoad; override;
  end;

var
  frmMntEstqRegister: TfrmMntEstqRegister;

implementation

  uses UfrmMain, UfrmProdManager, UfrmMntEstqItemRegister;

{$R *.dfm}

procedure TfrmMntEstqRegister.AfterLoad;
begin
  inherited;
  qMntEstqItem.Close;
  with qMntEstqItem.SQL do
  begin
    Clear;
    Add('select');
    Add('    tb_mnt_estq_item.*,');
    Add('    tb_prod.descr as descr_prod');
    Add('from tb_mnt_estq_item');
    Add('left outer join tb_prod on');
    Add('	tb_mnt_estq_item.id_prod = tb_prod.id_prod');
    Add('where');
    Add('    tb_mnt_estq_item.id_mnt_estq = :id_mnt_estq');
  end;
  qMntEstqItem.ParamByName('id_mnt_estq').AsInteger := Mapping.Items['id_mnt_estq'].GetValue;
  qMntEstqItem.Open;

  qMntEstqItem.First;

  while not qMntEstqItem.Eof do
  begin
    cdsItem.Append;

    cdsItemid_prod.Value := qMntEstqItem.FieldByName('id_prod').AsInteger;
    cdsItemdescr_prod.Value := qMntEstqItem.FieldByName('descr_prod').AsString;
    cdsItemvl_qtd.Value := qMntEstqItem.FieldByName('vl_qtd').AsFloat;

    cdsItem.Post;

    qMntEstqItem.Next;
  end;
end;

procedure TfrmMntEstqRegister.AfterSave;
begin
  inherited;
  qMntEstqItem.Close;
  qMntEstqItem.SQL.Text := 'delete from tb_mnt_estq_item where id_mnt_estq = :id_mnt_estq';
  qMntEstqItem.ParamByName('id_mnt_estq').AsInteger := Mapping.Items['id_mnt_estq'].GetValue;
  qMntEstqItem.ExecSQL;


  qMntEstqItem.Close;
  qMntEstqItem.SQL.Text := 'select * from tb_mnt_estq_item where id_mnt_estq = :id_mnt_estq';
  qMntEstqItem.ParamByName('id_mnt_estq').AsInteger := Mapping.Items['id_mnt_estq'].GetValue;
  qMntEstqItem.Open;

  cdsItem.First;

  while not cdsItem.Eof do
  begin
    qMntEstqItem.Append;

    qMntEstqItem.FieldByName('id_mnt_estq').AsInteger  := Mapping.Items ['id_mnt_estq'].GetValue;
    qMntEstqItem.FieldByName('id_prod').AsInteger      := cdsItemid_prod.Value;
    qMntEstqItem.FieldByName('vl_qtd').AsFloat         := cdsItemvl_qtd.Value;
    qMntEstqItem.FieldByName('op').AsString            := Mapping.Items ['op'].GetValue;
    qMntEstqItem.Post;

    cdsItem.Next;
  end;

end;

procedure TfrmMntEstqRegister.btnAddProdClick(Sender: TObject);
begin
  inherited;

  try
    frmMntEstqItemRegister := TfrmMntEstqItemRegister.Create(Application);

    if (frmMntEstqItemRegister.ShowModal = mrOk) then
    begin
      cdsItem.Append;
      cdsItemid_prod.AsInteger   := frmMntEstqItemRegister.Mapping.Items['id_prod'].GetValue;
      cdsItemdescr_prod.AsString :=frmMntEstqItemRegister.edtDescrProd.Text;
      cdsItemvl_qtd.AsFloat   := frmMntEstqItemRegister.Mapping.Items['vl_qtd'].GetValue;
      cdsItem.Post;
    end;
  finally
    FreeAndNil(frmMntEstqItemRegister);
  end;
end;

procedure TfrmMntEstqRegister.btnDelProdClick(Sender: TObject);
begin
  inherited;
if (not cdsItem.IsEmpty) then
  begin
    cdsItem.Delete;
  end;
end;

procedure TfrmMntEstqRegister.FormCreate(Sender: TObject);
begin
  inherited;

  qMntEstqItem.Connection     := frmMain.FDConnection1;

  cdsItem.CreateDataSet;
  cdsItem.LogChanges := False;

  TableName := 'tb_mnt_estq';
  IdFieldname := 'id_mnt_estq';

  AddMapping(TNumericFieldExtender.Create('id_mnt_estq', edtIdMntEstq, 0));
  AddMapping(TDateFieldExtender.Create('dt_mnt_estq', edtDtMntEstq));
  AddMapping(TFieldExtender.Create('op', cboOp));
  AddMapping(TFieldExtender.Create('obs', edtObs));
end;

end.
