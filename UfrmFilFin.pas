unit UfrmFilFin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmRegister, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, UAppLibrary, Vcl.ComCtrls, Datasnap.DBClient, System.Generics.Collections, UfrmDefault, RLReport, RLConsts, RLParser;

type
  TfrmFilFin = class(TfrmDefault)
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    edtIdCli: TEdit;
    btnPesqCli: TButton;
    edtNomeCli: TEdit;
    Button1: TButton;
    CheckBox1: TCheckBox;
    Button2: TButton;
    qItem: TFDQuery;
    qCli: TFDQuery;
    cboTpDt: TComboBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    dsItem: TDataSource;
    procedure btnPesqCliClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtIdCliExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    Mapping: TDictionary<String, TFieldExtender>;
    IdFieldname: String;
    TableName: String;
    procedure AddMapping(AFieldExtender: TFieldExtender);
    procedure IdOnExit(ASender: TObject);
    procedure AfterLoad;
    procedure InfRel;
  end;

var
  frmFilFin: TfrmFilFin;

implementation

uses
  UfrmCliManager, UfrmFinRel, UfrmMain, UfrmFinGrpRel;

{$R *.dfm}

{ TfrmFilFin }

procedure TfrmFilFin.AddMapping(AFieldExtender: TFieldExtender);
begin
  Mapping.Add(AFieldExtender.FieldName, AFieldExtender);
end;

procedure TfrmFilFin.AfterLoad;
begin

end;

procedure TfrmFilFin.btnPesqCliClick(Sender: TObject);
var
  Manager: TfrmCliManager;
begin

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

procedure TfrmFilFin.Button1Click(Sender: TObject);
var
  VlRct: Double;
  VlDesp: Double;
  RelFin: TRLReport;
  BandHeader1: TRLBand;
  BandHeader2: TRLBand;
  BandHeader3: TRLBand;
  BandDetail: TRLBand;
  BandFooter1: TRLBand;
  BandSummary: TRLBand;
  BandFooter2: TRLBand;
  Group: TRLGroup;
