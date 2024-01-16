unit UfrmCatRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmRegister, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, System.JSON, UAppLibrary;

type
  TfrmCatRegister = class(TfrmRegister)
    Label1: TLabel;
    Label2: TLabel;
    edtIdCat: TEdit;
    edtDescr: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCatRegister: TfrmCatRegister;

implementation

{$R *.dfm}

procedure TfrmCatRegister.FormCreate(Sender: TObject);
begin
  inherited;
    TableName := 'tb_cat';
  IdFieldname := 'id_cat';

  AddMapping(TNumericFieldExtender.Create('id_cat', edtIdCat, 0));
  AddMapping(TFieldExtender.Create('descr', edtDescr));

end;

end.
