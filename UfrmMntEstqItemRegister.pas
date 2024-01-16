unit UfrmMntEstqItemRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmDefault, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, UAppLibrary, System.Generics.Collections;

type
  TfrmMntEstqItemRegister = class(TfrmDefault)
    Label4: TLabel;
    Label1: TLabel;
    Panel1: TPanel;
    btnSave: TButton;
    edtVlQtd: TEdit;
    btnPesqProd: TButton;
    edtDescrProd: TEdit;
    edtIdProd: TEdit;
    qProd: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure edtIdProdExit(Sender: TObject);
    procedure btnPesqProdClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
     Mapping: TDictionary<String, TFieldExtender>;
  end;

var
  frmMntEstqItemRegister: TfrmMntEstqItemRegister;

implementation

uses UfrmMain, UfrmProdManager;

{$R *.dfm}

procedure TfrmMntEstqItemRegister.btnPesqProdClick(Sender: TObject);
var
  Manager: TfrmProdManager;
begin
  inherited;

  try
    Manager := TfrmProdManager.Create(Application);

    if (Manager.ShowModal = mrOk) then
    begin
      Mapping.Items['id_prod'].SetValue(Manager.qItem.FieldByName('id_prod').AsInteger);

      edtIdProd.OnExit(edtIdProd);
    end;
  finally
    FreeAndNil(Manager);
  end;
end;

procedure TfrmMntEstqItemRegister.btnSaveClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TfrmMntEstqItemRegister.edtIdProdExit(Sender: TObject);
begin
  inherited;
  if (Mapping.ContainsKey('id_prod')) then
  begin
    if (Mapping.Items['id_prod'].GetValue <> 0) then
    begin
      qProd.Close;
      qProd.SQL.Text := 'select * from tb_prod where id_prod = :id_prod';
      qProd.ParamByName('id_prod').AsInteger := Mapping.Items['id_prod'].GetValue;
      qProd.Open;

      if (qProd.IsEmpty) then
      begin
      edtdescrProd.Text := '';
        ShowMessage('Produto não encontrado')
      end
      else
      begin
        edtdescrProd.Text := qProd.FieldByName('descr').AsString;
      end;
    end;
  end;
end;

procedure TfrmMntEstqItemRegister.FormCreate(Sender: TObject);
begin
  inherited;
  qProd.Connection := frmMain.FDConnection1;

  Mapping := TDictionary<String, TFieldExtender>.Create;

  Mapping.Add('id_prod', TNumericFieldExtender.Create('id_prod', edtIdProd, 0));
  Mapping.Add('vl_qtd', TNumericFieldExtender.Create('vl_qtd', edtVlQtd, 2));
end;

end.
