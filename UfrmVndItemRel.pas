unit UfrmVndItemRel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB;

type
  TfrmVndItemRel = class(TForm)
    RelVnd: TRLReport;
    RLBand1: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLBand3: TRLBand;
    RLBand2: TRLBand;
    RLLabel6: TRLLabel;
    RLBand4: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel7: TRLLabel;
    RLDBText6: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText1: TRLDBText;
    dsItem: TDataSource;
    RLLabel5: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLDBText2: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLLabel10: TRLLabel;
    RLDBText9: TRLDBText;
    RLBand5: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel11: TRLLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVndItemRel: TfrmVndItemRel;

implementation

{$R *.dfm}

end.
