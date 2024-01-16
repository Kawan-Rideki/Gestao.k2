unit UfrmCliRegisterOld;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmCliRegisterOld = class(TForm)
    Panel1: TPanel;
    btnSave: TButton;
    Label1: TLabel;
    edtIdCli: TEdit;
    Label2: TLabel;
    edtNome: TEdit;
    edtCpfCnpj: TMaskEdit;
    Label3: TLabel;
    edtFone: TMaskEdit;
    Label4: TLabel;
    edtCep: TMaskEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtEnder: TEdit;
    FDQuery1: TFDQuery;
    btnNew: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure edtCepEnter(Sender: TObject);
    procedure edtIdCliExit(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure edtCepClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCliRegisterOld: TFrmCliRegisterOld;

implementation

{$R *.dfm}

uses UfrmMain;

procedure TFrmCliRegisterOld.btnSaveClick(Sender: TObject);
begin
  FDQuery1.Close;
  FDQuery1.SQL.Text := 'select * from tb_cli where id_cli = :id_cli';
  if (edtIdCli.Text = '') then
  begin
    FDQuery1.ParamByName('id_cli').AsInteger := 0;
  end
  else
  begin
    FDQuery1.ParamByName('id_cli').AsInteger := StrToInt(edtIdCli.Text);
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
  FDQuery1.FieldByName('nome').AsString     := edtNome.Text;
  FDQuery1.FieldByName('cpf_cnpj').AsString := edtCpfCnpj.Text;
  FDQuery1.FieldByName('fone').AsString     := edtFone.Text;
  FDQuery1.FieldByName('cep').AsString      := edtCep.Text;
  FDQuery1.FieldByName('ender').AsString    := edtEnder.Text;
  FDQuery1.FieldByName('dh_cad').AsDateTime := Now;
  FDQuery1.Post;

  ShowMessage('Registro salvo com sucesso');
end;

procedure TFrmCliRegisterOld.btnNewClick(Sender: TObject);
begin
  edtIdCli.Text   := '';
  edtNome.Text    := '';
  edtCpfCnpj.Text := '';
  edtFone.Text    := '';
  edtCep.Text     := '';
  edtEnder.Text   := '';
end;

procedure TFrmCliRegisterOld.edtCepClick(Sender: TObject);
begin
 edtCepEnter(Nil)
end;

procedure TFrmCliRegisterOld.edtCepEnter(Sender: TObject);
begin
  edtCep.SelLength  := 0;
  edtCep.SelStart   := 0;
end;

procedure TFrmCliRegisterOld.edtIdCliExit(Sender: TObject);
begin
  FDQuery1.Close;
  FDQuery1.SQL.Text := 'select * from tb_cli where id_cli = :id_cli';
  FDQuery1.ParamByName('id_cli').AsInteger := StrToIntDef(edtIdCli.Text, 0);
  FDQuery1.Open;

  if (FDQuery1.IsEmpty) then
  begin
    ShowMessage('Registro não encontrado');
    Exit;
  end;

  edtNome.Text := FDQuery1.FieldByName('nome').AsString;
  edtCpfCnpj.Text := FDQuery1.FieldByName('cpf_cnpj').AsString;
  edtFone.Text := FDQuery1.FieldByName('fone').AsString;
  edtCep.Text := FDQuery1.FieldByName('cep').AsString;
  edtEnder.Text := FDQuery1.FieldByName('ender').AsString;
end;

procedure TFrmCliRegisterOld.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFrmCliRegisterOld.FormCreate(Sender: TObject);
begin
  FDQuery1.Connection := frmMain.FDConnection1;

  btnNewClick(Nil);

  edtFone.EditMask := '(99) 99999-9999;1;_';
  edtCep.EditMask := '99999-999;1; ';
end;

end.
