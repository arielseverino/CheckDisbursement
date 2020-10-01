unit RepCV;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls, DBTables, Db, StdCtrls;

type
  TcvReport = class(TForm)
    qrepCV: TQuickRep;
    tAccount: TTable;
    dsCV: TDataSource;
    qrlCompname: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    qrlCompName1: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape1: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    PageHeaderBand1: TQRBand;
    QRLabel10: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel14: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    cColLine11: TQRShape;
    cColLine21: TQRShape;
    QRShape10: TQRShape;
    QRLabel11: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    PageFooterBand1: TQRBand;
    QRLabel15: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRShape14: TQRShape;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRShape15: TQRShape;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRShape16: TQRShape;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    tPaymenthd: TTable;
    QRDBText5: TQRDBText;
    tSupplier: TTable;
    QRDBText7: TQRDBText;
    tBank: TTable;
    qryAcctDet: TQuery;
    qryAcctDetCVNO: TStringField;
    qryAcctDetACCTCODE: TStringField;
    qryAcctDetDEPTCODE: TStringField;
    qryAcctDetA: TFloatField;
    qryAcctDetB: TFloatField;
    qryAcctDetamtpaid: TFloatField;
    qryAcctDetdatepaid: TDateField;
    qryAcctDetcheckno: TStringField;
    qryAcctDetsuppcode: TStringField;
    qryAcctDetremark: TMemoField;
    QRDBText3: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText8: TQRDBText;
    QRExpr4: TQRExpr;
    cCheckAmt: TQRMemo;
    QRLabel30: TQRLabel;
    qrlDatePaid: TQRLabel;
    qrlCheckDate: TQRLabel;
    qRepSCheck: TQuickRep;
    qrlChkDate: TQRLabel;
    DetailBand2: TQRBand;
    qrmChkWord: TQRMemo;
    tPaymenthdCVNO: TStringField;
    tPaymenthdSuppCode: TStringField;
    tPaymenthdCheckNo: TStringField;
    tPaymenthdDatePaid: TDateField;
    tPaymenthdAmount: TFloatField;
    tPaymenthdRemark: TMemoField;
    tPaymenthdBankCode: TStringField;
    tPaymenthdVat: TBooleanField;
    tPaymenthdEWT: TBooleanField;
    tPaymenthdDept: TBooleanField;
    tPaymenthdORNo: TStringField;
    tPaymenthdFullpay: TBooleanField;
    tPaymenthdCheckDate: TDateField;
    tPaymenthdStatus: TBooleanField;
    tPaymenthdsuppname: TStringField;
    qryCheck: TQuery;
    qrlcvno: TQRLabel;
    qrlckno: TQRLabel;
    qrdbChkAmt: TQRDBText;
    qRepmCheck: TQuickRep;
    QRLabel12: TQRLabel;
    QRMemo1: TQRMemo;
    QRLabel33: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText9: TQRDBText;
    qMCheck: TQuickRep;
    DetailBand3: TQRBand;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    qryCheckCVNO: TStringField;
    qryCheckSuppCode: TStringField;
    qryCheckcheckno: TStringField;
    qryCheckDatePaid: TDateField;
    qryCheckAmount: TFloatField;
    qryCheckRemark: TMemoField;
    qryCheckBankCode: TStringField;
    qryCheckVat: TBooleanField;
    qryCheckEWT: TBooleanField;
    qryCheckDept: TBooleanField;
    qryCheckORNo: TStringField;
    qryCheckFullpay: TBooleanField;
    qryCheckStatus: TBooleanField;
    qryCheckCheckDate: TDateField;
    tBankBankCode: TStringField;
    tBankBankName: TStringField;
    qryCheckbankname: TStringField;
    qryCheckcheckprinted: TStringField;
    qryCheckcheckword: TStringField;
    CheckReg: TQuickRep;
    TitleBand1: TQRBand;
    ColumnHeaderBand2: TQRBand;
    cCompName: TQRLabel;
    cRepTitle: TQRLabel;
    qrlChkRange: TQRLabel;
    qrllabel1: TQRLabel;
    qrlLabel2: TQRLabel;
    qrlLabel4: TQRLabel;
    QRLabel31: TQRLabel;
    DetailBand4: TQRBand;
    qrdbCheckNo: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText20: TQRDBText;
    qryChecksuppname: TStringField;
    SummaryBand1: TQRBand;
    QRExpr5: TQRExpr;
    QRLabel32: TQRLabel;
    QRDBText21: TQRDBText;
    QRExpr6: TQRExpr;
    PageFooterBand2: TQRBand;
    QRLabel34: TQRLabel;
    PageCtr: TQRSysData;
    VoucherReg: TQuickRep;
    QRBand1: TQRBand;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    qrlVoucherRange: TQRLabel;
    QRBand2: TQRBand;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRBand3: TQRBand;
    QRDBText22: TQRDBText;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRDBText26: TQRDBText;
    QRDBText27: TQRDBText;
    QRBand4: TQRBand;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRBand5: TQRBand;
    QRLabel44: TQRLabel;
    QRSysData1: TQRSysData;
    APsum: TQuickRep;
    QRBand6: TQRBand;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    qrlAPDateSum: TQRLabel;
    QRBand7: TQRBand;
    QRLabel53: TQRLabel;
    QRBand8: TQRBand;
    QRBand9: TQRBand;
    QRExpr9: TQRExpr;
    QRBand10: TQRBand;
    QRLabel54: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel50: TQRLabel;
    qrySalesInv: TQuery;
    qrySalesInvSaleInv: TStringField;
    qrySalesInvPurchNo: TStringField;
    qrySalesInvSIDate: TDateField;
    qrySalesInvSuppCode: TStringField;
    qrySalesInvTermCode: TStringField;
    qrySalesInvGrossAmt: TFloatField;
    qrySalesInvBalance: TFloatField;
    qrySalesInvAmtPaid: TFloatField;
    qrySalesInvDescription: TMemoField;
    qrySalesInvDueDate: TDateField;
    qrySalesInvsuppname: TStringField;
    QRExpr12: TQRExpr;
    VatRegSum: TQuickRep;
    QRBand11: TQRBand;
    QRLabel55: TQRLabel;
    QRLabel56: TQRLabel;
    qrlVatRange: TQRLabel;
    QRBand12: TQRBand;
    QRLabel58: TQRLabel;
    QRLabel60: TQRLabel;
    QRLabel62: TQRLabel;
    QRBand13: TQRBand;
    QRBand14: TQRBand;
    QRExpr13: TQRExpr;
    QRExpr15: TQRExpr;
    QRBand15: TQRBand;
    QRLabel64: TQRLabel;
    QRSysData3: TQRSysData;
    tPaymenthdSupplier: TBooleanField;
    qryAcctDetbankcode: TStringField;
    qryAcctDetsupplier: TBooleanField;
    QRExpr17: TQRExpr;
    qryAcctDetpayeename: TStringField;
    tPaymenthdPayeeName: TStringField;
    qrlSuppName: TQRLabel;
    QRExpr18: TQRExpr;
    qryCheckSupplier: TBooleanField;
    qryCheckPayeeName: TStringField;
    qryCheckchkMonth: TIntegerField;
    qryCheckchkYear: TIntegerField;
    QRExpr19: TQRExpr;
    qryAcctDetPayeeTin: TStringField;
    qryAcctDetcheckDate: TDateField;
    QRExpr20: TQRExpr;
    EWTRegSum: TQuickRep;
    QRBand16: TQRBand;
    QRLabel37: TQRLabel;
    QRLabel57: TQRLabel;
    qrlEWTRange: TQRLabel;
    QRBand17: TQRBand;
    QRLabel63: TQRLabel;
    QRLabel66: TQRLabel;
    QRLabel67: TQRLabel;
    QRBand18: TQRBand;
    QRExpr14: TQRExpr;
    QRBand19: TQRBand;
    QRExpr16: TQRExpr;
    QRExpr21: TQRExpr;
    QRBand20: TQRBand;
    QRLabel68: TQRLabel;
    QRSysData4: TQRSysData;
    JVReg: TQuickRep;
    QRBand21: TQRBand;
    QRLabel47: TQRLabel;
    QRLabel61: TQRLabel;
    qrlJVRange: TQRLabel;
    QRBand22: TQRBand;
    QRLabel70: TQRLabel;
    QRLabel71: TQRLabel;
    QRLabel72: TQRLabel;
    QRLabel73: TQRLabel;
    QRBand23: TQRBand;
    QRExpr22: TQRExpr;
    QRBand24: TQRBand;
    QRExpr23: TQRExpr;
    QRExpr24: TQRExpr;
    QRBand25: TQRBand;
    QRLabel74: TQRLabel;
    QRSysData5: TQRSysData;
    QRLabel69: TQRLabel;
    QRLabel75: TQRLabel;
    QRLabel76: TQRLabel;
    QRLabel77: TQRLabel;
    QRLabel78: TQRLabel;
    QRLabel79: TQRLabel;
    qryAcctDetacctname: TStringField;
    qryAcctDetsuppname: TStringField;
    qryAcctDetbankname: TStringField;
    QRExpr26: TQRExpr;
    tPaymenthdTin: TStringField;
    qryAcctDetnonsupptin: TStringField;
    QRExpr27: TQRExpr;
    QRExpr25: TQRExpr;
    qryAcctDetdebitamt: TFloatField;
    qryAcctDetcreditamt: TFloatField;
    QRExpr28: TQRExpr;
    QRExpr29: TQRExpr;
    EWTRegDet: TQuickRep;
    QRBand26: TQRBand;
    QRLabel59: TQRLabel;
    QRLabel65: TQRLabel;
    qrlEWTSummaryRange: TQRLabel;
    QRBand27: TQRBand;
    QRLabel81: TQRLabel;
    QRLabel82: TQRLabel;
    QRLabel83: TQRLabel;
    QRLabel84: TQRLabel;
    QRBand28: TQRBand;
    QRDBText37: TQRDBText;
    QRDBText38: TQRDBText;
    QRExpr30: TQRExpr;
    QRBand29: TQRBand;
    QRExpr31: TQRExpr;
    QRExpr32: TQRExpr;
    QRBand30: TQRBand;
    QRLabel85: TQRLabel;
    QRSysData6: TQRSysData;
    VatRegDet: TQuickRep;
    QRBand31: TQRBand;
    QRLabel86: TQRLabel;
    QRLabel87: TQRLabel;
    qrlVatDetRange: TQRLabel;
    QRBand32: TQRBand;
    QRLabel89: TQRLabel;
    QRLabel90: TQRLabel;
    QRLabel91: TQRLabel;
    QRLabel92: TQRLabel;
    QRBand33: TQRBand;
    QRExpr33: TQRExpr;
    QRBand34: TQRBand;
    QRExpr34: TQRExpr;
    QRExpr35: TQRExpr;
    QRBand35: TQRBand;
    QRLabel93: TQRLabel;
    QRSysData7: TQRSysData;
    QRLabel94: TQRLabel;
    QRLabel80: TQRLabel;
    QRDBText44: TQRDBText;
    QRExpr36: TQRExpr;
    QRExpr37: TQRExpr;
    qryJE: TQuery;
    qryJECVNO: TStringField;
    qryJEACCTCODE: TStringField;
    qryJEAMOUNT: TFloatField;
    qryJEDEPTCODE: TStringField;
    qryJEcheckDate: TDateField;
    qryJEsupplier: TBooleanField;
    qryJEpayeename: TStringField;
    qryJEsuppcode: TStringField;
    qryJEsuppname: TStringField;
    qryJEdebitamt: TFloatField;
    qryJEcreditamt: TFloatField;
    qryJEdatepaid: TDateField;
    QRExpr38: TQRExpr;
    QRExpr39: TQRExpr;
    QRExpr40: TQRExpr;
    QRExpr41: TQRExpr;
    QRExpr42: TQRExpr;
    QRExpr43: TQRExpr;
    qryJEremark: TStringField;
    qRepPurchTax: TQuickRep;
    QRBand36: TQRBand;
    QRLabel88: TQRLabel;
    QRLabel95: TQRLabel;
    qrlTaxRange: TQRLabel;
    QRBand37: TQRBand;
    QRLabel97: TQRLabel;
    QRLabel98: TQRLabel;
    QRLabel99: TQRLabel;
    QRBand38: TQRBand;
    QRBand39: TQRBand;
    QRExpr47: TQRExpr;
    QRExpr48: TQRExpr;
    QRBand40: TQRBand;
    QRLabel100: TQRLabel;
    QRSysData8: TQRSysData;
    QRLabel96: TQRLabel;
    QRLabel101: TQRLabel;
    QRLabel102: TQRLabel;
    QRLabel103: TQRLabel;
    qryPurchTax: TQuery;
    QRExpr51: TQRExpr;
    qryPurchTaxsaleinv: TStringField;
    qryPurchTaxSIDate: TDateField;
    qryPurchTaxsuppcode: TStringField;
    qryPurchTaxsuppname: TStringField;
    qryPurchTaxcvno: TStringField;
    qryPurchTaxacctcode: TStringField;
    qryPurchTaxamount: TFloatField;
    QRExpr44: TQRExpr;
    QRExpr45: TQRExpr;
    QRExpr49: TQRExpr;
    QRExpr50: TQRExpr;
    QRExpr52: TQRExpr;
    QRExpr46: TQRExpr;
    BalanceReg: TQuickRep;
    QRBand46: TQRBand;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    qrlBalDate: TQRLabel;
    QRBand47: TQRBand;
    QRLabel52: TQRLabel;
    QRLabel114: TQRLabel;
    QRLabel115: TQRLabel;
    QRLabel116: TQRLabel;
    QRLabel117: TQRLabel;
    QRLabel118: TQRLabel;
    QRBand48: TQRBand;
    QRDBText29: TQRDBText;
    QRDBText31: TQRDBText;
    QRDBText32: TQRDBText;
    QRDBText46: TQRDBText;
    QRDBText47: TQRDBText;
    QRBand49: TQRBand;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr57: TQRExpr;
    QRExpr58: TQRExpr;
    QRBand50: TQRBand;
    QRLabel119: TQRLabel;
    QRSysData10: TQRSysData;
    QRLabel120: TQRLabel;
    qrySalesInvTranType: TFloatField;
    qrySalesInvremark: TStringField;
    QRDBText28: TQRDBText;
    QRExpr59: TQRExpr;
    QRExpr60: TQRExpr;
    QRExpr61: TQRExpr;
    APDet: TQuickRep;
    QRBand41: TQRBand;
    QRGroup1: TQRGroup;
    QRExpr53: TQRExpr;
    QRGroup2: TQRGroup;
    QRExpr54: TQRExpr;
    QRBand42: TQRBand;
    QRLabel51: TQRLabel;
    QRLabel104: TQRLabel;
    QRBand43: TQRBand;
    QRExpr56: TQRExpr;
    VendorTotal: TQRBand;
    QRExpr62: TQRExpr;
    QRExpr63: TQRExpr;
    MonthTotal: TQRBand;
    QRExpr64: TQRExpr;
    QRExpr65: TQRExpr;
    QRBand44: TQRBand;
    QRExpr66: TQRExpr;
    QRLabel105: TQRLabel;
    QRLabel106: TQRLabel;
    QRLabel107: TQRLabel;
    qrlAPDateDet: TQRLabel;
    QRExpr67: TQRExpr;
    QRExpr68: TQRExpr;
    QRLabel108: TQRLabel;
    QRShape13: TQRShape;
    qryJEPercent: TFloatField;
    qryJESourceCode: TStringField;
    qryJEcheckno: TStringField;
    tPurchhd: TTable;
    qryJEsaleinv: TStringField;
    qryJEsidate: TDateField;
    qryJEacctname: TStringField;
    QRExpr69: TQRExpr;
    QRLabel109: TQRLabel;
    qryJEpusucode: TStringField;
    qryJEpusuname: TStringField;
    PageFooterBand3: TQRBand;
    QRLabel110: TQRLabel;
    QRSysData9: TQRSysData;
    QRLabel111: TQRLabel;
    QRMemo2: TQRMemo;
    QRExpr55: TQRExpr;
    QRLabel112: TQRLabel;
    qryPurchTaxGrossAmt: TFloatField;
    qryPurchTaxtin: TStringField;
    QRLabel113: TQRLabel;
    QRExpr70: TQRExpr;
    QRExpr71: TQRExpr;
    QRExpr72: TQRExpr;
    QRExpr73: TQRExpr;
    QRExpr74: TQRExpr;
    QRExpr75: TQRExpr;
    qryPurchTaxInputTaxAmt: TFloatField;
    qryPurchTaxvatamt: TFloatField;
    qryPurchTaxnovatamt: TFloatField;
    qryPurchTaxzeratedamt: TFloatField;
    QRExpr76: TQRExpr;
    qryAcctDetrecno: TFloatField;
    qrlBankName: TQRLabel;
    QRLabel121: TQRLabel;
    QRExpr77: TQRExpr;
    QRExpr78: TQRExpr;
    QRExpr79: TQRExpr;
    QRExpr80: TQRExpr;
    CancelChk: TQuickRep;
    QRBand45: TQRBand;
    QRLabel122: TQRLabel;
    QRLabel123: TQRLabel;
    QRLabel124: TQRLabel;
    QRLabel125: TQRLabel;
    QRBand51: TQRBand;
    QRLabel126: TQRLabel;
    QRLabel127: TQRLabel;
    QRLabel128: TQRLabel;
    QRLabel129: TQRLabel;
    QRLabel130: TQRLabel;
    QRBand52: TQRBand;
    QRExpr81: TQRExpr;
    QRBand53: TQRBand;
    QRExpr82: TQRExpr;
    QRExpr83: TQRExpr;
    QRBand54: TQRBand;
    QRLabel131: TQRLabel;
    QRSysData11: TQRSysData;
    QRExpr84: TQRExpr;
    QRExpr85: TQRExpr;
    QRExpr86: TQRExpr;
    QRExpr87: TQRExpr;
    QRExpr88: TQRExpr;
    qryCheckCancel: TBooleanField;
    qryJERecno: TFloatField;
    qryJEapno: TStringField;
    qryJEsiRemark: TStringField;
    QRExpr89: TQRExpr;
    tPaymenthdApproved: TBooleanField;
    qryCheckApproved: TBooleanField;
    tCompany: TTable;
    procedure ChkCalcField(DataSet: TDataSet);
    procedure PostCheck(Sender: TObject);
    procedure updstat(Sender: TQuickRep; var PrintReport: Boolean);
    procedure compamt(DataSet: TDataSet);
    procedure Calcamt(DataSet: TDataSet);
    procedure PurchTaxCalc(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cvReport: TcvReport;

implementation

uses cvfunc, mainmenu;

{$R *.DFM}


procedure TcvReport.ChkCalcField(DataSet: TDataSet);
var sChkAmt,sCent, chkMonth : string;
    Y,M,D   : word;
    cd,cm   : string;
begin
    Str(cvreport.qrycheck.fieldbyname('amount').asfloat:12:2,sChkAmt);
    sCent := copy(sChkAmt,length(sChkAmt)-1,2);
    if sCent <> '00' then
       sCent := ' AND ' + sCent + '/100 ONLY'
    else
       sCent := ' ONLY';
    cvreport.qrycheck.FieldByName('checkword').asstring := ConvAmt(sChkamt)+scent;

    decodedate(cvreport.qrycheck.fieldbyname('CheckDate').asdatetime,y,m,d);
    case m of
         1: ChkMonth := 'Jan.';
         2: ChkMonth := 'Feb.';
         3: ChkMonth := 'Mar.';
         4: ChkMonth := 'Apr.';
         5: ChkMonth := 'May.';
         6: ChkMonth := 'Jun.';
         7: ChkMonth := 'Jul.';
         8: ChkMonth := 'Aug.';
         9: ChkMonth := 'Sep.';
        10: ChkMonth := 'Oct.';
        11: ChkMonth := 'Nov.';
        12: ChkMonth := 'Dec.';
    end;
    {
    cvReport.qr
    ycheck.fieldbyname('checkprinted').asstring := Chkmonth+' '+IntToStr(D)+', '+IntToStr(Y);
    }
    if d < 10 then
       cd := '0' + inttostr(d)
    else
       cd := inttostr(d);
    if m < 10 then
       cm := '0' + inttostr(m)
    else
       cm := inttostr(m);
    cvReport.qrycheck.fieldbyname('checkprinted').asstring := cM + Padchar('R','',' ',tcompany.fieldbyname('spaceMD').asinteger)  + cD + Padchar('R','',' ',tcompany.fieldbyname('spaceDY').asinteger)  + IntToStr(Y);

    cvReport.qryCheck.fieldbyname('chkMonth').asinteger := M;
    cvReport.qryCheck.fieldbyname('chkYear').asinteger  := Y;
end;

procedure TcvReport.PostCheck(Sender: TObject);
Var SearchOptions : tLocateOptions;
begin
    qryCheck.first;
    while not qryCheck.eof do
    begin
           tpaymenthd.First;
           if tpaymenthd.locate('checkno',qrycheck.fieldbyname('checkno').asstring,SearchOptions) then
           begin
                 tpaymenthd.edit;
                 tpaymenthd.fieldbyname('status').asboolean := true;
                 tpaymenthd.post;
           end;
           qrycheck.next;
    end;
end;

procedure TcvReport.updstat(Sender: TQuickRep; var PrintReport: Boolean);
Var SearchOptions : tLocateOptions;
begin
    qryCheck.first;
    while not qryCheck.eof do
    begin
           tpaymenthd.First;
           if tpaymenthd.locate('checkno',qrycheck.fieldbyname('checkno').asstring,SearchOptions) then
           begin
                 tpaymenthd.edit;
                 tpaymenthd.fieldbyname('status').asboolean := true;
                 tpaymenthd.post;
           end;
           qrycheck.next;
    end;
end;

procedure TcvReport.compamt(DataSet: TDataSet);
begin
    qryAcctDet.fieldbyname('debitamt').asfloat := 0;
    qryAcctDet.fieldbyname('creditamt').asfloat := 0;
    if qryAcctDet.fieldbyname('a').asfloat > 0 then
         qryAcctDet.fieldbyname('debitamt').asfloat := qryAcctDet.Fieldbyname('a').asfloat
    else
         qryAcctDet.fieldbyname('creditamt').asfloat := (qryAcctdet.fieldbyname('a').asfloat)*-1;
end;


procedure TcvReport.Calcamt(DataSet: TDataSet);
begin
    if (qryJE.FieldByName('amount').asfloat > 0) then
         qryJE.fieldbyname('debitamt').asfloat := qryJE.fieldbyname('amount').asfloat
    else
         qryJE.fieldbyname('creditamt').asfloat := qryJE.fieldbyname('amount').asfloat * -1;
end;


procedure TcvReport.PurchTaxCalc(DataSet: TDataSet);
begin
    if qryPurchTax.Fieldbyname('acctcode').asstring = '110302' then
         qryPurchTax.Fieldbyname('VatAmt').asfloat := qryPurchTax.fieldbyname('amount').asfloat
    else
         if qryPurchTax.Fieldbyname('acctcode').asstring = '110303' then
              qryPurchTax.fieldbyname('NoVatAmt').asfloat := qryPurchtax.Fieldbyname('amount').asfloat
         else
              if qryPurchTax.Fieldbyname('acctcode').asstring = '110304' then
                   qryPurchTax.Fieldbyname('ZeRatedAmt').asfloat := qryPurchTax.Fieldbyname('amount').asfloat
              else
                   if qryPurchTax.fieldbyname('acctcode').asstring = '110301' then
                        qryPurchTax.Fieldbyname('InputTaxAmt').asfloat := qryPurchtax.Fieldbyname('amount').asfloat;

end;


end.
