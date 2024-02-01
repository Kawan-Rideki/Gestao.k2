unit UfrmFinGrpRel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB, RLParser;

type
  TfrmFinGrpRel = class(TForm)
    RelFin: TRLReport;
    RLBand1: TRLBand;
    RLLabel6: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLLabel8: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLLabel7: TRLLabel;
    RLDBText4: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel4: TRLLabel;
    dsItem: TDataSource;
    RLExpressionParser1: TRLExpressionParser;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLLabel9: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel11: TRLLabel;
    RLDBResult3: TRLDBResult;
    RLDBResult4: TRLDBResult;
    RLBand6: TRLBand;
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFinGrpRel: TfrmFinGrpRel;

implementation

{$R *.dfm}

procedure TfrmFinGrpRel.RLBand3BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
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
