�
 TUPDCV 0�  TPF0TUpdCVUpdCVLeftWTop3WidthaHeight CaptionNew Check VoucherFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
OnActivateFormActivateOnClose	FormClosePixelsPerInch`
TextHeight TBevelBevel1LeftTopWidth�Height�  TLabelLabel4LeftTop� WidthHeightCaptionBank  TLabelLabel6LeftTop� Width3HeightCaption	Check No.  TLabelLabel7LeftTop� Width*HeightCaptionO.R. No.  TLabelLabel8LeftTopKWidth1HeightCaptionParticulars  TLabelLabel1LeftTopWidthXHeightCaptionCheck VoucherFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TLabelLabel2LeftTopSWidth:HeightCaption
Payee Code  TLabelLabel3LeftTopmWidth=HeightCaption
Payee Name  TLabelLabel5Left"TopWidthBHeightCaptionVoucher Date  TLabelLabel9LeftTopWidthHeightCaptionNoFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TDBTextdbtSuppnameLeftpTopmWidthqHeightColorclCaptionText	DataFieldsuppname
DataSourceBrowVoucher.dsPaymentHdParentColor  TSpeedButton
sbSupplierLeftpTop0WidthyHeightCaption&Search SupplierOnClick
SearchSupp  TLabelLabel10Left2Top� Width$HeightCaptionAmount  TDBText	dbtAmountLeftpTop� WidthtHeight	AlignmenttaRightJustifyColorclCaptionText	DataFieldAmount
DataSourceBrowVoucher.dsPaymentHdParentColor  TLabelLabel11LeftTop� Width9HeightCaption
Check Date  TLabelLabel12LeftTopWidthHeightCaptionTin  TDBEditdbeCVNoLeftoTopWidthyHeight	DataFieldCVNO
DataSourceBrowVoucher.dsPaymentHdReadOnly	TabOrder   TDBEditdbeDatePaidLeftmTopWidthyHeight	DataFieldDatePaid
DataSourceBrowVoucher.dsPaymentHdTabOrder  TDBEditdbeSuppCodeLeftnTopPWidthyHeight	DataFieldSuppCode
DataSourceBrowVoucher.dsPaymentHdTabOrder  TDBEdit
dbeCheckNoLeftnTop� WidthwHeight	DataFieldCheckNo
DataSourceBrowVoucher.dsPaymentHdReadOnly	TabOrder  TDBEditdbeOrNoLeftnTop� WidthwHeight	DataFieldORNo
DataSourceBrowVoucher.dsPaymentHdTabOrder  TDBMemo	dbmRemarkLeftTop`Width�Heightt	DataFieldRemark
DataSourceBrowVoucher.dsPaymentHdTabOrder
  TButtonbtnOkLeftTop
WidthKHeightCaption&OkModalResultTabOrder  TButton	btnCancelLeftTop0WidthKHeightCaption&CancelModalResultTabOrder  TDBLookupComboBoxdblcBankCodeLeftoTop� Width� Height	DataFieldBankCode
DataSourceBrowVoucher.dsPaymentHdKeyFieldBankCode	ListFieldBankName
ListSourcedsBankTabOrderOnClickAddCheck  TDBCheckBoxdbcDeptLeftTop4WidthoHeightCaptionPer Department ? 	DataFieldDept
DataSourceBrowVoucher.dsPaymentHdTabOrderValueCheckedTrueValueUncheckedFalse  TDBCheckBoxdbcewtLeft� Top3WidthYHeightCaption
With EWT ?	DataFieldEWT
DataSourceBrowVoucher.dsPaymentHdTabOrderValueCheckedTrueValueUncheckedFalse  TDBCheckBox	dbFullPayLeft� Top4Width\HeightCaptionFull Payment ?	DataFieldFullpay
DataSourceBrowVoucher.dsPaymentHdTabOrderValueCheckedTrueValueUncheckedFalse  TDBCheckBoxdbcChkStatusLeft;Top3WidthaHeightCaptionCheck Printed ?	DataFieldStatus
DataSourceBrowVoucher.dsPaymentHdReadOnly	TabOrderValueCheckedTrueValueUncheckedFalse  TDBEditdbeCheckDateLeftnTop� WidthvHeight	DataField	CheckDate
DataSourceBrowVoucher.dsPaymentHdTabOrder	  	TCheckBox
cbSupplierLeftTop5WidthSHeightCaptionSupplierState	cbCheckedTabOrderOnClickSuppFunc  TDBEditdbePayeeNameLeftnTopmWidthsHeight	DataField	PayeeName
DataSourceBrowVoucher.dsPaymentHdEnabledTabOrder  TDBEdit	dbeAmountLeftpTop� WidthyHeight	DataFieldAmount
DataSourceBrowVoucher.dsPaymentHdEnabledTabOrderVisible  TDBEditdbeTinLeftmTopWidthyHeight	DataFieldTin
DataSourceBrowVoucher.dsPaymentHdTabOrder  TRadioGroup
rgTranTypeLeftXTop� WidthyHeightiCaption	Tran Type	ItemIndex Items.StringsNormalVatNon Vat
Zero Rated TabOrderOnClickTranTypeFunc  	TCheckBoxcbCancelLeft�Top2WidthVHeightCaptionCancel  CV ?TabOrderOnClickCancelCV  TDataSourcedsBankDataSetBrowVoucher.tBankLeftTopp   