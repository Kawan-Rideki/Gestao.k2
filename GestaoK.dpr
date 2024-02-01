program GestaoK;

uses
  Vcl.Forms,
  UfrmMain in 'UfrmMain.pas' {Form1},
  UfrmCliManagerOld in 'UfrmCliManagerOld.pas' {frmCliManagerOld},
  UfrmCliRegisterOld in 'UfrmCliRegisterOld.pas' {FrmCliRegisterOld},
  Vcl.Themes,
  Vcl.Styles,
  UfrmProdManagerOld in 'UfrmProdManagerOld.pas' {frmProdManagerOld},
  UfrmProdRegisterOld in 'UfrmProdRegisterOld.pas' {frmProdRegisterOld},
  UAppLibrary in 'UAppLibrary.pas',
  UfrmDefault in 'UfrmDefault.pas' {frmDefault},
  UfrmRegister in 'UfrmRegister.pas' {frmRegister},
  UfrmManager in 'UfrmManager.pas' {frmManager},
  UfrmCliManager in 'UfrmCliManager.pas' {frmCliManager},
  UfrmCliRegister in 'UfrmCliRegister.pas' {frmCliRegister},
  UfrmProdManager in 'UfrmProdManager.pas' {frmProdManager},
  UfrmProdRegister in 'UfrmProdRegister.pas' {frmProdRegister},
  UfrmVndManager in 'UfrmVndManager.pas' {frmVndManager},
  UfrmVndRegister in 'UfrmVndRegister.pas' {frmVndRegister},
  UfrmVndItemRegister in 'UfrmVndItemRegister.pas' {frmVndItemRegister},
  UfrmCatManager in 'UfrmCatManager.pas' {frmCatManager},
  UfrmCatRegister in 'UfrmCatRegister.pas' {frmCatRegister},
  UfrmMntEstqManager in 'UfrmMntEstqManager.pas' {frmMntEstqManager},
  UfrmMntEstqRegister in 'UfrmMntEstqRegister.pas' {frmMntEstqRegister},
  UfrmMntEstqItemRegister in 'UfrmMntEstqItemRegister.pas' {frmMntEstqItemRegister},
  UfrmCliRel in 'UfrmCliRel.pas' {frmCliRel},
  UfrmVndRel in 'UfrmVndRel.pas' {frmVndRel},
  UfrmFilRel in 'UfrmFilRel.pas' {frmFilRel},
  UfrmRel in 'UfrmRel.pas' {frmRel},
  UfrmVndItemRel in 'UfrmVndItemRel.pas' {frmVndItemRel},
  UfrmFilItemrel in 'UfrmFilItemrel.pas' {frmFilItemRel},
  UfrmFinManager in 'UfrmFinManager.pas' {frmFinManager},
  UfrmFinRegister in 'UfrmFinRegister.pas' {frmFinRegister},
  UfrmFilFin in 'UfrmFilFin.pas' {frmFilFin},
  UfrmFinRel in 'UfrmFinRel.pas' {frmFinRel},
  UfrmVndGrpRel in 'UfrmVndGrpRel.pas' {frmVndGrpRel},
  UfrmFinGrpRel in 'UfrmFinGrpRel.pas' {frmFinGrpRel},
  Teste in 'Teste.pas' {frmTeste},
  UfrmEmpManager in 'UfrmEmpManager.pas' {frmEmpManager},
  UfrmEmpRegister in 'UfrmEmpRegister.pas' {frmEmpRegister},
  UfrmConBancManager in 'UfrmConBancManager.pas' {frmConBancManager},
  UfrmConBancRegister in 'UfrmConBancRegister.pas' {frmConBancRegister},
  UfrmImpBol in 'UfrmImpBol.pas' {frmImpBol},
  UfrmBol in 'UfrmBol.pas' {frmBol};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Aqua Light Slate');
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmVndItemRel, frmVndItemRel);
  Application.Run;
end.
