unit UfrmFilRel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmRegister, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, UAppLibrary, Vcl.ComCtrls, Datasnap.DBClient, System.Generics.Collections;

type
  TfrmFilRel = class(TForm)
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
begin
  frmVndRel                  := TfrmVndRel.Create( self );
  if (frmFilRel.CheckBox1.Checked = True) then
  begin
    frmVndRel.RLLabel8.Caption := DateToStr(DateTimePicker1.Date) + ' até ' + DateToStr(DateTimePicker2.Date);
  end;
  qItem.Connection := frmMain.FDConnection1;
  frmVndRel.dsItem.DataSet := qItem;
  frmVndRel.RelVnd.DataSource := frmVndRel.dsItem;
  InfRel;
  frmVndRel.RelVnd.Preview();
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
        ShowMessage('Cliente não encontrado')
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
