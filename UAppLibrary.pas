unit UAppLibrary;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, StrUtils, Vcl.ComCtrls;

type
  TFieldExtender = class(TComponent)
    protected
       procedure Apply; virtual;
    public
    Control: TwinControl;
    FieldName: String;
      constructor Create(AFieldName: String; AControl: TWinControl);
      destructor Destroy;

      procedure Clear; virtual;

      function GetValue: Variant; virtual;
      function SetValue(AValue: Variant): TFieldExtender; virtual;
  end;

  TNumericFieldExtender = class(TFieldExtender)
  protected
    ControlExit: TNotifyEvent;
    procedure Apply; override;
    procedure OnKeyPress(ASender: TObject; var AKey: Char);
    procedure OnEnter(ASender: TObject);
    procedure OnExit(ASender: TObject);
  public
    Decimals: Integer;
    constructor Create(AFieldName: String; AControl: TWinControl; ADecimals: Integer = 0);

    function GetValue: Variant; virtual;
    function SetValue(AValue: Variant): TFieldExtender; virtual;

    function GetMask: String;

    procedure Clear; override;
  end;

  TDateFieldExtender = class(TFieldExtender)
    protected

    public
        function GetValue: Variant; override;
    function SetValue(AValue: Variant): TFieldExtender; override;
    procedure Clear; override;
  end;

function TextToFloat(Avalue: String): Double;

implementation

{ TFieldExtender }

{ TFieldExtender }

procedure TFieldExtender.Apply;
begin
  if (Control is TComboBox) then
    begin
      TComboBox(Control).Style := csDropDownList;
    end;
end;

procedure TFieldExtender.Clear;
begin
  if (Control is TCustomEdit) then
  begin
    TCustomEdit(Control).Text := '';
  end
  else if (Control is TComboBox) then
  begin
    TComboBox(Control).ItemIndex := 0;
  end;
end;

constructor TFieldExtender.Create(AFieldName: String; AControl: TWinControl);
begin
  Control := AControl;
  FieldName := AFieldName;
  Apply;
end;

destructor TFieldExtender.Destroy;
begin

end;

function TFieldExtender.GetValue: Variant;
begin
   Result := '';

    if (Control is TCustomEdit) then
    begin
      Result := TCustomEdit(Control).Text;
    end
    else if (Control is TComboBox) then
    begin
      Result := TComboBox(Control).Text;
    end;
end;

function TFieldExtender.SetValue(AValue: Variant): TFieldExtender;
var
  Index: Integer;
begin
  if (Control is TCustomEdit) then
  begin
    TCustomEdit(Control).Text := AValue;
  end
   else if (Control is TComboBox) then
  begin
    Index := TComboBox(Control).Items.IndexOf(AValue);

    if (Index >= 0) then
    begin
      TComboBox(Control).ItemIndex := Index;
    end;
  end;

  Result := Self;
end;

{ TNumericFieldExtender }


{ TDateFieldExtender }



{ TNumericFieldExtender }

procedure TNumericFieldExtender.Apply;
begin

  inherited;

  if (Control is TMaskEdit) then
  begin
    if (Assigned(TMaskEdit(Control).OnExit)) then
    begin
     ControlExit := TMaskEdit(Control).OnExit;
    end;

    TMaskEdit(Control).OnKeyPress := OnKeyPress;
    TMaskEdit(Control).OnEnter    := OnEnter;
    TMaskEdit(Control).OnExit     := OnExit;
    TMaskEdit(Control).Alignment  := TAlignment.taRightJustify;
    TMaskEdit(Control).Text       := '';
    TMaskEdit(Control).OnExit(Control);
  end
  else if (Control is TEdit) then
  begin
   if (Assigned(TEdit(Control).OnExit)) then
    begin
     ControlExit := TEdit(Control).OnExit;
    end;

    TEdit(Control).OnKeyPress := OnKeyPress;
    TEdit(Control).OnEnter    := OnEnter;
    TEdit(Control).OnExit     := OnExit;
    TEdit(Control).Alignment  := TAlignment.taRightJustify;
    TEdit(Control).Text       := '';
    TEdit(Control).OnExit(Control);

  end;

