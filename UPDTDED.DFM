�
 TUPDTDEDUCTION 0�  TPF0TUpdTDeductionUpdTDeductionLeft3TopmWidth�Height�Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 	FormStylefsStayOnTopPositionpoScreenCenter
OnActivateFormActivateOnClose	FormClosePixelsPerInch`
TextHeight 
TStatusBar	StatusBarLeft TopRWidth�HeightPanelsWidth�  Width�  Width�   SimplePanelVisible  
TScrollBox
ScrollBox1Left Top WidthlHeightRAlignalClientTabOrder  TLabelLabel4LeftTopPWidthMHeightCaptionEmployee Code:Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabelLabel3LeftTop� WidthOHeightCaptionDeduction Type:Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TSpeedButtonsbtnSearch1LeftXTop`Width1HeightCaption&SearchOnClicksbtnSearch1Click  TLabelLabel5LeftTop Width?HeightCaptionReference #:  TDBTextDBText1LeftTop0WidthQHeight	DataFieldKeyField
DataSourcedsTDeduction  TLabelLabel7Left� TopPWidth1HeightCaption	Lastname:  TDBTextDBText2Left� Top`WidthqHeight	DataFieldLastname
DataSourcedsTDeduction  TLabelLabel1LeftTopPWidth0HeightCaption
Firstname:  TDBTextDBText3LeftTop`WidthqHeight	DataField	Firstname
DataSourcedsTDeduction  TLabelLabel6Left� Top� Width'HeightCaptionAmount:Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabellAmortizationLeft(Top� Width<HeightCaptionAmortization:Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TDBEdit
dbeEmpCodeLeftTop`WidthQHeight	DataFieldEmpCode
DataSourcedsTDeductionTabOrder OnEnterdbeEmpCodeEnterOnExitdbeEmpCodeExit  TDBLookupComboBoxcboxDeductionTypeLeftTop� Width� Height	DataFieldDeductionKey
DataSourcedsTDeductionKeyFieldKeyField	ListFieldName
ListSourceDataSource1TabOrderOnExitcboxDeductionTypeExit  TDBEdit	dbeAmountLeft� Top� WidthIHeight	DataFieldAmount
DataSourcedsTDeductionFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnExitdbeAmountExit  TDBEditdbeAmortizationLeft(Top� WidthIHeight	DataFieldAmortization
DataSourcedsTDeductionFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnExitdbeAmortizationExit  TDBRadioGroup
rgrpSchemeLeft� Top� WidthiHeightQCaption	 Scheme: 	DataFieldScheme
DataSourcedsTDeductionItems.StringsDeduct OnceDeduct AlwaysInstallment TabOrderValues.Strings012 OnClickrgrpSchemeClick  	TGroupBox	GroupBox1LeftTop� Width� HeightyCaption Deduct when payroll type is TabOrder TDBCheckBoxchkSemiMonthlyLeftTopWidthaHeightCaptionSemi-monthly	DataFieldDeductWhenPayType0
DataSourcedsTDeductionTabOrder ValueCheckedYValueUncheckedN  TDBCheckBoxchkIncentiveLeftTop0WidthaHeightCaption	Incentive	DataFieldDeductWhenPayType1
DataSourcedsTDeductionTabOrderValueCheckedYValueUncheckedN  TDBCheckBoxchk13thMthPayLeftTopHWidthaHeightCaption13th Month Pay	DataFieldDeductWhenPayType2
DataSourcedsTDeductionTabOrderValueCheckedYValueUncheckedN  TDBCheckBox	chkWeeklyLeftTop`WidthaHeightCaptionWeekly	DataFieldDeductWhenPayType3
DataSourcedsTDeductionTabOrderValueCheckedYValueUncheckedN    TPanelPanel1LeftlTop WidthaHeightRAlignalRightTabOrder TButtonbtnOkLeftTopWidthQHeight!Caption&OkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style ModalResult
ParentFontTabOrder OnClick
btnOkClick  TButton	btnCancelLeftTop@WidthRHeight!Caption&CancelFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style ModalResult
ParentFontTabOrder   TDataSourcedsTDeductionDataSettTDeductLeft� Top  TTabletDeductionTypeDatabaseNamePayrollIndexFieldNamesKeyFieldMasterFieldsDeductionKeyMasterSourcedsTDeduction	TableName	DEDUCT.DBLeftTop  TDataSourcedsDeductionTypeDataSettDeductionTypeLeftTop  TTable	tEmployeeDatabaseNamePayrollIndexFieldNamesEmpCodeMasterFieldsEmpCodeMasterSourcedsTDeduction	TableNameEMPLOYEE.DBLeft8Top TStringFieldtEmployeeEmpCode	FieldNameEmpCodeSize
  TStringFieldtEmployeePosition	FieldNamePositionSize   TDataSource
