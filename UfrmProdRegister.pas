unit UfrmProdRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmRegister, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, UAppLibrary;

type
  TfrmProdRegister = class(TfrmRegister)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtIdProd: TEdit;
    edtDescr: TEdit;
    edtVlCst: TMaskEdit;
    edtVlVnd: TMaskEdit;
    edtVlEstq: TMaskEdit;
    Label6: TLabel;
    btnPesqProd: TButton;
    edtDescrCat: TEdit;
    edtIdCat: TEdit;
    Label7: TLabel;
    qCat: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure btnPesqProdClick(Sender: TObject);
    procedure edtIdCatExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdRegister: TfrmProdRegister;

implementation

uses UfrmCatManager, UfrmMain;

{$R *.dfm}

procedure TfrmProdRegister.btnPesqProdClick(Sender: TObject);
var
  Manager: TfrmCatManager;
begin
  inherited;
  try
    Manager := TfrmCatManager.Create(Application);

    if (Manager.ShowModal = mrOk) then
    begin
      Mapping.Items['id_cat'].SetValue(Manager.qItem.FieldByName('id_cat').AsInteger);
      edtIdCat.OnExit(edtIdCat);
    end;
  finally
    FreeAndNil(Manager);
  end;
end;

procedure TfrmProdRegister.edtIdCatExit(Sender: TObject);
begin
  inherited;
   if (Mapping.ContainsKey('id_cat')) then
  begin
    if (Mapping.Items['id_cat'].GetValue <> 0) then
    begin
      qCat.Close;
      qCat.SQL.Text := 'select * from tb_cat where id_cat = :id_cat';
      qCat.ParamByName('id_cat').AsInteger := Mapping.Items['id_cat'].GetValue;
      qCat.Open;

      if (qCat.IsEmpty) then
      begin
      edtDescrCat.Text := '';
        ShowMessage('Categoria não encontrado')
      end
      else
      begin
        edtDescrCat.Text := qCat.FieldByName('descr').AsString;
      end;
    end;
  end;
end;

procedure TfrmProdRegister.FormCreate(Sender: TObject);
begin
  inherited;
  qCat.Connection     := frmMain.FDConnection1;

  TableName := 'tb_prod';
  IdFieldname := 'id_prod';

  AddMapping(TNumericFieldExtender.Create('id_prod', edtIdProd, 0));
  AddMapping(TFieldExtender.Create('descr', edtDescr));
  AddMapping(TNumericFieldExtender.Create('vl_cst', edtVlCst, 2));
  AddMapping(TNumericFieldExtender.Create('vl_vnd', edtVlVnd, 2));
  AddMapping(TNumericFieldExtender.Create('vl_estq', edtVlEstq, 2));
  AddMapping(TNumericFieldExtender.Create('id_cat', edtIdCat,0));
end;

end.