end;

procedure TNumericFieldExtender.Clear;
begin
  inherited;

  if (Control is TCustomEdit) then
  begin
    TCustomEdit(Control).Text := FormatFloat(GetMask, 0);
  end;
end;

constructor TNumericFieldExtender.Create(AFieldName: String; AControl: TWinControl;
  ADecimals: Integer);
begin
  Decimals    := ADecimals;
  ControlExit := Nil;

  inherited Create(AFieldName, AControl);
end;

function TNumericFieldExtender.GetValue: Variant;
begin
  Result := 0;

  if (Control is TCustomEdit) then
  begin
    if (TCustomEdit(Control).Text <> '') then
    begin
    Result := TextToFloat(TCustomEdit(Control).Text);
    end;
  end;
end;

function TNumericFieldExtender.GetMask: String;
begin
  Result := '###,###,###,##0';

  if (Decimals > 0) then
  begin
    Result := '.' + DupeString('0', Decimals);
  end;
end;

procedure TNumericFieldExtender.OnEnter(ASender: TObject);
begin
if (Control is TCustomEdit) then

begin
  TCustomEdit(Control).Text := Trim(AnsiReplaceStr(TCustomEdit(Control).Text, FormatSettings.ThousandSeparator, ''));

end;
end;

procedure TNumericFieldExtender.OnExit(ASender: TObject);
var
  Value: Double;
begin
  if (Control is TCustomEdit) then
  begin
    Value := StrToFloatDef(TMaskEdit(Control).Text, 0);
    TCustomEdit(Control).Text := FormatFloat(GetMask, Value);
  end;

  if (Assigned(ControlExit)) then
  begin
    ControlExit(ASender);
  end;
end;

procedure TNumericFieldExtender.OnKeyPress(ASender: TObject; var AKey: Char);
begin
 if (AKey = '.') and (Pos(FormatSettings.DecimalSeparator, TCustomEdit(control).Text) = 0) and (Decimals <> 0) then
  begin
    AKey := ',';
    Exit;
  end;
  if (Copy(TCustomEdit(control).Text, 1, 1) = '=') or (AKey = '=') then
  begin
    if (not (AKey in ['0'..'9', '+', '-', 'x', 'X', '*', '/', '(', ')', ' ', '=', '%', #13, #27, #8,
      FormatSettings.DecimalSeparator, #17, ^V, ^C, ^X])) then
    begin
      AKey := #0;
    end;
    exit;
  end;
  if (Pos(FormatSettings.DecimalSeparator, TCustomEdit(control).Text) = 0) and (Decimals <> 0) then
  begin
    if (not (AKey in ['0'..'9', '+', '-', 'x', 'X', '*', '/', #13, #27, #8, FormatSettings.DecimalSeparator, #17, ^V, ^C, ^X])) then
    begin
      AKey := #0;
    end;
  end
  else
  begin
    if (not (AKey in ['0'..'9', '+', '-', 'x', 'X', '*', '/', #13, #27, #8, #17, ^V, ^C, ^X])) then
    begin
      AKey := #0;
    end;
  end;
end;

function TNumericFieldExtender.SetValue(AValue: Variant): TFieldExtender;
begin
  if (Control is TCustomEdit) then
  begin
  TCustomEdit(Control).Text := FormatFloat(GetMask, AValue);
  end;

  Result := Self;

end;

function TextToFloat(Avalue: String): Double;
begin
 AValue := Trim(AnsiReplaceStr(AValue, FormatSettings.ThousandSeparator, ''));
 Result := StrToFloat(AValue);
end;
{ TDateFieldExtender }

procedure TDateFieldExtender.Clear;
begin
  TDateTimePicker(Control).Date := Now;
end;

function TDateFieldExtender.GetValue: Variant;
begin
  Result := TDateTimePicker(Control).Date;
end;

function TDateFieldExtender.SetValue(AValue: Variant): TFieldExtender;
begin
  if (Avalue <> VarNull) then
  begin
    TDateTimePicker(Control).Date := AValue;;
  end;
end;

end.
