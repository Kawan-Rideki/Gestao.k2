unit UfrmFinRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmRegister, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Mask, UAppLibrary;

type
  TfrmFinRegister = class(TfrmRegister)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtIdFin: TEdit;
    edtDescr: TEdit;
    edtVl: TMaskEdit;
    btnPesqProd: TButton;
    edtDescrCLi: TEdit;
    edtIdCli: TEdit;
    edtDtEms: TDateTimePicker;
    edtDtVnc: TDateTimePicker;
    cboOp: TComboBox;
    cboOpFin: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtNumDoc: TMaskEdit;
    edtIdConBanc: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    edtDescrConBanc: TEdit;
    Button1: TButton;
    Edit1: TEdit;
    procedure btnPesqProdClick(Sender: TObject);
    procedure edtIdCliExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure edtIdConBancExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFinRegister: TfrmFinRegister;

implementation

uses
  UfrmCliManager, UfrmMain, UfrmConBancManager;

{$R *.dfm}

procedure TfrmFinRegister.btnPesqProdClick(Sender: TObject);
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

procedure TfrmFinRegister.Button1Click(Sender: TObject);
var
  Manager: TfrmConBancManager;
begin
  inherited;
  try
    Manager := TfrmConBancManager.Create(Application);

    if (Manager.ShowModal = mrOk) then
    begin
      Mapping.Items['id_con_banc'].SetValue(Manager.qItem.FieldByName('id_con_banc').AsInteger);
      edtIdConBanc.OnExit(edtIdConBanc);
    end;
  finally
    FreeAndNil(Manager);
  end;
end;
procedure TfrmFinRegister.edtIdConBancExit(Sender: TObject);
begin
  inherited;
  if (Mapping.ContainsKey('id_con_banc')) then
  begin
    if (Mapping.Items['id_con_banc'].GetValue <> 0) then
    begin
      qItem.Close;
      qItem.SQL.Text := 'select * from tb_con_banc where id_con_banc = :id_con_banc';
      qItem.ParamByName('id_con_banc').AsInteger := Mapping.Items['id_con_banc'].GetValue;
      qItem.Open;

      if (qItem.IsEmpty) then
      begin
        edtDescrConBanc.Text := '';
        ShowMessage('Conta não encontrado')
      end
      else
      begin
        edtDescrConBanc.Text := qItem.FieldByName('descr').AsString;
      end;
    end;
  end;
end;

procedure TfrmFinRegister.edtIdCliExit(Sender: TObject);
begin
  inherited;
   if (Mapping.ContainsKey('id_cli')) then
  begin
    if (Mapping.Items['id_cli'].GetValue <> 0) then
    begin
      qItem.Close;
      qItem.SQL.Text := 'select * from tb_cli where id_cli = :id_cli';
      qItem.ParamByName('id_cli').AsInteger := Mapping.Items['id_cli'].GetValue;
      qItem.Open;

      if (qItem.IsEmpty) then
      begin
        edtDescrCli.Text := '';
        ShowMessage('Cliente não encontrado')
      end
      else
      begin
        edtDescrCli.Text := qItem.FieldByName('nome').AsString;
      end;
    end;
  end;
end;


procedure TfrmFinRegister.FormCreate(Sender: TObject);
begin
  inherited;
  qItem.Connection     := frmMain.FDConnection1;

  TableName   := 'tb_fin';
  IdFieldname := 'id_fin';
  CodEmp      := True;

  AddMapping(TNumericFieldExtender.Create('id_fin', edtIdFin, 0));
  AddMapping(TNumericFieldExtender.Create('id_con_banc', edtIdConBanc, 0));
  AddMapping(TFieldExtender.Create('descr', edtDescr));
  AddMapping(TNumericFieldExtender.Create('vl_pg', edtVl, 2));
  AddMapping(TDateFieldExtender.Create('dt_ems', edtDtEms));
  AddMapping(TDateFieldExtender.Create('dt_vnc', edtDtVnc));
  AddMapping(TNumericFieldExtender.Create('id_cli', edtIdCli,0));
  AddMapping(TFieldExtender.Create('op', cboOp));
  AddMapping(TFieldExtender.Create('op_fin', cboOpFin));
  AddMapping(TNumericFieldExtender.Create('num_doc', edtNumDoc, 0));
end;

end.