begin
  if (RadioButton1.Checked = True) then
  begin
    qItem.Connection := frmMain.FDConnection1;
    dsItem.DataSet  := qItem;
    RelFin          := Report(dsItem);

    InfRel;

    BandHeader1 := RLBand(RelFin, btHeader, 19, True, false);

    RLLabel(BandHeader1, 16, 3, -13, 'Relatório Gerado em:');
    RLSYStemInfo(BandHeader1, 149, 3, itNow);

    if (edtNomeCli.Text = '') then
    begin
      RLLabel(BandHeader1, 463, 3, -13, '');
      RLLabel(BandHeader1, 511, 3, -13, '');
    end
    else
    begin
      RLLabel(BandHeader1, 463, 3, -13, 'Cliente:');
      RLLabel(BandHeader1, 511, 3, -13, edtNomeCli.Text);
    end;

    BandHeader2 := RLBand(RelFin, btHeader, 39, True, false);

    RLLabel(BandHeader2, 241, 6, 26, 'Relatório Financeiro');

    if (frmFilFin.CheckBox1.Checked = True) then
    begin
      RLLabel(BandHeader2, 275, 32, -13, DateToStr(DateTimePicker1.Date) + ' até ' + DateToStr(DateTimePicker2.Date));
    end
    else
    begin
      RLLabel(BandHeader2, 275, 32, -13, '');
    end;

    BandHeader3 := RLBand(RelFin, btHeader, 24, True, false);

    RLLabel(BandHeader3, 3, 5, -13, 'Cliente');
    RLLabel(BandHeader3, 93, 5, -13, 'Código');
    RLLabel(BandHeader3, 149, 5, -13, 'Dt. de Emis.');
    RLLabel(BandHeader3, 236, 5, -13, 'Dt. de Venc.');
    RLLabel(BandHeader3, 329, 5, -13, 'Vl. Rec.');
    RLLabel(BandHeader3, 395, 5, -13, 'Vl. Des.');
    RLLabel(BandHeader3, 463, 5, -13, 'Descrição');
    RLLabel(BandHeader3, 546, 5, -13, 'Op. Fin.');
    RLLabel(BandHeader3, 615, 5, -13, 'Num. Doc.');

    BandDetail := RLBand(RelFin, btDetail, 24, False, False);

    RLDBText(BandDetail, 3, 5, dsItem, 'id_Cli');
    RLDBText(BandDetail, 43, 5, dsItem, 'nome');
    RLDBText(BandDetail, 93, 5, dsItem, 'id_fin');
    RLDBText(BandDetail, 149, 5, dsItem, 'dt_ems');
    RLDBText(BandDetail, 236, 5, dsItem, 'dt_vnc');
    RLDBText(BandDetail, 329, 5, dsItem, 'vl_rec');
    RLDBText(BandDetail, 395, 5, dsItem, 'vl_des');
    RLDBText(BandDetail, 463, 5, dsItem, 'descr');
    RLDBText(BandDetail, 546, 5, dsItem, 'op_fin');
    RLDBText(BandDetail, 615, 5, dsItem, 'Num_doc');

    BandDetail.BeforePrint := RLBandBeforePrint;

    BandFooter1 := RLBand(RelFin, btFooter, 24, False, True);

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

    RLLabel(BandFooter1, 16, 6, -13, 'Total Rec.:');
    RLLabel(BandFooter1, 79, 6, -13, formatfloat('R$ ###,###,###,##0.00',VlRct));

    RLLabel(BandFooter1, 530, 6, -13, 'Total Des.:');
    RLLabel(BandFooter1, 593, 6, -13, formatfloat('R$ ###,###,###,##0.00', VlDesp));


    RelFin.Preview();

  end
  else if (RadioButton2.Checked = True) then
  begin
    qItem.Connection := frmMain.FDConnection1;
    dsItem.DataSet  := qItem;
    RelFin          := Report(dsItem);

    InfRel;

    BandHeader1 := RLBand(RelFin, btHeader, 19, True, false);

    RLLabel(BandHeader1, 16, 3, -13, 'Relatório Gerado em:');
    RLSYStemInfo(BandHeader1, 149, 3, itNow);

    BandHeader2 := RLBand(RelFin, btHeader, 39, True, false);

    RLLabel(BandHeader2, 241, 6, 26, 'Relatório Financeiro');

    if (frmFilFin.CheckBox1.Checked = True) then
    begin
      RLLabel(BandHeader2, 275, 32, -13, DateToStr(DateTimePicker1.Date) + ' até ' + DateToStr(DateTimePicker2.Date));
    end
    else
    begin
      RLLabel(BandHeader2, 275, 32, -13, '');
    end;

    Group := RLGroup(RelFin, 152, False, 'id_cli');

    BandHeader3 := RLBand(Group, btHeader, 50, True, True);

    RLLabel(BandHeader3, 3, 5, -13, 'Cliente:');
    RLDBText(BandHeader3, 65, 5, dsItem, 'id_Cli');
    RLDBText(BandHeader3, 131, 5, dsItem, 'nome');

    RLLabel(BandHeader3, 3, 30, -13, 'Código');
    RLLabel(BandHeader3, 67, 30, -13, 'Dt. de Emis.');
    RLLabel(BandHeader3, 149, 30, -13, 'Dt. de Venc.');
    RLLabel(BandHeader3, 234, 30, -13, 'Vl. Rec.');
    RLLabel(BandHeader3, 307, 30, -13, 'Vl. Des.');
    RLLabel(BandHeader3, 379, 30, -13, 'Descrição');
    RLLabel(BandHeader3, 457, 30, -13, 'Op. Fin.');
    RLLabel(BandHeader3, 582, 30, -13, 'Num. Doc.');

    BandDetail := RlBand(Group, btDetail, 25, False, False);

    RLDBText(BandDetail, 3, 5, dsItem, 'id_fin');
    RLDBText(BandDetail, 67, 5, dsItem, 'dt_ems');
    RLDBText(BandDetail, 149, 5, dsItem, 'dt_vnc');
    RLDBText(BandDetail, 234, 5, dsItem, 'vl_rec');
    RLDBText(BandDetail, 307, 5, dsItem, 'vl_des');
    RLDBText(BandDetail, 379, 5, dsItem, 'descr');
    RLDBText(BandDetail, 457, 5, dsItem, 'op_fin');
    RLDBText(BandDetail, 582, 5, dsItem, 'num_doc');

    BandDetail.BeforePrint := RLBandBeforePrint;

    BandFooter1 := RlBand(Group, btFooter, 16, false, false);

    BandSummary := RlBand(Group, btSummary, 38, false, false);

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

    RLLabel(BandSummary, 3, 6, -13, 'Subtotal Rec.:');
    RLDBResult(BandSummary, 90, 6, dsItem, '', riSimple, 'R$ ###,###,###,##0.00', 'sum(vl_rec)');

    RLLabel(BandSummary, 510, 6, -13, 'Subtotal Des.:');
    RLDBResult(BandSummary, 603, 6, dsItem, '', riSimple, 'R$ ###,###,###,##0.00', 'sum(vl_des)');

    BandFooter2 := RlBand(RelFin, btFooter, 33, false, false);
    RLLabel(BandFooter2, 3, 6, -13, 'Total Rec.:');
    RLLabel(BandFooter2, 75, 6, -13, formatfloat('R$ ###,###,###,##0.00',VlRct));

    RLLabel(BandFooter2, 530, 6, -13, 'Total Des.:');
    RLLabel(BandFooter2, 593, 6, -13, formatfloat('R$ ###,###,###,##0.00', VlDesp));

    RelFin.Preview();

  end;
end;

procedure TfrmFilFin.Button2Click(Sender: TObject);
begin
  for var Item in Mapping do
    begin
      Item.Value.Clear;
    end;
    edtNomeCli.Text := '';
    edtIdCli.Text   := '';
