unit UfrmVndGrpRel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB;

type
  TfrmVndGrpRel = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLLabel6: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLLabel8: TRLLabel;
    dsItem: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVndGrpRel: TfrmVndGrpRel;

implementation

{$R *.dfm}

end.
