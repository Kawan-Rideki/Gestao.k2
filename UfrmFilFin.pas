unit UfrmFilFin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmRegister, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, UAppLibrary, Vcl.ComCtrls, Datasnap.DBClient, System.Generics.Collections;

type
  TfrmFilFin = class(TForm)
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
begin
  if (RadioButton1.Checked = True) then
  begin
    frmFinRel                  := TfrmFinRel.Create( self );
    if (edtNomeCli.Text = '') then
    begin
      frmFinRel.RLLabel10.Caption := '';
      frmFinRel.RLLabel9.Caption  := '';
    end
    else
    begin
      frmFinRel.RLLabel10.Caption := edtNomeCli.Text;
    end;
    qItem.Connection := frmMain.FDConnection1;
    frmFinRel.dsItem.DataSet := qItem;
    frmFinRel.RelFin.DataSource := frmFinRel.dsItem;
    InfRel;
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
    frmFinRel.RLLabel14.caption := formatfloat('R$ ###,###,###,##0.00',VlRct);
    frmFinRel.RLLabel15.caption := formatfloat('R$ ###,###,###,##0.00', VlDesp);
    frmFinRel.RelFin.Preview();
  end
  else if (RadioButton2.Checked = True) then
  begin
    frmFinGrpRel                  := TfrmFinGrpRel.Create( self );
    qItem.Connection := frmMain.FDConnection1;
    frmFinGrpRel.dsItem.DataSet   := qItem;
    frmFinGrpRel.RelFin.DataSource := frmFinGrpRel.dsItem;
    InfRel;
    frmFinGrpRel.RelFin.Preview();
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
