unit UfrmFilRel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmRegister, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, UAppLibrary, Vcl.ComCtrls, Datasnap.DBClient, System.Generics.Collections, UfrmDefault, RLParser, RLReport, RLConsts;

type
  TfrmFilRel = class(TfrmDefault)
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
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    dsItem: TDataSource;
    procedure btnPesqCliClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtIdCliExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
  frmFilRel: TfrmFilRel;

implementation

uses
  UfrmCliManager, UfrmVndRel, UfrmMain;

{$R *.dfm}
procedure TfrmFilRel.AddMapping(AFieldExtender: TFieldExtender);
begin
  Mapping.Add(AFieldExtender.FieldName, AFieldExtender)
end;

procedure TfrmFilRel.AfterLoad;
begin

end;

procedure TfrmFilRel.btnPesqCliClick(Sender: TObject);
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

procedure TfrmFilRel.Button1Click(Sender: TObject);
var
  RelVnd: TRLReport;
  BandHeader1: TRLBand;
  BandHeader2: TRLBand;
  BandHeader3: TRLBand;
  BandDetail: TRLBand;
  BandFooter: TRLBand;
begin
  qItem.Connection := frmMain.FDConnection1;
  dsItem.DataSet := qItem;
  RelVnd     := Report(dsItem);

  InfRel;

  BandHeader1 := RLBand(RelVnd, btHeader, 19, True, false);

  RLLabel(BandHeader1, 16, 3, -13, 'Relat�rio Gerado em:');
  RLSYStemInfo(BandHeader1, 149, 3, itNow);

  BandHeader2 := RLBand(RelVnd, btHeader, 50, True, false);

  RLLabel(BandHeader2, 241, 6, 26, 'Relat�rio de Venda');

  if (frmFilRel.CheckBox1.Checked = True) then
  begin
    RLLabel(BandHeader2, 275, 32, -13, DateToStr(DateTimePicker1.Date) + ' at� ' + DateToStr(DateTimePicker2.Date));
  end;

  BandHeader3 := RLBand(RelVnd, btHeader, 32, True, false);

  RLLabel(BandHeader3, 37, 10, -13, 'C�d. de Venda');
  RLLabel(BandHeader3, 173, 10, -13, 'Nome');
  RLLabel(BandHeader3, 315, 10, -13, 'C�d. do Cliente');
  RLLabel(BandHeader3, 463, 10, -13, 'Data');
  RLLabel(BandHeader3, 567, 10, -13, 'Quant. de Venda');

  BandDetail := RLBand(RelVnd, btDetail, 24, False, False);

  RLDBText(BandDetail, 37, 10, dsItem, 'id_vnd');
  RLDBText(BandDetail, 173, 10, dsItem, 'nome');
  RLDBText(BandDetail, 315, 10, dsItem, 'id_cli');
  RLDBText(BandDetail, 463, 10, dsItem, 'dt_vnd');
  RLDBText(BandDetail, 567, 10, dsItem, 'vl_qtd');

  BandDetail.BeforePrint := RLBandBeforePrint;

  BandFooter := RLBand(RelVnd, btFooter, 24, False, True);

  RLLabel(BandFooter, 16, 6, -13, 'Total de Vendas:');
  RLDBResult(BandFooter, 126, 6, dsItem, 'vl_qtd', riSum, '', '');


  RelVnd.Preview();
end;


procedure TfrmFilRel.Button2Click(Sender: TObject);
begin
  for var Item in Mapping do
    begin
      Item.Value.Clear;
    end;
    edtNomeCLi.Text := '';
    edtIdCli.Text   := '';
end;

procedure TfrmFilRel.edtIdCliExit(Sender: TObject);
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
        ShowMessage('Cliente n�o encontrado')
      end
      else
      begin
        edtNomeCLi.Text := qCli.FieldByName('nome').AsString;
      end;
    end;
  end;
end;

procedure TfrmFilRel.FormCreate(Sender: TObject);
begin
  qItem.Connection     := frmMain.FDConnection1;
  qCli.Connection      := frmMain.FDConnection1;
  Mapping := TDictionary<String, TFieldExtender>.Create;

//  TableName := 'tb_vnd';
//  IdFieldname := 'id_vnd';

  AddMapping(TNumericFieldExtender.Create('id_cli', edtIdCli, 0));
end;

procedure TfrmFilRel.FormDestroy(Sender: TObject);
begin
  Mapping.Free;
end;

procedure TfrmFilRel.FormShow(Sender: TObject);
begin
//  if (Mapping.Items[IdFieldName].Control is TEdit) then
//  begin
//    TEdit(Mapping.Items[IdFieldName].Control).OnExit := IdOnExit;
//  end;
end;

procedure TfrmFilRel.IdOnExit(ASender: TObject);
var
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
    ShowMessage('Registro n�o encontrado');
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
procedure TfrmFilRel.InfRel;
begin
  with qItem do
  begin
    Close;
    SQL.Clear;

    Sql.Add('Select');
    Sql.Add(' tb_vnd.id_cli, tb_vnd.id_vnd, tb_cli.nome, tb_vnd.dt_vnd, sum(tb_vnd_item.vl_qtd) as qtd, tb_vnd_item.vl_qtd');
    Sql.Add('from tb_vnd');
    Sql.Add('join tb_cli on');
    Sql.Add(' tb_cli.id_cli = tb_vnd.id_cli');
    Sql.Add('join tb_vnd_item on');
    Sql.Add(' tb_vnd_item.id_vnd = tb_vnd.id_vnd');
    Sql.Add('where 1=1');

    if (frmFilRel.CheckBox1.Checked = True) then
    begin
      Sql.Add('   and dt_vnd between :pdat1 and :pdat2');
      ParambyName('pdat1').asDate := frmFilRel.DateTimePicker1.date;
      ParambyName('pdat2').asDate := frmFilRel.DateTimePicker2.date;
    end;

    if (edtIdCli.Text <> '') and (StrToInt(edtIdCli.Text) <> 0) then
    begin
      Sql.Add('   and tb_vnd.id_cli = :id_cli');
      ParambyName('id_cli').AsInteger := StrToInt(edtIdCli.Text);
    end;


    Sql.Add('group by');
    Sql.Add(' tb_vnd.id_cli, tb_vnd.id_vnd, tb_cli.nome, tb_vnd.dt_vnd, tb_vnd_item.vl_qtd');
    Sql.Add('order by');
    Sql.Add(' tb_vnd.id_vnd');

    Open;
  end;
end;

end.