dsEmployeeDataSet	tEmployeeLeft@Top  TTable	tPositionDatabaseNamePayrollIndexFieldNamesKeyFieldMasterFieldsPositionMasterSource
dsEmployee	TableNamePOSITION.DBLeft`Top  TDataSource
dsPositionDataSet	tPositionLefthTop  TTable	tJobGroupDatabaseNamePayrollIndexFieldNamesKeyFieldMasterFieldsJobGroupMasterSource
dsPosition	TableName	JOBGRP.DBLeft�Top TStringFieldtJobGroupKeyField	FieldNameKeyFieldSize   TTabletDeductLookupDatabaseNamePayroll	IndexNameByName	TableName	DEDUCT.DBLeft� Top  TDataSourceDataSource1DataSettDeductLookupLeft� Top  TQueryqryTotalApplied	AfterOpenqryTotalAppliedAfterOpenLeft�Topj  TQueryqryTotalPaid	AfterOpenqryTotalPaidAfterOpenLeft�Topj  TTabletTDeductDatabaseNamePayroll	TableName
Tdeduct.DBLeft� Top
 TIntegerFieldtTDeductKeyField	FieldNameKeyField  
TDateFieldtTDeductDate	FieldNameDate  TStringFieldtTDeductDeductionKey	FieldNameDeductionKeySize  TFloatFieldtTDeductAmount	FieldNameAmountDisplayFormat#,##0.00  TStringFieldtTDeductApprovedBy	FieldName
ApprovedBySize
  TStringFieldtTDeductDeductWhen	FieldName
DeductWhenSize  TStringFieldtTDeductScheme	FieldNameSchemeSize  TFloatFieldtTDeductAmortization	FieldNameAmortizationRequired	DisplayFormat#,##0.00  TStringFieldtTDeductGuarantor	FieldName	GuarantorSize
  TStringFieldtTDeductStatus	FieldNameStatusSize  TStringFieldtTDeductFullyPaid	FieldName	FullyPaidSize  TStringFieldtTDeductGuarantor2	FieldName
Guarantor2Size
  TStringFieldtTDeductLastname	FieldNameLastnameLookupKeyFieldsEmpCodeLookupResultFieldLastname	KeyFieldsEmpCodeLookup	  TStringFieldtTDeductFirstname	FieldName	FirstnameLookupKeyFieldsEmpCodeLookupResultField	Firstname	KeyFieldsEmpCodeLookup	  TStringFieldtTDeductGLastname	FieldName	GLastnameLookupKeyFieldsEmpCodeLookupResultFieldLastname	KeyFields	GuarantorLookup	  TStringFieldtTDeductGFirstname	FieldName
GFirstnameLookupKeyFieldsEmpCodeLookupResultField	Firstname	KeyFields	GuarantorLookup	  TStringFieldtTDeductG2Lastname	FieldName
G2LastnameLookupKeyFieldsEmpCodeLookupResultFieldLastname	KeyFields
Guarantor2Lookup	  TStringFieldtTDeductG2Firstname	FieldNameG2FirstnameLookupKeyFieldsEmpCodeLookupResultField	Firstname	KeyFields
Guarantor2Lookup	  TStringFieldtTDeductEmpCode	FieldNameEmpCodeSize
  TFloatFieldtTDeductEmployerShare	FieldNameEmployerShareDisplayFormat#,##0.00  TStringFieldtTDeductDeductWhenPayType0	FieldNameDeductWhenPayType0Size  TStringFieldtTDeductDeductWhenPayType1	FieldNameDeductWhenPayType1Size  TStringFieldtTDeductDeductWhenPayType2	FieldNameDeductWhenPayType2Size  TStringFieldtTDeductDeductWhenPayType3	FieldNameDeductWhenPayType3Size  TStringFieldtTDeductDeductWhenPayType4	FieldNameDeductWhenPayType4Size  TFloatFieldtTDeductLoanamt	FieldNameLoanamt    