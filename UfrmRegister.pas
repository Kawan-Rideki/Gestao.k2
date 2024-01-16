unit UfrmRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmDefault, Vcl.StdCtrls, Vcl.ExtCtrls, UAppLibrary, System.Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask;

type
  TfrmRegister = class(TfrmDefault)
    Panel1: TPanel;
    btnSave: TButton;
    btnNew: TButton;
    qItem: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public

    Mapping: TDictionary<String, TFieldExtender>;
    TableName: String;
    IdFieldname: String;
    procedure AddMapping(AFieldExtender: TFieldExtender);
    procedure IdOnExit(ASender: TObject);
    procedure AfterSave; virtual;
    procedure AfterLoad; virtual;
  end;

var
  frmRegister: TfrmRegister;

implementation

uses
  UfrmMain;

{$R *.dfm}

{ TfrmRegister }

procedure TfrmRegister.AddMapping(AFieldExtender: TFieldExtender);
begin
  Mapping.Add(AFieldExtender.FieldName, AFieldExtender)
end;

procedure TfrmRegister.AfterLoad;
begin

end;

procedure TfrmRegister.AfterSave;
begin

end;

procedure TfrmRegister.btnNewClick(Sender: TObject);
begin
  inherited;

  for var Item in Mapping do
    begin
      Item.Value.Clear;
    end;
end;

procedure TfrmRegister.btnSaveClick(Sender: TObject);
var
  IdValue: Integer;
begin
  inherited;

  qItem.Close;
  qItem.SQL.Clear;
  qItem.SQL.Add('select * from ' + TableName + ' where ' + IdFieldName);

  IdValue := Mapping.Items[IdFieldName].GetValue;

  if (IdValue = 0) then
  begin
      qItem.SQL.Add(' is null');
  end
  else
  begin
    qItem.SQL.Add(' = :' + IdFieldName);
    qItem.ParamByName(IdFieldName).AsInteger := IdValue;
  end;

  qItem.Open;

  qItem.FieldByName(IdFieldName).AutoGenerateValue := arAutoInc;

  if (qItem.IsEmpty) then
  begin
   qItem.Append;
  end
  else
  begin
    qItem.Edit;
  end;

  for var Item in Mapping do
  begin
    if (IdValue = 0) and (Item.Value.FieldName = IdFieldName) then
    begin
  //  qitem.FieldByName(Item.Value.FieldName).Clear;
    end
    else
    begin
     qItem.FieldByName(Item.Value.FieldName).Value := Item.Value.GetValue;
    end;

  end;
  qItem.Post;

  Mapping.Items[idFieldName].SetValue(qItem.FieldByName(IdFieldName).Value);

  AfterSave;

  ShowMessage('Registro salvo com sucesso');

end;

procedure TfrmRegister.FormCreate(Sender: TObject);
begin
  inherited;

  qItem.Connection := frmMain.FDConnection1;

  Mapping := TDictionary<String, TFieldExtender>.Create;
end;

procedure TfrmRegister.FormDestroy(Sender: TObject);
begin
  inherited;
  Mapping.Free;
end;

procedure TfrmRegister.FormShow(Sender: TObject);
begin
  inherited;
  btnNewClick(btnNew);

  if (Mapping.Items[IdFieldName].Control is TEdit) then
  begin
    TEdit(Mapping.Items[IdFieldName].Control).OnExit := IdOnExit;
  end
  else if (Mapping.Items[IdFieldName].Control is TMaskEdit) then
  begin
    TMaskEdit(Mapping.Items[IdFieldName].Control).OnExit := IdOnExit;
  end;
end;

procedure TfrmRegister.IdOnExit(ASender: TObject);
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

end.
