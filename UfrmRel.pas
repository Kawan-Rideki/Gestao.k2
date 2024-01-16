unit UfrmRel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmDefault, Vcl.StdCtrls, Vcl.ExtCtrls, UAppLibrary, System.Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask;

type
  TfrmRel = class(TForm)
    qItem: TFDQuery;
  procedure FormCreate(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    Mapping: TDictionary<String, TFieldExtender>;
    TableName: String;
    IdFieldname: String;
    procedure AddMapping(AFieldExtender: TFieldExtender);
    procedure AfterSave; virtual;
    procedure AfterLoad; virtual;
    procedure IdOnExit(ASender: TObject);
  end;

var
  frmRel: TfrmRel;

implementation

uses
  UfrmMain;

{$R *.dfm}

{ TForm2 }

procedure TfrmRel.AddMapping(AFieldExtender: TFieldExtender);
begin
  Mapping.Add(AFieldExtender.FieldName, AFieldExtender)
end;

procedure TfrmRel.AfterLoad;
begin

end;

procedure TfrmRel.AfterSave;
begin

end;

procedure TfrmRel.FormCreate(Sender: TObject);
begin
  qItem.Connection := frmMain.FDConnection1;

  Mapping := TDictionary<String, TFieldExtender>.Create;
end;

procedure TfrmRel.FormDestroy(Sender: TObject);
begin
  Mapping.Free;
end;

procedure TfrmRel.FormShow(Sender: TObject);
begin
  if (Mapping.Items[IdFieldName].Control is TEdit) then
  begin
    TEdit(Mapping.Items[IdFieldName].Control).OnExit := IdOnExit;
  end
  else if (Mapping.Items[IdFieldName].Control is TMaskEdit) then
  begin
    TMaskEdit(Mapping.Items[IdFieldName].Control).OnExit := IdOnExit;
  end;
end;

procedure TfrmRel.IdOnExit(ASender: TObject);
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