end;

procedure TfrmFilFin.edtIdCliExit(Sender: TObject);
begin
  if (Mapping.ContainsKey('id_cli')) then
  begin
    if (Mapping.Items['id_cli'].GetValue <> 0) then
    begin
      qCli.Close;
      qCli.SQL.Text := 'select * from tb_cli where id_cli = :id_cli';
      qCli.ParamByName('id_cli').AsInteger := Mapping.Items['id_cli'].GetValue;
      qCli.Open;

      if (qCli.IsEmpty) then
      begin
       edtNomeCli.Text := '';
        ShowMessage('Cliente não encontrado')
      end
      else
      begin
        edtNomeCLi.Text := qCli.FieldByName('nome').AsString;
      end;
    end;
  end;
end;


procedure TfrmFilFin.FormCreate(Sender: TObject);

begin
  QItem.Connection     := frmMain.FDConnection1;
  qCli.Connection      := frmMain.FDConnection1;
  Mapping := TDictionary<String, TFieldExtender>.Create;

//  TableName := 'tb_vnd';
//  IdFieldname := 'id_vnd';

  AddMapping(TNumericFieldExtender.Create('id_cli', edtIdCli, 0));
end;
procedure TfrmFilFin.FormDestroy(Sender: TObject);
begin
  Mapping.Free;
end;

procedure TfrmFilFin.FormShow(Sender: TObject);
begin
//  if (Mapping.Items[IdFieldName].Control is TEdit) then
//  begin
//    TEdit(Mapping.Items[IdFieldName].Control).OnExit := IdOnExit;
//  end;
end;

procedure TfrmFilFin.IdOnExit(ASender: TObject);
Var
 IdValue: Integer;
begin
  inherited;

  qItem.Close;
  qItem.SQL.Text := 'select * from ' + TableName + ' where ' + IdFieldName + ' = :' + IdFieldName;

  IdValue := Mapping.Items[IdFieldName].GetValue;

  qItem.ParamByName(IdFieldName).AsInteger := IdValue;

  qItem.Open;

  if (qItem.IsEmpty) then

  begin
    ShowMessage('Registro não encontrado');
    Exit;
  end;

  for var Item in Mapping do
  begin
    if (Item.Key <> IdFieldName) then
    begin
     if (qItem.FieldByName(Item.Value.FieldName).IsNull) then
     begin
       Item.Value.Clear;
     end
     else
     begin
       Item.Value.SetValue(qItem.FieldByName(Item.Value.FieldName).Value);
      end;
    end;
  end;

  AfterLoad;
end;

procedure TfrmFilFin.InfRel;

begin
 with qItem do
  begin
    Close;
    SQL.Clear;

    Sql.Add('Select');
    Sql.Add(' tb_fin.id_cli, tb_fin.op, tb_fin.vl_pg, tb_Fin.id_Fin, tb_cli.nome, tb_Fin.dt_ems, tb_Fin.dt_Vnc, tb_fin.descr, tb_fin.op_fin, tb_fin.num_doc,');
    SQL.Add(' case op');
    SQL.Add('   when ''Receita''');
    Sql.add('   then vl_pg else 0');
    SQL.add('end vl_rec, ');
    SQL.Add(' case op');
    SQL.Add('   when ''Despesa''');
    Sql.add('   then vl_pg else 0');
    SQL.add('end vl_des ');
    Sql.Add('from tb_fin');
    Sql.Add('join tb_cli on');
    Sql.Add(' tb_cli.id_cli = tb_fin.id_cli');
    Sql.Add('where 1=1');

     if (CheckBox1.Checked = True) then
    begin
      if (cboTpDt.Text = 'Emissão') then
      begin
        SQL.Add('and tb_fin.dt_ems between :pdt1 and :pdt2');
        ParamByName('pdt1').AsDate := DateTimePicker1.date;
        ParamByName('pdt2').AsDate := DateTimePicker2.date;
      end
      else if (cboTpDt.Text = 'Vencimento') then
      begin
        SQL.Add('and tb_fin.dt_vnc between :pdt1 and :pdt2');
        ParamByName('pdt1').AsDate := DateTimePicker1.date;
        ParamByName('pdt2').AsDate := DateTimePicker2.date;
      end;
    end;

    if (edtIdCli.Text <> '') and (StrToInt(edtIdCli.Text) <> 0) then
    begin
      Sql.Add('   and tb_fin.id_cli = :id_cli');
      ParambyName('id_cli').AsInteger := StrToInt(edtIdCli.Text);
    end;

    Sql.Add('order by');
    Sql.Add(' tb_fin.id_cli');
    Open;
    TFloatField(FieldByName('vl_rec')).DisplayFormat := 'R$ ###,###,###,##0.00';
    TFloatField(FieldByName('vl_des')).DisplayFormat := 'R$ ###,###,###,##0.00';
  end;


 end;
end.
