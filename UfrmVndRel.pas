unit UfrmVndRel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, UAppLibrary, System.Generics.Collections;

type
  TfrmVndRel = class(TForm)
    RelVnd: TRLReport;
    RLBand1: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLBand3: TRLBand;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLBand5: TRLBand;
    RLLabel1: TRLLabel;
    RLBand2: TRLBand;
    RLLabel6: TRLLabel;
    RLBand4: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    dsItem: TDataSource;
    RLLabel5: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLLabel7: TRLLabel;
    RLDBText3: TRLDBText;
    RLDBResult2: TRLDBResult;
    RLLabel8: TRLLabel;
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVndRel: TfrmVndRel;

implementation

uses
  UfrmMain, UfrmFilRel;

{$R *.dfm}



procedure TfrmVndRel.RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  if rlband3.Color=clwhite then
  begin
    rlband3.Color:=cl3dlight
  end
  else
  begin
    rlband3.Color:=clwhite;
  end;
end;

end.
