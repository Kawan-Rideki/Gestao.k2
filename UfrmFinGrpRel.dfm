�
 TFRMFINGRPREL 0�  TPF0TfrmFinGrpRelfrmFinGrpRelLeft Top CaptionfrmFinGrpRelClientHeight�ClientWidthKColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameSegoe UI
Font.Style 
TextHeight 	TRLReportRelFinLeft^Top�WidthHeightcFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style ExpressionParserRLExpressionParser1 TRLBandRLBand1Left&Top&Width�HeightKBandTypebtTitleBorders.SidessdCustomBorders.DrawLeftBorders.DrawTopBorders.DrawRightBorders.DrawBottom	 TRLLabelRLLabel6Left� TopWidth� Height	AlignmenttaCenterCaption   Relatório FinanceiroFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height	Font.NameArial
Font.Style 
ParentFont  TRLSystemInfoRLSystemInfo1Left� TopWidth&HeightInfoitNowText      TRLLabelRLLabel2LeftTopWidthHeightCaption   Relatório Gerado em:  TRLLabelRLLabel8LeftTop2Width:Height   TRLGroupRLGroup1Left&TopqWidth�Height� 
DataFieldsid_cli TRLBandRLBand2Left Top Width�Height2BandTypebtHeaderBorders.SidessdCustomBorders.DrawLeftBorders.DrawTopBorders.DrawRightBorders.DrawBottom	Color?z� ParentColorTransparent TRLLabelRLLabel7LeftTopWidth,HeightCaptionClienteFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameArial
Font.Style 
ParentFont  	TRLDBText	RLDBText4LeftCTopWidth"Height	DataFieldid_cli
DataSourcedsItemFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameArial
Font.Style 
ParentFontText      	TRLDBText	RLDBText3Left� TopWidth$Height	DataFieldnome
DataSourcedsItemFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameArial
Font.Style 
ParentFontText      TRLLabel LeftCTopWidthIHeightCaptionDt de Emis.Font.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameArial
Font.Style 
ParentFont  TRLLabelRLLabel9Left� TopWidth/HeightCaptionVl. RecFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameArial
Font.Style 
ParentFont  TRLLabel Left� TopWidthIHeightCaptionDt de Venc.Font.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameArial
Font.Style 
ParentFont  TRLLabel LeftTopWidth,HeightCaption   CódigoFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameArial
Font.Style 
ParentFont  TRLLabelRLLabel5Left{TopWidth>HeightCaption   DescriçãoFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameArial
Font.Style 
ParentFont  TRLLabel	RLLabel10Left3TopWidth/HeightCaptionVl. DesFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameArial
Font.Style 
ParentFont  TRLLabel	RLLabel14Left�TopWidth/HeightCaptionOp. FinFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameArial
Font.Style 
ParentFont  TRLLabel	RLLabel15LeftTopWidth:HeightCaptionNum DocFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameArial
Font.Style 
ParentFont   TRLBandRLBand3Left Top2Width�HeightBorders.SidessdCustomBorders.DrawLeftBorders.DrawTopBorders.DrawRightBorders.DrawBottom	BeforePrintRLBand3BeforePrint 	TRLDBText	RLDBText5Left{TopWidth$Height	DataFielddescr
DataSourcedsItemText      	TRLDBText	RLDBText1LeftCTopWidth/Height	DataFielddt_ems
DataSourcedsItemText      	TRLDBText	RLDBText2Left� TopWidth%Height	AlignmenttaRightJustify	DataFieldvl_rec
DataSourcedsItemText      	TRLDBText	RLDBText6Left� TopWidth)Height	DataFielddt_vnc
DataSourcedsItemText      	TRLDBText	RLDBText7Left3TopWidth(Height	AlignmenttaRightJustify	DataFieldvl_des
DataSourcedsItemText      	TRLDBText	RLDBText8Left�TopWidth%Height	DataFieldop_fin
DataSourcedsItemText      	TRLDBText	RLDBText9LeftTopWidth"Height	DataFieldid_fin
DataSourcedsItemText      	TRLDBText
RLDBText10LeftTopWidth9Height	DataFieldnum_doc
DataSourcedsItemText       TRLBandRLBand4Left Top[Width�Height&BandTypebtFooterBorders.SidessdCustomBorders.DrawLeftBorders.DrawTopBorders.DrawRightBorders.DrawBottom	 TRLLabelRLLabel1LeftTopWidthWHeightCaptionSubtotal Rec.:  TRLLabelRLLabel4Left�TopWidthSHeightCaptionSubtotal Des.  TRLDBResultRLDBResult1LeftuTopWidth� HeightDataFormulasum(vl_rec)
DataSourcedsItemDisplayMaskR$ ###,###,###,##0.00Text      TRLDBResultRLDBResult2Left TopWidth� HeightDataFormulasum(vl_des)
DataSourcedsItemDisplayMaskR$ ###,###,###,##0.00Text       TRLBandRLBand6Left TopKWidth�HeightBandTypebtFooter   TRLBandRLBand5Left&TopWidth�Height!BandType	btSummary TRLLabelRLLabel3Left TopWidthCHeightCaptionTotal Rec.:  TRLLabel	RLLabel11Left�TopWidth?HeightCaption
Total Des.  TRLDBResultRLDBResult3LeftiTopWidth� HeightDataFormulasum(vl_rec)
DataSourcedsItemDisplayMaskR$ ###,###,###,##0.00Text      TRLDBResultRLDBResult4LeftTopWidth� HeightDataFormulasum(vl_des)
DataSourcedsItemDisplayMaskR$ ###,###,###,##0.00Text        TDataSourcedsItemLeftTopp  TRLExpressionParserRLExpressionParser1Left�Top�   