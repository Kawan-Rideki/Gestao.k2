unit UfrmConBancRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmRegister, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, UAppLibrary;

type
  TfrmConBancRegister = class(TfrmRegister)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  frmConBancRegister: TfrmConBancRegister;

implementation

{$R *.dfm}

uses
UfrmMain;

procedure TfrmConBancRegister.FormCreate(Sender: TObject);
var
IdConBanc: TEdit;
Descr: TEdit;
CodCed: Tedit;
Codbanc: TEdit;
Conta: TEdit;
Agen: TEdit;
begin
  inherited;
  LLabel(Self, 16, 43, 255 ,'Código');
  LLabel(Self, 143, 43, 255 ,'Descrição');
  IdConBanc := EEDit(Self, 16, 64, 121);
  Descr  := EEDit(Self, 143, 64, 274);

  LLabel(Self, 16, 93, 255 ,'Código Cedente');
  LLabel(Self, 143, 93, 255 ,'Código Bancário');
  CodCed  := EEDit(Self, 16, 120, 121);
  CodBanc := EEDit(Self, 143, 120, 274);

  LLabel(Self, 16, 155, 255 ,'Conta');
  LLabel(Self, 143, 155, 255 ,'Agência');
  Conta := EEDit(Self, 16, 176, 121);
  Agen  := EEDit(Self, 143, 176, 274);

  TableName   := 'tb_con_banc';
  IdFieldname := 'id_con_banc';
  CodEmp      := True;

  AddMapping(TNumericFieldExtender.Create('id_con_banc', IdConBanc, 0));
  AddMapping(TFieldExtender.Create('Descr', Descr));
  AddMapping(TFieldExtender.Create('cod_ced', CodCed));
  AddMapping(TFieldExtender.Create('cod_banc', CodBanc));
  AddMapping(TFieldExtender.Create('conta', Conta));
  AddMapping(TFieldExtender.Create('Agenc', Agen));
end;

end.
