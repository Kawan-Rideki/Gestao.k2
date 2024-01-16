unit UfrmProdRegisterOld;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Mask, Vcl.StdCtrls,
  Vcl.ExtCtrls, UAppLibrary;

type
  TfrmProdRegisterOld = class(TForm)
    Panel1: TPanel;
    btnSave: TButton;
    btnNew: TButton;
    FDQuery1: TFDQuery;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtIdProd: TEdit;
    edtNome: TEdit;
    edtVlCst: TMaskEdit;
    edtVlVnd: TMaskEdit;
    edtVlEstq: TMaskEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure edtIdProdExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdRegisterOld: TfrmProdRegisterOld;

implementation

{$R *.dfm}

uses UfrmMain;

procedure TfrmProdRegisterOld.btnNewClick(Sender: TObject);
begin
  edtIdProd.Text      := '';
  edtNome.Text        := '';
  edtVlCst.Text       := '0,00';
  edtVlVnd.Text       := '0,00';
  edtVlEstq.Text      := '0,00';
end;

procedure TfrmProdRegisterOld.btnSaveClick(Sender: TObject);
begin
  FDQuery1.Close;
  FDQuery1.SQL.Text := 'select * from tb_prod where id_prod = :id_prod';
  if (edtIdProd.Text = '') then
  begin
    FDQuery1.ParamByName('id_prod').AsInteger := 0;
  end
  else
  begin
    FDQuery1.ParamByName('id_prod').AsInteger := StrToInt(edtIdProd.Text);
  end;
  FDQuery1.Open;

  if (FDQuery1.IsEmpty) then
  begin
  FDQuery1.Append;
  end
  else
  begin
    FDQuery1.Edit;
  end;
  FDQuery1.FieldByName('descr').AsString     := edtNome.Text;
  FDQuery1.FieldByName('vl_cst').AsFloat    := TextToFloat(edtVlCst.Text);
  FDQuery1.FieldByName('vl_vnd').AsFloat    := TextToFloat(edtVlVnd.Text);
  FDQuery1.FieldByName('vl_estq').AsFloat    := TextToFloat(edtVlEstq.Text);
  FDQuery1.Post;

  ShowMessage('Registro salvo com sucesso');

end;

procedure TfrmProdRegisterOld.edtIdProdExit(Sender: TObject);
begin
FDQuery1.Close;
  FDQuery1.SQL.Text := 'select * from tb_prod where id_prod = :id_prod';
  FDQuery1.ParamByName('id_prod').AsInteger := StrToIntDef(edtIdProd.Text, 0);
  FDQuery1.Open;

  if (FDQuery1.IsEmpty) then
  begin
    ShowMessage('Registro não encontrado');
    Exit;
  end;

  edtNome.Text := FDQuery1.FieldByName('descr').AsString;
  edtVlCst.Text := FormatFloat('###,###,##0.00', FDQuery1.FieldByName('vl_cst').AsFloat);
  edtVlVnd.Text := FormatFloat('###,###,##0.00', FDQuery1.FieldByName('vl_vnd').AsFloat);
  edtVlEstq.Text := FormatFloat('###,###,##0.00', FDQuery1.FieldByName('vl_estq').AsFloat);
end;

procedure TfrmProdRegisterOld.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TfrmProdRegisterOld.FormCreate(Sender: TObject);
begin
  FDQuery1.Connection := frmMain.FDConnection1;


  btnNewClick(Nil);
end;

end .
