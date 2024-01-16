unit UfrmFinRel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB;

type
  TfrmFinRel = class(TForm)
    RelFin: TRLReport;
    RLBand1: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLBand3: TRLBand;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLBand5: TRLBand;
    RLLabel1: TRLLabel;
    RLBand2: TRLBand;
    RLLabel6: TRLLabel;
    RLLabel8: TRLLabel;
    RLBand4: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel7: TRLLabel;
    dsItem: TDataSource;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLDBText6: TRLDBText;
    RLLabel11: TRLLabel;
    RLDBText7: TRLDBText;
    RLLabel12: TRLLabel;
    RLDBText8: TRLDBText;
    RLLabel4: TRLLabel;
    RLDBText9: TRLDBText;
    RLLabel13: TRLLabel;
    RLDBText10: TRLDBText;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFinRel: TfrmFinRel;

implementation

{$R *.dfm}

procedure TfrmFinRel.RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
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
