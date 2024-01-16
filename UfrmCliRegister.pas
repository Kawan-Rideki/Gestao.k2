unit UfrmCliRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmRegister, Vcl.StdCtrls, Vcl.ExtCtrls, UAppLibrary,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, System.JSON;

type
  TfrmCliRegister = class(TfrmRegister)
    Label1: TLabel;
    Label2: TLabel;
    edtIdCli: TEdit;
    edtNome: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    edtCpfCnpj: TMaskEdit;
    edtFone: TMaskEdit;
    edtCep: TMaskEdit;
    edtEnder: TEdit;
    Label5: TLabel;
    Label7: TLabel;
    edtBairro: TEdit;
    Label8: TLabel;
    edtMunic: TEdit;
    IdHTTP1: TIdHTTP;
    btnBuscarCep: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnBuscarCepClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCliRegister: TfrmCliRegister;

implementation

{$R *.dfm}

procedure TfrmCliRegister.btnBuscarCepClick(Sender: TObject);
var
  Resp: TStringStream;
  Json: TJSONObject;
  ConvertedData: String;
begin
  inherited;
  Resp := TStringStream.Create;

  IdHTTP1.ReadTimeout     := 60 * 1000;
  IdHTTP1.ConnectTimeout  := 60 * 1000;

  with IdHTTP1 do
  begin
    HandleRedirects := True;

    Request.ContentType := 'application/json';
    Request.ContentEncoding := 'utf8';
    Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';

    Request.CustomHeaders.Clear;
    Request.CustomHeaders.FoldLines := False;
    Request.CustomHeaders.AddValue('Authorization', 'Token token=f91c853a9fd1bf2b9ddcbf1450883d53')
  end;

  IdHTTP1.Get('https://www.cepaberto.com/api/v3/cep?cep=' + edtCep.Text, Resp);

  ConvertedData := UTF8ToString(Resp.DataString);
  Json := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(ConvertedData), 0) as TJSONObject;

  edtEnder.Text := Json.Get('logradouro').JsonValue.Value;
  edtBairro.Text := Json.Get('bairro').JsonValue.Value;
  edtMunic.Text := TJsonObject(Json.Get('cidade').JsonValue).Get('nome').JsonValue.Value;
end;

procedure TfrmCliRegister.FormCreate(Sender: TObject);
begin
  inherited;

  TableName := 'tb_cli';
  IdFieldname := 'id_cli';

  AddMapping(TNumericFieldExtender.Create('id_cli', edtIdCli, 0));
  AddMapping(TFieldExtender.Create('nome', edtNome));
  AddMapping(TFieldExtender.Create('cpf_cnpj', edtCpfCnpj));
  AddMapping(TFieldExtender.Create('fone', edtFone));
  AddMapping(TFieldExtender.Create('cep', edtCep));
  AddMapping(TFieldExtender.Create('ender', edtEnder));
  AddMapping(TFieldExtender.Create('bairro', edtBairro));
  AddMapping(TFieldExtender.Create('munic', edtMunic));
end;

end.
