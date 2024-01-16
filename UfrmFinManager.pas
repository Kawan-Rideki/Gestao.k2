unit UfrmFinManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmManager, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, UAppLibrary, System.Generics.Collections;

type
  TfrmFinManager = class(TfrmManager)
    Edit1: TEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    cboTpDt: TComboBox;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnPesqCli: TButton;
    edtDescrCLi: TEdit;
    edtIdCli: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPesqCliClick(Sender: TObject);
    procedure edtIdCliExit(Sender: TObject);
    procedure btnFindClick(Sender: TObject); Override;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    Mapping: TDictionary<String, TFieldExtender>;
    IdFieldname: String;
    procedure AddMapping(AFieldExtender: TFieldExtender);

  end;

var
  frmFinManager: TfrmFinManager;

implementation

uses
  UfrmFinRegister, UfrmCliManager, UfrmFilFin;

{$R *.dfm}

procedure TfrmFinManager.AddMapping(AFieldExtender: TFieldExtender);
begin
  Mapping.Add(AFieldExtender.FieldName, AFieldExtender)
end;

procedure TfrmFinManager.btnFindClick(Sender: TObject);
var
  VlRct: Double;
  VlDesp: Double;
begin
  with QItem do
  begin
    Close;
    SQL.Clear;
    SQL.add('Select * from tb_fin');
    SQL.add('where 1=1');
    if (CheckBox1.Checked = true) then
    begin
      SQL.add('and id_cli = :id_cli');
      ParamByName('id_cli').AsInteger := StrtoInt(edtIdCli.Text);
    end;
    if (CheckBox2.Checked = True) then
    begin
      if (cboTpDt.Text = 'Emissão') then
      begin
        SQL.Add('and dt_ems between :pdt1 and :pdt2');
        ParamByName('pdt1').AsDate := DateTimePicker1.date;
        ParamByName('pdt2').AsDate := DateTimePicker2.date;
      end
      else if (cboTpDt.Text = 'Vencimento') then
      begin
        SQL.Add('and dt_vnc between :pdt1 and :pdt2');
        ParamByName('pdt1').AsDate := DateTimePicker1.date;
        ParamByName('pdt2').AsDate := DateTimePicker2.date;
      end;
    end;
    Open;
    TFloatField(FieldByName('vl_pg')).DisplayFormat := 'R$ ###,###,###,##0.00';
  end;
  VlRct   := 0;
  VlDesp  := 0;

  qItem.First;
  while not qItem.Eof do
  begin
    if (qItem.FieldByName('op').AsString = 'Receita') then
    begin
      VlRct := VlRct + qItem.FieldByName('vl_pg').AsFloat;
    end
    else if (qItem.FieldByName('op').AsString = 'Despesa') then
    begin
      VlDesp := VlDesp + qItem.FieldByName('vl_pg').AsFloat;
    end;

    qItem.Next;
  end;
  Label6.Caption := formatfloat('R$ ###,###,###,##0.00', VlRct);
  Label7.Caption := formatfloat('R$ ###,###,###,##0.00', VlDesp);

end;

procedure TfrmFinManager.btnPesqCliClick(Sender: TObject);
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

procedure TfrmFinManager.Button1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmFilFin, frmFilFin);
  frmFilFin.FormStyle := TFormStyle.fsMDIChild;
end;

procedure TfrmFinManager.edtIdCliExit(Sender: TObject);
var
  IdValue: Integer;
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
        edtDescrCLi.Text := qItem.FieldByName('nome').AsString;
      end;
    end;
  end;
end;

procedure TfrmFinManager.FormCreate(Sender: TObject);
begin
  inherited;
  Mapping := TDictionary<String, TFieldExtender>.Create;
  RegisterClass := TfrmFinRegister;
  TableName     := 'tb_fin';
  IdFieldname := 'id_fin';
  FindFieldName := 'descr';

  AddMapping(TNumericFieldExtender.Create('id_cli', edtIdCli, 0));

  AddColumn('id_fin', 'Código', 100);
  AddColumn('id_cli', 'Código do Cliente', 100);
  AddColumn('op', 'Operação', 100);
  AddColumn('descr', 'Descrição', 300);
  AddColumn('vl_pg', 'Valor', 100);
  AddColumn('dt_ems', 'Data de Emissão', 100);
  AddColumn('dt_vnc', 'Data de Vencimento', 100);
  AddColumn('op_fin', 'Operação Financeira', 100);
  AddColumn('num_doc', 'Número de Documento', 200);

end;

end.
