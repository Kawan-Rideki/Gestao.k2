unit UfrmDefault;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, RLConsts, Data.DB, RLParser, Vcl.StdCtrls, Vcl.ExtCtrls, UAppLibrary,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, System.JSON;

type
  TfrmDefault = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    function Report(DS: TDataSource): TRLReport;
    function RLBand(AParent: TWinControl; ABandType: TRLBandType; AHeight: Integer; ABorderBottom: Boolean; ABorderTop: Boolean): TRLBand;
    function RLLabel(AParent: TWinControl; ALeft: Integer; ATop: Integer; AHeight: Integer; ACaption: String): TRLLabel;
    function RLDBText(AParent: TWinControl; ALeft: Integer; ATop: Integer; ADataSource: TDataSource; ADataField: TRLDataFieldProperty): TRLDBText;
    function RLDBResult(AParent: TWinControl; ALeft: Integer; ATop: Integer; ADataSource: TDataSource; ADataField: TRLDataFieldProperty; AInfo: TRLResultInfo; ADisplayMask: string; ADataFormula: String): TRLDBResult;
    function RLSYStemInfo(AParent: TWinControl; ALeft: Integer; ATop: Integer; AInfo: TRLInfoType): TRLSystemInfo;
    function RLGroup(AParent: TWinControl; AHeight: Integer; ABorderBottom: Boolean; ADataFields: String): TRLGroup;
    function LLabel(AParent: TWinControl; ALeft: Integer; ATop: Integer; AWidth: Integer; ACaption: String): TLabel;
    function EEdit(AParent: TWinControl; ALeft: Integer; ATop: Integer; AWidth: Integer; AText: String = ''; AVisible: Boolean = True): TEdit;
    procedure Color(ASender: TObject);
    procedure RLBandBeforePrint(ASender: TObject; var PrintIt: Boolean);
    property Action;
  end;

var
  frmDefault: TfrmDefault;

implementation

{$R *.dfm}

procedure TfrmDefault.Color(ASender: TObject);
begin
  if (ASender is TRLBand) then
  begin
    TRLBand(ASender).Color := $00A67A3F;
  end;
end;

function TfrmDefault.EEdit(AParent: TWinControl; ALeft, ATop,
  AWidth: Integer; AText: String; AVisible: Boolean): TEdit;
begin
  Result := TEdit.Create(Self);

  with Result do
  begin
    Parent  := AParent;
    Left    := ALeft;
    Top     := ATop;
    Width   := AWidth;
    Text    := AText;
    Visible := AVisible;
  end;
end;

procedure TfrmDefault.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if (FormStyle = fsMDIChild) then
  begin
    Action := TCloseAction.caFree;
  end;
end;

function TfrmDefault.LLabel(AParent: TWinControl; ALeft, ATop, AWidth: Integer;
  ACaption: String): TLabel;
begin
  Result := TLabel.Create(self);

  with result do
  begin
    Parent  := AParent;
    Left    := ALeft;
    Top     := ATop;
    Caption := ACaption;
    Width   := AWidth;
  end;
end;

function TfrmDefault.RLBand(AParent: TWinControl; ABandType: TRLBandType;
  AHeight: Integer; ABorderBottom: Boolean; ABorderTop: Boolean): TRLBand;
begin
  Result := TRLBand.Create(Self);

  with Result do
  begin
    Parent             := AParent;
    BandType           := ABandType;
    Height             := AHeight;
    Borders.DrawBottom := ABorderBottom;
    Borders.DrawTop    := ABorderTop;
  end;
end;

procedure TfrmDefault.RLBandBeforePrint(ASender: TObject; var PrintIt: Boolean);
begin

  if (ASender is TRLBand) then
  begin
    if TRLBand(ASender).Color=clwhite then
    begin
      TRLBand(ASender).Color:=cl3dlight
    end
    else
    begin
      TRLBand(ASender).Color:=clwhite;
    end;
  end;
end;

function TfrmDefault.RLDBResult(AParent: TWinControl; ALeft, ATop: Integer;
  ADataSource: TDataSource; ADataField: TRLDataFieldProperty;
  AInfo: TRLResultInfo; ADisplayMask: string; ADataFormula: String): TRLDBResult;
begin
  Result := TRLDBResult.Create(Self);
  with Result do
  begin
    Parent      := AParent;
    Left        := ALeft;
    Top         := ATop;
    DataSource  := ADataSource;
    DataField   := ADataField;
    Info        := AInfo;
    DisplayMask := ADisplayMask;
    DataFormula := ADataFormula;
  end;

end;

function TfrmDefault.RLDBText(AParent: TWinControl; ALeft, ATop: Integer;
  ADataSource: TDataSource; ADataField: TRLDataFieldProperty): TRLDBText;
begin
  Result := TRLDBText.Create(Self);

  with Result do
  begin
    Parent     := AParent;
    Left       := ALeft;
    Top        := ATop;
    DataSource := ADataSource;
    DataField  := ADataField;
  end;
end;

function TfrmDefault.RLGroup(AParent: TWinControl; AHeight: Integer;
  ABorderBottom: Boolean; ADataFields: String): TRLGroup;
begin
  Result := TRLGroup.Create(Self);

  with Result do
  begin
    Parent             := AParent;
    Height             := AHeight;
    Borders.DrawBottom := ABorderBottom;
    DataFields         := ADataFields;
  end;
end;

function TfrmDefault.RLLabel(AParent: TWinControl; ALeft, ATop, AHeight: Integer; ACaption: String): TRLLabel;
begin
  Result := TRLLabel.Create(Self);

  with Result do
  begin
    Parent      := AParent;
    Left        := ALeft;
    Top         := ATop;
    Caption     := ACaption;
    Font.Height := AHeight;
  end;
end;
function TfrmDefault.RLSYStemInfo(AParent: TWinControl; ALeft, ATop: Integer;
  AInfo: TRLInfoType): TRLSystemInfo;
begin
  Result := TRLSystemInfo.Create(Self);

  with Result do
  begin
    Parent     := AParent;
    Left       := ALeft;
    Top        := ATop;
    Info       := AInfo;
  end;
end;

function TfrmDefault.Report(DS: TDataSource): TRLReport;
begin
  Result := TRLReport.Create(Self);

  with result do
  begin
    DataSource := DS;
    ExpressionParser := TRLExpressionParser.Create(Self);
  end;
end;

end.
