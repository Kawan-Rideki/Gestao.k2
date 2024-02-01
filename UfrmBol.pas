unit UfrmBol;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, IniFiles,
  ACBrBase, ACBrBoleto, ACBrUtil, ACBrMail, ACBrUtil.FilesIO,
  ACBrBoletoConversao, ACBrBoletoRetorno, ComCtrls, ACBrBoletoFCFortesFr, UfrmDefault,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmBol = class(TfrmDefault)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtMoraJuros: TEdit;
    edtValorDesconto: TEdit;
    edtValorAbatimento: TEdit;
    edtMulta: TEdit;
    edtDataMora: TMaskEdit;
    edtDataDesconto: TMaskEdit;
    edtDataAbatimento: TMaskEdit;
    edtDataProtesto: TMaskEdit;
    GroupBox4: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label6: TLabel;
    edtNumeroDoc: TEdit;
    edtValorDoc: TEdit;
    edtDataDoc: TMaskEdit;
    edtVencimento: TMaskEdit;
    edtNossoNro: TEdit;
    PageControl2: TPageControl;
    TabSheet5: TTabSheet;
    Label28: TLabel;
    Label24: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label25: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label26: TLabel;
    Label23: TLabel;
    Label27: TLabel;
    edtCidade: TEdit;
    edtEndereco: TEdit;
    edtNome: TEdit;
    edtCPFCNPJ: TEdit;
    edtNumero: TEdit;
    edtCEP: TEdit;
    edtUF: TEdit;
    edtComplemento: TEdit;
    edtEmail: TEdit;
    edtBairro: TEdit;
    TabSheet4: TTabSheet;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    edtBenifRazao: TEdit;
    edtBenifCNPJ: TEdit;
    edtBenifEndereco: TEdit;
    edtBenifNum: TEdit;
    edtBenifComplemento: TEdit;
    edtBenifBairro: TEdit;
    edtBenifCidade: TEdit;
    edtBenifCEP: TEdit;
    edtBenifUF: TEdit;
    edtBenifFantasia: TEdit;
    edtBenifTelefone: TEdit;
    GroupBox6: TGroupBox;
    btnImpressaoHTML: TButton;
    btnImpressaoPDF: TButton;
    btnImpressaoSpooler: TButton;
    btnImpressaoStream: TButton;
    btnImpressaoPDFIndividual: TButton;
    btnImprimirTeste: TButton;
    TabSheet2: TTabSheet;
    Label65: TLabel;
    Label66: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label32: TLabel;
    Label49: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label64: TLabel;
    Label50: TLabel;
    edtEspecieDoc: TEdit;
    edtEspecieMod: TEdit;
    cbxAceite: TComboBox;
    edtCarteira: TEdit;
    cbxBanco: TComboBox;
    cbxTipoDistribuicao: TComboBox;
    cbxResponsavelEmissao: TComboBox;
    cbxTipoCarteira: TComboBox;
    cbxTipoDocumento: TComboBox;
    cbxCaracteristicaTitulo: TComboBox;
    GroupBox10: TGroupBox;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    cbxCNAB: TComboBox;
    edtCNABLVLote: TEdit;
    edtCNABLVArquivo: TEdit;
    GroupBox11: TGroupBox;
    Label36: TLabel;
    edtCIP: TEdit;
    GroupBox12: TGroupBox;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    edtAgencia: TEdit;
    edtAgenciaDV: TEdit;
    edtConta: TEdit;
    edtContaDV: TEdit;
    edtAgenciaContaDV: TEdit;
    edtConvenio: TEdit;
    edtModalidade: TEdit;
    edtOperacao: TEdit;
    edtCodigoCedente: TEdit;
    edtPathRemessa: TEdit;
    edtPathRetorno: TEdit;
    btnRetorno: TButton;
    PageControlConfg: TPageControl;
    TabSheet8: TTabSheet;
    ckbImprimirMensagemPadrao: TCheckBox;
    ckbLerCedenteArquivoRetorno: TCheckBox;
    ckbLerNossoNumeroCompleto: TCheckBox;
    ckbRemoverAcentuacaoRemessa: TCheckBox;
    TabSheet9: TTabSheet;
    cxbEMV: TCheckBox;
    chkIndicadorPix: TCheckBox;
    ckbEmHomologacao: TCheckBox;
    TabSheet10: TTabSheet;
    Label85: TLabel;
    cbbWSConsulta: TComboBox;
    chkLogComponente: TCheckBox;
    edtPathLog: TEdit;
    Button1: TButton;
    grpFichaBancaria: TGroupBox;
    Button3: TButton;
    btnBoletoIndividual: TButton;
    Button5: TButton;
    GroupBox13: TGroupBox;
    btnConfigLer: TButton;
    btnConfigGravar: TButton;
    dlgSave: TSaveDialog;
    dlgFile: TOpenDialog;
    PageControl3: TPageControl;
    TabSheet6: TTabSheet;
    Label80: TLabel;
    Label1: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label86: TLabel;
    cbxMotorRelatorio: TComboBox;
    cbxLayOut: TComboBox;
    cbxImprimirVersoFatura: TCheckBox;
    edtSenhaPDF: TEdit;
    TabSheet7: TTabSheet;
    Label81: TLabel;
    Label82: TLabel;
    edtPathFR3: TEdit;
    edtPathLogoMarca: TEdit;
    Button2: TButton;
    Button4: TButton;
    qItem: TFDQuery;
    edtIdCli: TEdit;
    edtIdEmp: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnBoletoIndividualClick(Sender: TObject);
    procedure cbxLayOutChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImpressaoSpoolerClick(Sender: TObject);
    procedure cbxMotorRelatorioChange(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
  FACBrBoleto : TACBrBoleto;
  FACBrBoletoFCRL : TACBrBoletoFCFortes;
    { Private declarations }
  procedure CarregarBancos;
  procedure CarregarTipoDistribuicao;
  procedure CarregarCaracteristicaTitulo;
  procedure CarregarResponsavelEmissao;
  procedure CarregarTipoCarteira;
  procedure CarregarTipoDocumento;
  procedure GravarIniComponente;
  procedure LerIniComponente(const ADialog : Boolean = False);
  procedure AplicarConfiguracoesAoComponente;
  procedure AplicarConfiguracoesComponenteATela;
  public
    { Public declarations }
  end;

var
  frmBol: TfrmBol;

  CONST MOTOR_NAO_SELECIONADO = 'MOTOR DE RELATÓRIO NÃO FOI SELECIONADO, VERIFIQUE!!!';
  CONST FILTER_RETORNO        = '*.txt|*.txt|*.ret|*.ret|*.*|*.*';
  CONST FILTER_INI            = '*.ini|*.ini|*.*|*.*';

implementation

{$R *.dfm}

uses TypInfo, DateUtils, pcnConversao, ACBrDFeSSL;

procedure TfrmBol.AplicarConfiguracoesAoComponente;
var Beneficiario   : TACBrCedente;
    Banco          : TACBrBanco;
    Boleto         : TACBrBoleto;
    WebService     : TACBrWebService;
    BeneficiarioWS : TACBrCedenteWS;
    CobAnterior    : TACBrTipoCobranca;
begin
  Boleto := FACBrBoleto;
  WebService := Boleto.Configuracoes.WebService;

  CobAnterior := Boleto.Banco.TipoCobranca;
  //Boleto.ListadeBoletos.Clear;

  Boleto.LayoutRemessa                     := TACBrLayoutRemessa(cbxCNAB.itemindex);
  Boleto.Homologacao                       := ckbEmHomologacao.Checked;

  Boleto.ImprimirMensagemPadrao            := ckbImprimirMensagemPadrao.Checked;
  Boleto.LeCedenteRetorno                  := ckbLerCedenteArquivoRetorno.Checked;
  Boleto.LerNossoNumeroCompleto            := ckbLerNossoNumeroCompleto.Checked;
  Boleto.RemoveAcentosArqRemessa           := ckbRemoverAcentuacaoRemessa.Checked;


  Beneficiario   := Boleto.Cedente;
  BeneficiarioWS := Beneficiario.CedenteWS;

  Beneficiario.Agencia                       := edtAgencia.Text;
  Beneficiario.AgenciaDigito                 := edtAgenciaDV.Text;
  Beneficiario.Conta                         := edtConta.Text;
  Beneficiario.ContaDigito                   := edtContaDV.Text;
  Beneficiario.DigitoVerificadorAgenciaConta := edtAgenciaContaDV.Text;
  Beneficiario.Convenio                      := edtConvenio.Text;
  Beneficiario.Modalidade                    := edtModalidade.Text;
  Beneficiario.Operacao                      := edtOperacao.Text;
  Beneficiario.CodigoCedente                 := edtCodigoCedente.Text;

  if Length(OnlyNumber(edtBenifCNPJ.Text)) = 14 then
    Beneficiario.TipoInscricao               := pJuridica
  else
    Beneficiario.TipoInscricao               := pFisica;

  Beneficiario.TipoDocumento                 := TACBrTipoDocumento(cbxTipoDocumento.ItemIndex);

  Beneficiario.IdentDistribuicao             := TACBrIdentDistribuicao(cbxTipoDistribuicao.itemIndex);
  Beneficiario.ResponEmissao                 := TACBrResponEmissao(cbxResponsavelEmissao.ItemIndex);
  Beneficiario.CaracTitulo                   := TACBrCaracTitulo(cbxCaracteristicaTitulo.itemIndex);
  Beneficiario.TipoCarteira                  := TACBrTipoCarteira(cbxTipoCarteira.itemIndex);

  Beneficiario.CNPJCPF                       := edtBenifCNPJ.Text;
  Beneficiario.Nome                          := edtBenifRazao.Text;
  Beneficiario.FantasiaCedente               := edtBenifFantasia.Text;
  Beneficiario.Logradouro                    := edtBenifEndereco.Text;
  Beneficiario.NumeroRes                     := edtBenifNum.Text;
  Beneficiario.Complemento                   := edtBenifComplemento.Text;
  Beneficiario.Bairro                        := edtBenifBairro.Text;
  Beneficiario.Cidade                        := edtBenifCidade.Text;
  Beneficiario.UF                            := edtBenifUF.Text;
  Beneficiario.CEP                           := edtBenifCEP.Text;
  Beneficiario.Telefone                      := edtBenifTelefone.Text;


  Banco                     := Boleto.Banco;
  Banco.TipoCobranca        := TACBrTipoCobranca(cbxBanco.Items.Objects[cbxBanco.ItemIndex]);
  Banco.LayoutVersaoArquivo := StrToIntDef(edtCNABLVArquivo.Text,0);
  Banco.LayoutVersaoLote    := StrToIntDef(edtCNABLVLote.Text,0);



  Boleto.Configuracoes.Arquivos.LogRegistro        := chkLogComponente.Checked;
  Boleto.Configuracoes.Arquivos.PathGravarRegistro := edtPathLog.Text;

  if Assigned(FACBrBoleto.ACBrBoletoFC) then
    FACBrBoleto.ACBrBoletoFC.DirLogo := edtPathLogoMarca.Text;

  {$IFDEF GERADOR_FAST_REPORT}
    FACBrBoletoFCFR.FastReportFile := edtPathFR3.Text;
    FACBrBoletoFCFR.MostrarPreview := True;
    FACBrBoletoFCFR.MostrarSetup   := True;
  {$ENDIF}
end;

procedure TfrmBol.AplicarConfiguracoesComponenteATela;
var Beneficiario : TACBrCedente;
    BeneficiarioWS : TACBrCedenteWS;
    Banco : TACBrBanco;
    Boleto : TACBrBoleto;
    I : Integer;
begin
  Boleto := FACBrBoleto;
  Boleto.ListadeBoletos.Clear;

  cbxCNAB.itemindex                   := Ord(Boleto.LayoutRemessa);
  ckbEmHomologacao.Checked            := Boleto.Homologacao;
  ckbImprimirMensagemPadrao.Checked   := Boleto.ImprimirMensagemPadrao;
  ckbLerCedenteArquivoRetorno.Checked := Boleto.LeCedenteRetorno;
  ckbLerNossoNumeroCompleto.Checked   := Boleto.LerNossoNumeroCompleto;
  ckbRemoverAcentuacaoRemessa.Checked := Boleto.RemoveAcentosArqRemessa;

  Beneficiario := Boleto.Cedente;

  edtAgencia.Text           := Beneficiario.Agencia;
  edtAgenciaDV.Text         := Beneficiario.AgenciaDigito;
  edtConta.Text             := Beneficiario.Conta;
  edtContaDV.Text           := Beneficiario.ContaDigito;
  edtAgenciaContaDV.Text    := Beneficiario.DigitoVerificadorAgenciaConta;
  edtConvenio.Text          := Beneficiario.Convenio;
  edtModalidade.Text        := Beneficiario.Modalidade;
  edtOperacao.Text          := Beneficiario.Operacao;
  edtCodigoCedente.Text     := Beneficiario.CodigoCedente;

  cbxTipoDistribuicao.ItemIndex     := Ord(Beneficiario.IdentDistribuicao);
  cbxCaracteristicaTitulo.ItemIndex := Ord(Beneficiario.CaracTitulo);
  cbxResponsavelEmissao.ItemIndex   := Ord(Beneficiario.ResponEmissao);
  cbxTipoCarteira.ItemIndex         := Ord(Beneficiario.TipoCarteira);
  cbxTipoDocumento.ItemIndex        := Integer(TACBrTipoDocumento(Beneficiario.TipoDocumento)) -1;

  Banco := Boleto.Banco;

  for I := 0 to cbxBanco.Items.Count - 1 do
    if Integer(cbxBanco.Items.Objects[i]) = Ord(Banco.TipoCobranca) then
      cbxBanco.ItemIndex        := I;

  edtCNABLVArquivo.Text     := IntToStr(Banco.LayoutVersaoArquivo);
  edtCNABLVLote.Text        := IntToStr(Banco.LayoutVersaoLote);
  edtCIP.Text               := Banco.CIP;


  chkLogComponente.Checked :=  Boleto.Configuracoes.Arquivos.LogRegistro;
  edtPathLog.Text           := Boleto.Configuracoes.Arquivos.PathGravarRegistro;
end;

procedure TfrmBol.btnBoletoIndividualClick(Sender: TObject);
var
  Titulo : TACBrTitulo;
  VQtdeCarcA, VQtdeCarcB, VQtdeCarcC :Integer;
  VLinha, logo : string;
  i: Integer;
begin
  Titulo := FACBrBoleto.CriarTituloNaLista;

  Titulo.Vencimento        := StrToDate(edtVencimento.Text);
  Titulo.DataDocumento     := StrToDate(edtDataDoc.Text);
  Titulo.NumeroDocumento   := edtNumeroDoc.Text;
  Titulo.EspecieDoc        := edtEspecieDoc.Text;
  Titulo.EspecieMod        := edtEspecieMod.Text;

  if cbxAceite.ItemIndex = 0 then
     Titulo.Aceite := atSim
  else
     Titulo.Aceite := atNao;

  Titulo.DataProcessamento := Now;
  Titulo.Carteira          := edtCarteira.Text;
  Titulo.NossoNumero       := edtNossoNro.Text;
  Titulo.ValorDocumento    := StrToCurr(edtValorDoc.Text);
  Titulo.Sacado.NomeSacado := edtNome.Text;
  Titulo.Sacado.CNPJCPF    := OnlyNumber(edtCPFCNPJ.Text);
  Titulo.Sacado.Logradouro := edtEndereco.Text;
  Titulo.Sacado.Numero     := edtNumero.Text;
  Titulo.Sacado.Bairro     := edtBairro.Text;
  Titulo.Sacado.Cidade     := edtCidade.Text;
  Titulo.Sacado.UF         := edtUF.Text;
  Titulo.Sacado.CEP        := OnlyNumber(edtCEP.Text);
  Titulo.ValorAbatimento   := StrToCurrDef(edtValorAbatimento.Text,0);
  Titulo.ValorMoraJuros    := StrToCurrDef(edtMoraJuros.Text,0);
  Titulo.ValorDesconto     := StrToCurrDef(edtValorDesconto.Text,0);
  Titulo.ValorAbatimento   := StrToCurrDef(edtValorAbatimento.Text,0);
  Titulo.DataMoraJuros     := StrToDateDef(edtDataMora.Text, 0);
  Titulo.DataDesconto      := StrToDateDef(edtDataDesconto.Text, 0);
  Titulo.TipoDesconto      := tdNaoConcederDesconto;
  Titulo.DataAbatimento    := StrToDateDef(edtDataAbatimento.Text, 0);
  Titulo.DataProtesto      := StrToDateDef(edtDataProtesto.Text, 0);
  Titulo.PercentualMulta   := StrToCurrDef(edtMulta.Text,0);
  Titulo.CodigoMoraJuros   := cjValorMensal;
  Titulo.OcorrenciaOriginal.Tipo := toRemessaRegistrar;

  Titulo.QtdePagamentoParcial   := 1;
  Titulo.TipoPagamento          := tpNao_Aceita_Valor_Divergente;
  Titulo.PercentualMinPagamento := 0;
  Titulo.PercentualMaxPagamento := 0;
  Titulo.ValorMinPagamento      := 0;
  Titulo.ValorMaxPagamento      := 0;
  if cxbEMV.Checked then
    Titulo.QrCode.emv := '00020101021226870014br.gov.bcb.pix2565qrcodepix-h.bb.com.br/pix/v2/22657e83-ecac-4631-a767-65e16fc56bff5204000053039865802BR5925EMPRORT AMBIENTAL        6008BRASILIA62070503***6304BD3D';

 // FACBrBoleto.AdicionarMensagensPadroes(Titulo,Mensagem);

  if cbxLayOut.ItemIndex = 6 then
  begin
    for i:=0 to 3 do
    begin
      VLinha := '.';

      VQtdeCarcA := length('Descrição Produto/Serviço ' + IntToStr(I));
      VQtdeCarcB := Length('Valor:');
      VQtdeCarcC := 85 - (VQtdeCarcA + VQtdeCarcB);

      VLinha := PadLeft(VLinha,VQtdeCarcC,'.');

      Titulo.Detalhamento.Add('Descrição Produto/Serviço ' + IntToStr(I) + ' '+ VLinha + ' Valor:   '+  PadRight(FormatCurr('R$ ###,##0.00', StrToCurr(edtValorDoc.Text) * 0.25),18,' ') );
    end;
    Titulo.Detalhamento.Add('');
    Titulo.Detalhamento.Add('');
    Titulo.Detalhamento.Add('');
    Titulo.Detalhamento.Add('');
    Titulo.Detalhamento.Add('Desconto ........................................................................... Valor: R$ 0,00' );
  end;

  if FileExists(ExtractFileDir(ParamStr(0)) + '\acbr_logo.jpg') then
     logo    := ExtractFileDir(ParamStr(0)) + '\acbr_logo.jpg';
  Titulo.ArquivoLogoEmp := logo;  // logo da empresa
  Titulo.Verso := ((cbxImprimirVersoFatura.Checked) and ( cbxImprimirVersoFatura.Enabled = true ));


end;

procedure TfrmBol.btnImpressaoSpoolerClick(Sender: TObject);
var
  i: Integer;
begin
  if not Assigned(FACBrBoleto.ACBrBoletoFC) then
    raise Exception.Create(MOTOR_NAO_SELECIONADO);

  FACBrBoleto.ACBrBoletoFC.PdfSenha := edtSenhaPDF.Text;
  FACBrBoleto.Imprimir;

end;

procedure TfrmBol.Button3Click(Sender: TObject);
begin
  FACBrBoleto.ListadeBoletos.Clear;
end;

procedure TfrmBol.Button5Click(Sender: TObject);
var
  Titulo: TACBrTitulo;
  I: Integer;
  NrTitulos: String;
  Valor : Currency;
begin

  NrTitulos := '10';
  InputQuery('Geração Lote','Quantidade a Gerar :',NrTitulos);

  for I := 0 to Pred(StrToIntDef(NrTitulos,0)) do
  begin
    Valor             := StrToFloatDef(edtValorDoc.Text,1);
    Valor             := Valor + Random;
    edtValorDoc.Text  := CurrToStr(Valor);
    edtNossoNro.Text  := IntToStr(StrToIntDef(edtNossoNro.Text,0)+1);
    edtNumeroDoc.Text := IntToStr(StrToIntDef(edtNumeroDoc.Text,0)+1);
    btnBoletoIndividual.Click;
  end;
end;

procedure TfrmBol.CarregarBancos;
var
  Banco: TACBrTipoCobranca;
begin
  cbxBanco.Items.clear;
	for Banco := Low(TACBrTipoCobranca) to High(TACBrTipoCobranca) do
    cbxBanco.Items.AddObject( GetEnumName(TypeInfo(TACBrTipoCobranca), integer(Banco) ), TObject(integer(Banco)) );
end;

procedure TfrmBol.CarregarCaracteristicaTitulo;
var
  Caracteristica: TACBrCaracTitulo;
begin
  cbxCaracteristicaTitulo.Items.clear;
	for Caracteristica := Low(TACBrCaracTitulo) to High(TACBrCaracTitulo) do
    cbxCaracteristicaTitulo.Items.Add( GetEnumName(TypeInfo(TACBrCaracTitulo), integer(Caracteristica) ) );
end;

procedure TfrmBol.CarregarResponsavelEmissao;
var
  ResponsavelEmissao: TACBrResponEmissao;
begin
  cbxResponsavelEmissao.Items.clear;
	for ResponsavelEmissao := Low(TACBrResponEmissao) to High(TACBrResponEmissao) do
    cbxResponsavelEmissao.Items.Add( GetEnumName(TypeInfo(TACBrResponEmissao), integer(ResponsavelEmissao) ) );
end;

procedure TfrmBol.CarregarTipoCarteira;
var
  TipoCarteira: TACBrTipoCarteira;
begin
  cbxTipoCarteira.Items.clear;
	for TipoCarteira := Low(TACBrTipoCarteira) to High(TACBrTipoCarteira) do
    cbxTipoCarteira.Items.Add( GetEnumName(TypeInfo(TACBrTipoCarteira), integer(TipoCarteira) ) );
end;

procedure TfrmBol.CarregarTipoDistribuicao;
var
  Distribuicao: TACBrIdentDistribuicao;
begin
  cbxTipoDistribuicao.Items.clear;
  for Distribuicao := Low(TACBrIdentDistribuicao) to High(TACBrIdentDistribuicao) do
    cbxTipoDistribuicao.Items.Add( GetEnumName(TypeInfo(TACBrIdentDistribuicao), integer(Distribuicao) ) );
end;

procedure TfrmBol.CarregarTipoDocumento;
var
  TipoDocumento: TACBrTipoDocumento;
begin
  cbxTipoDocumento.Items.clear;
	cbxTipoDocumento.Items.Add('Tradicional');
  cbxTipoDocumento.Items.Add('Escritural');
end;

procedure TfrmBol.cbxLayOutChange(Sender: TObject);
begin
  FACBrBoleto.ACBrBoletoFC.LayOut := TACBrBolLayOut( cbxLayOut.ItemIndex );

  cbxImprimirVersoFatura.Enabled := (cbxLayOut.ItemIndex = 6); // lFaturaDetal
  if cbxLayOut.ItemIndex <> 6 then
   cbxImprimirVersoFatura.Checked := false;
end;

procedure TfrmBol.cbxMotorRelatorioChange(Sender: TObject);
var
  LSelectedItemIndex: Integer;
  LSelectedObject: TObject;
begin
  LSelectedItemIndex := cbxMotorRelatorio.ItemIndex;

  if LSelectedItemIndex <> -1 then
    LSelectedObject := TObject(cbxMotorRelatorio.Items.Objects[LSelectedItemIndex]);

  if Assigned(LSelectedObject) then
  begin
    FACBrBoleto.ACBrBoletoFC := TACBrBoletoFCClass(LSelectedObject);
    FACBrBoleto.ACBrBoletoFC.DirLogo := edtPathLogoMarca.Text;
    {$IFDEF GERADOR_FAST_REPORT}
      if FACBrBoleto.ACBrBoletoFC is TACBrBoletoFCFR then
        TACBrBoletoFCFR(FACBrBoleto.ACBrBoletoFC).FastReportFile := edtPathFR3.Text;
    {$ENDIF}
  end;

  GravarIniComponente;
end;

procedure TfrmBol.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FACBrBoleto.Free;
end;

procedure TfrmBol.FormCreate(Sender: TObject);
var
  I: TACBrBolLayOut;
  CurrentStyle : longint;
begin
  FACBrBoleto := TACBrBoleto.Create(Self);

  FACBrBoletoFCRL   := TACBrBoletoFCFortes.Create(FACBrBoleto);
  cbxMotorRelatorio.AddItem('Fortes Reports', FACBrBoletoFCRL);

  CurrentStyle := GetWindowLong(edtCNABLVLote.Handle, GWL_STYLE);
  CurrentStyle := CurrentStyle or ES_NUMBER;
  SetWindowLong(edtCNABLVLote.Handle, GWL_STYLE, CurrentStyle);
  SetWindowLong(edtCNABLVArquivo.Handle, GWL_STYLE, CurrentStyle);

   edtDataDoc.Text    := DateToStr(Now);
   edtVencimento.Text := DateToStr(IncMonth(StrToDate(edtDataDoc.Text),1));
   edtDataMora.Text   := DateToStr(StrToDate(edtVencimento.Text)+1);

  cbxLayOut.Items.Clear;
  For I := Low(TACBrBolLayOut) to High(TACBrBolLayOut) do
    cbxLayOut.Items.Add(GetEnumName(TypeInfo(TACBrBolLayOut), Integer(I)));
  cbxLayOut.ItemIndex := 0;

  CarregarBancos;
  CarregarTipoDistribuicao;
  CarregarCaracteristicaTitulo;
  CarregarResponsavelEmissao;
  CarregarTipoCarteira;
  CarregarTipoDocumento;
  LerIniComponente;
  AplicarConfiguracoesComponenteATela;
  edtPathRemessa.Text := ExtractFilePath(ParamStr(0))+'Remessa';
  edtPathRetorno.Text := ExtractFilePath(ParamStr(0))+'Retorno';

//  if cbxMotorRelatorio.Items.Count > 0 then
//  begin
//    cbxMotorRelatorio.ItemIndex := 0;
//    cbxMotorRelatorio.OnChange(cbxMotorRelatorio);
//  end;
end;

procedure TfrmBol.GravarIniComponente;
var
  xPath, xArquivo : String;
  IniFile: TMemIniFile;
begin
  xPath    := ExtractFilePath(ParamStr(0));
  xArquivo := ChangeFileExt(ExtractFileName(ParamStr(0)), '.ini');
  FACBrBoleto.GravarConfiguracao(xPath,xArquivo);

  IniFile := TMemIniFile.Create(xPath+xArquivo);
  try

    IniFile.WriteString('PATH', 'BOLETOFR3', edtPathFR3.Text);
    IniFile.WriteString('PATH', 'LOGOMARCA', edtPathLogoMarca.Text);
    IniFile.WriteString('BANCO', 'CARTEIRA', edtCarteira.Text);

    IniFile.UpdateFile;

  finally
    IniFile.FRee;
  end;
end;

procedure TfrmBol.LerIniComponente(const ADialog: Boolean);
var xArquivo : String;
  IniFile: TMemIniFile;
begin
  if ADialog then
  begin
    dlgFile.Filter := FILTER_INI;
    if dlgFile.Execute then
      xArquivo := dlgFile.FileName
    else
      raise Exception.Create('É NECESSÁRIO SELECIONAR O ARQUIVO DE CONFIGURAÇÕES');
  end else
    xArquivo := ExtractFilePath(ParamStr(0)) + ChangeFileExt(ExtractFileName(ParamStr(0)), '.ini');

  if (FileExists(xArquivo)) then
    FACBrBoleto.LerConfiguracao(xArquivo);

  IniFile := TMemIniFile.Create(xArquivo);
  try
    edtPathFR3.Text := IniFile.ReadString('PATH', 'BOLETOFR3', ExtractFilePath(ParamStr(0))+'Report\Boleto.fr3');
    edtPathLogoMarca.Text := IniFile.ReadString('PATH', 'LOGOMARCA', '..\..\..\Fontes\ACBrBoleto\Logos\Colorido\png\');
    edtCarteira.Text := IniFile.ReadString('BANCO', 'CARTEIRA', '00');
  finally
    IniFile.Free;
  end;
end;

end.
