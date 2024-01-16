unit UfrmVndItemRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmDefault, Vcl.StdCtrls, Vcl.ExtCtrls, UAppLibrary,
  System.Generics.Collections, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmVndItemRegister = class(TfrmDefault)
    Panel1: TPanel;
    btnSave: TButton;
    Label4: TLabel;
    edtVlQtd: TEdit;
    btnPesqProd: TButton;
    edtDescrProd: TEdit;
    Label1: TLabel;
    edtIdProd: TEdit;
    edtVlUnt: TEdit;
    Label2: TLabel;
    edtVlTot: TEdit;
    Label3: TLabel;
    qProd: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure edtIdProdExit(Sender: TObject);
    procedure btnPesqProdClick(Sender: TObject);
    procedure edtVlQtdExit(Sender: TObject);
    procedure edtVlTotExit(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    Mapping: TDictionary<String, TFieldExtender>;
  end;

var
  frmVndItemRegister: TfrmVndItemRegister;

implementation

uses UfrmMain, UfrmProdManager;

{$R *.dfm}

procedure TfrmVndItemRegister.btnPesqProdClick(Sender: TObject);
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

procedure TfrmVndItemRegister.btnSaveClick(Sender: TObject);
begin
  inherited;

  ModalResult := mrOk;
  end;

procedure TfrmVndItemRegister.edtIdProdExit(Sender: TObject);
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
        Mapping.Items['vl_unt'].SetValue(qProd.FieldByName('vl_vnd').AsFloat);
      end;
    end;
  end;
end;

procedure TfrmVndItemRegister.edtVlQtdExit(Sender: TObject);
begin
  inherited;
    if  (Mapping.ContainsKey('vl_tot')) and
      (Mapping.ContainsKey('vl_qtd')) and
      (Mapping.ContainsKey('vl_unt')) then
  begin
    Mapping.Items['vl_tot'].SetValue(
      Mapping.Items['vl_qtd'].GetValue * Mapping.Items['vl_unt'].GetValue
    );
  end;


end;

procedure TfrmVndItemRegister.edtVlTotExit(Sender: TObject);
begin
  inherited;
  begin
    if  (Mapping.ContainsKey('vl_tot')) and
        (Mapping.ContainsKey('vl_qtd')) and
        (Mapping.ContainsKey('vl_unt')) then

    begin
      if (Mapping.Items['vl_unt'].GetValue = 0) and (Mapping.Items['vl_qtd'].GetValue > 0) then
      begin
        Mapping.Items['vl_unt'].SetValue(
          Mapping.Items['vl_tot'].GetValue / Mapping.Items['vl_qtd'].GetValue
        );
      end
      else if (Mapping.Items['vl_unt'].GetValue > 0) and (Mapping.Items['vl_qtd'].GetValue = 0) then
      begin
       Mapping.Items['vl_qtd'].SetValue(
          Mapping.Items['vl_tot'].GetValue / Mapping.Items['vl_unt'].GetValue
      );
      end;
    end;
  end
end;

procedure TfrmVndItemRegister.FormCreate(Sender: TObject);
begin
  inherited;

  qProd.Connection := frmMain.FDConnection1;

  Mapping := TDictionary<String, TFieldExtender>.Create;

  Mapping.Add('id_prod', TNumericFieldExtender.Create('id_prod', edtIdProd, 0));
  Mapping.Add('vl_qtd', TNumericFieldExtender.Create('vl_qtd', edtVlQtd, 2));
  Mapping.Add('vl_unt', TNumericFieldExtender.Create('vl_unt', edtVlUnt, 2));
  Mapping.Add('vl_tot', TNumericFieldExtender.Create('vl_tot', edtVlTot, 2));
end;

end.
