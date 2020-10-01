unit mainmenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Db, DBTables, Printers, WinTypes, WinProcs, StdCtrls, Clipbrd, QuickRpt, ComObj,
  Grids, DBGrids, ExtCtrls, jpeg;

type
  TMainForm = class(TForm)
    AcctMenu: TMainMenu;
    File1: TMenuItem;
    Transaction1: TMenuItem;
    Report1: TMenuItem;
    system1: TMenuItem;
    Cleanup1: TMenuItem;
    Supplier1: TMenuItem;
    Invoicing1: TMenuItem;
    Payment1: TMenuItem;
    Reference1: TMenuItem;
    Exit1: TMenuItem;
    DataSource1: TDataSource;
    tReusable1: TTable;
    tCompany: TTable;
    Check1: TMenuItem;
    JournalEntry1: TMenuItem;
    Vat1: TMenuItem;
    Users1: TMenuItem;
    Company1: TMenuItem;
    BalancePerCompanyPayee1: TMenuItem;
    SummaryTaxWheld1: TMenuItem;
    VoucherRegister1: TMenuItem;
    CheckPrinting1: TMenuItem;
    CheckRegister1: TMenuItem;
    MonthlyReport1: TMenuItem;
    Export1: TMenuItem;
    PrintDialog1: TPrintDialog;
    AccountsPayable1: TMenuItem;
    PurchaseRegister1: TMenuItem;
    qryReusable1: TQuery;
    Detail1: TMenuItem;
    Summary1: TMenuItem;
    Detail2: TMenuItem;
    Summary2: TMenuItem;
    TaxRegister1: TMenuItem;
    Detail3: TMenuItem;
    Summary3: TMenuItem;
    Register1: TMenuItem;
    AP1: TMenuItem;
    CV1: TMenuItem;
    AP2: TMenuItem;
    CV2: TMenuItem;
    CancelCheck1: TMenuItem;
    CancelChecks1: TMenuItem;
    VoucherRegister2: TMenuItem;
    CancelledVoucher1: TMenuItem;
    Label1: TLabel;
    ExportXcel1: TMenuItem;
    AP3: TMenuItem;
    CV3: TMenuItem;
    SupplierMasterList1: TMenuItem;
    Print1: TMenuItem;
    ExporttoExcel1: TMenuItem;
    dsreusable1: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    Image2: TImage;
    procedure ReferencesClick(Sender: TObject);
    procedure Supplier1Click(Sender: TObject);
    procedure Invoicing1Click(Sender: TObject);
    procedure Payment1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Users1Click(Sender: TObject);
    procedure Company1Click(Sender: TObject);
    procedure CheckPrinting1Click(Sender: TObject);
    procedure CheckRegister1Click(Sender: TObject);
    procedure VoucherRegister1Click(Sender: TObject);
    procedure VatSummary1Click(Sender: TObject);
    procedure EWTSummary1Click(Sender: TObject);
    procedure MonthlyReport1Click(Sender: TObject);
    procedure Export1Click(Sender: TObject);
    procedure Check2Click(Sender: TObject);
    procedure AccountsPayable1Click(Sender: TObject);
    procedure PurchaseRegister1Click(Sender: TObject);
    procedure VatDetail1Click(Sender: TObject);
    procedure EWTDetail1Click(Sender: TObject);
    procedure TaxRegister1Click(Sender: TObject);
    procedure Summary3Click(Sender: TObject);
    procedure Detail3Click(Sender: TObject);
    procedure CancelChk(Sender: TObject);
    procedure CancelChecks1Click(Sender: TObject);
    procedure cancelvoucher(Sender: TObject);
    procedure PreviewClick(Sender : TObject);
    procedure AP3Click(Sender: TObject);
    procedure CV3Click(Sender: TObject);
    procedure ExporttoExcel1Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
  private
    FReport : TQuickRep;
    Procedure SetReport(value:TQuickRep);
    { Private declarations }

  public
    { Public declarations }
    Property Report: TQuickRep read FReport write SetReport;
  end;

var
  MainForm: TMainForm;

implementation

uses BrmFIle, BrowSupplier, BrowSI, BrowPayment, tselect, Dlgrpar1, RepCV,
  Brow, CompForm, Dlgrpar5, checkform, browcheck, UpdAccount, Test;

const
    {XLSheetType}
    xlChart = -4109;
    xlDialogSheet = -4116;
    xlExcel4IntlMacroSheet = 4;
    xlExcel4MarcoSheet=3;
    xlWorksheet=-4167;

    {XLWBATemplate}
    xlWBATChart = -4109;
    xlWBATExcel4IntlMacroSheet = 4;
    xlWBATExcel4MacroSheet=3;
    xlWBATWorksheet = -4167;

var XLApplication : Variant;



{$R *.DFM}

procedure TMainForm.ReferencesClick(Sender: TObject);
begin
     BrowFormmFiles.tAccount.Active := true;
     BrowFormMFiles.PageControl.ActivePage := BrowFormMFiles.tsAccount;
     BrowFormMFiles.dsReference.DataSet := BrowFormMFiles.tAccount;
     BrowFormMFiles.tAccount.Refresh;
     BrowFormMFiles.Show;
     BrowFormMFiles.dbAccount.SetFocus;
end;

procedure TMainForm.Supplier1Click(Sender: TObject);
begin
     BrowSupp.Showmodal;
end;

procedure TMainForm.Invoicing1Click(Sender: TObject);
begin
     BrowInvoice.Showmodal;
end;

procedure TMainForm.Payment1Click(Sender: TObject);
begin
     BrowVoucher.Showmodal;
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
     close;
end;

procedure TMainForm.Users1Click(Sender: TObject);
begin
    BrowseForm.DataSource.DataSet := BrowseForm.tUser;
    BrowseForm.tUser.open;
    BrowseForm.tUser.First;
    BrowseForm.Caption := 'Users';
    BrowseForm.DBGrid.ReadOnly := True;
    BrowseForm.ShowModal;
    BrowseForm.tUser.close;
    BrowseForm.DBGrid.ReadOnly := False;
end;

procedure TMainForm.Company1Click(Sender: TObject);
begin
     CompInfo := tCompInfo.create(Application);
     CompInfo.Showmodal;
     CompInfo.free;
end;

procedure TMainForm.CheckPrinting1Click(Sender: TObject);
var PrnChk : system.text;
     cAmt, cWrdAmt, cWord1, cWord2 : string;
     nAmt : real;
     SearchOptions : tLocateOptions;
     nEnd : integer;
     nAdj : integer;

begin
     dlgReportParameter1.caption  := 'Enter Bank & Date Range:';
     dlgReportParameter1.sCheckNo.text := '0';
     dlgReportParameter1.eCheckNo.text := '0';
     dlgReportParameter1.ShowModal;
     if dlgReportParameter1.modalresult = mrok then
     begin
         if PrintDialog1.execute then
         begin

              cvReport.tPaymenthd.active := true;
              cvreport.tcompany.active:=true;
              printer.orientation := poPortrait;
              Assignprn(PrnChk);
              Rewrite(PrnChk);
              try
              begin
                   {cvReport.tCompany.Open;}
                   nAdj := 0;
                   cvReport.qryCheck.close;
                   cvReport.qryCheck.parambyname('sCheckNo').asstring := dlgReportParameter1.sCheckNo.text;
                   cvReport.qryCheck.parambyname('eCheckno').asstring := dlgReportParameter1.eCheckNo.text;
                   cvReport.qryCheck.parambyname('cBankName').asstring:= dlgReportParameter1.cBoxBank.text;
                   cvReport.qryCheck.Open;
                   cvReport.qryCheck.first;
                   while not cvReport.qrycheck.eof do
                   begin
                        if (cvReport.qryCheck.fieldbyname('status').asBoolean = false) and
                           (cvReport.qryCheck.fieldbyname('cancel').asboolean = false) and
                           (cvReport.qryCheck.fieldbyname('Approved').asboolean = true) then
                             begin
                                  cAmt    := '';
                                  cWrdAmt := '';
                                  cWord1  := '';
                                  cWord2  := '';
                                  nEnd    := 82;
                                  nAmt := cvReport.qryCheck.fieldbyname('amount').asfloat;
                                  {str(nAmt:10:2,cAmt);}
                                  cAmt := Format('%n',[nAmt]);
                                  cAmt := '** ' + cAmt + ' **';
                                  cWrdAmt := '**' + cvReport.qryCheck.fieldbyname('checkword').asstring + '**';
                                  while (copy(cwrdamt,nEnd,1) <> ' ') and (length(cwrdamt)> 81) do
                                  begin
                                       nEnd := nEnd - 1;
                                  end;
                                  cWord1 := copy(cWrdAmt,1,nEnd-1);
                                  cWord2 := copy(cWrdAMt,nEnd,Length(cWrdAmt));

                                  printer.canvas.font.size := 6;

                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('CVNoCol').asinteger,cvReport.tCompany.fieldbyname('CVNoRow').asinteger,cvReport.qryCheck.fieldbyname('cvno').asstring);
                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('CheckNoCol').asinteger,cvReport.tCompany.fieldbyname('CheckNoRow').asinteger,cvReport.qryCheck.fieldbyname('checkno').asstring);
                                  printer.canvas.font.size := 10;
                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('CheckDateCol').asinteger,cvReport.tCompany.fieldbyname('CheckDateRow').asinteger,cvReport.qryCheck.fieldbyname('checkprinted').asstring);
                                  if (cvReport.qrycheck.fieldbyname('supplier').asboolean = true) then
                                       printer.canvas.textout(cvReport.tCompany.fieldbyname('SupplierCol').asinteger,cvReport.tCompany.fieldbyname('SupplierRow').asinteger,'**'+cvReport.qryCheck.fieldbyname('suppname').asstring+'**')
                                  else
                                       printer.canvas.textout(cvReport.tCompany.fieldbyname('SupplierCol').asinteger,cvReport.tCompany.fieldbyname('SupplierRow').asinteger,'**'+cvReport.qryCheck.fieldbyname('payeename').asstring+'**');
                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('CheckAmtCol').asinteger,cvReport.tCompany.fieldbyname('CheckAmtRow').asinteger,camt );
                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('CheckWord1Col').asinteger,cvReport.tCompany.fieldbyname('CheckWord1Row').asinteger,cWord1);
                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('CheckWord2Col').asinteger,cvReport.tCompany.fieldbyname('CheckWord2Row').asinteger,cWord2);
                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('SignatoryCol').asinteger,cvReport.tCompany.fieldbyname('SignatoryRow').asinteger,cvReport.tCompany.fieldbyname('ChkSignatory').asstring);
                                  printer.newpage;

                                  nAdj := 25;
                                  cvReport.tPaymenthd.first;
                                  if cvReport.tPaymenthd.locate('checkno',cvReport.qrycheck.fieldbyname('checkno').asstring,SearchOptions) then
                                  begin
                                       cvReport.tPaymenthd.edit;
                                       cvReport.tPaymenthd.fieldbyname('status').asboolean := true;
                                       cvReport.tPaymenthd.post;
                                  end;
                             end
                        else
                             if cvReport.qrycheck.fieldbyname('status').asboolean = true then
                                  showmessage('Check No. : ' + cvReport.qryCheck.fieldbyname('checkno').asstring + ' already printed...')
                             else
                                  if cvReport.qrycheck.fieldbyname('cancel').asboolean = true then
                                       showmessage('CV No. : ' + cvReport.qrycheck.fieldbyname('cvno').asstring + ' already cancelled...')
                                  else
                                        if cvReport.qryCheck.fieldbyname('Approved').asboolean = false then
                                                showmessage('Check No. : ' + cvReport.qryCheck.fieldbyname('checkno').asstring + ' Check not yet approved for printing...');
                        cvReport.qryCheck.Next;
                   end;
                   cvReport.qryCheck.close;
              end;
              finally
              begin
                   closefile(prnchk);
                   cvReport.tpaymenthd.close;
                   showmessage('Printing completed...');
              end;
              cvReport.tPaymenthd.active := false;
              cvreport.tcompany.close;
         end;
     end;
end;
end;

procedure TMainForm.CheckRegister1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
begin
    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.cBoxBank.enabled := true;

    dlgReportParameter5.cboxBank.items.clear;

    tReusable1.close;
    tReusable1.databaseName := 'AccountData';
    tReusable1.tableName := 'Bank.db';
    tReusable1.open;
    tReusable1.first;
    while not tReusable1.eof do
    begin
         dlgReportParameter5.cboxBank.items.add( tReusable1.fieldByName('BankName').asString );
         tReusable1.next;
    end;
    tReusable1.close;
    tReusable1.databaseName := '';
    tReusable1.tableName := '';
    tReusable1.indexName := '';

    dlgReportParameter5.cboxBank.itemIndex := 0;

    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);
         cvReport.tCompany.Open;
         cvReport.qryCheck.close;
         cvReport.qryCheck.sql.clear;
         cvReport.qryCheck.sql.add('Select * from "paymenthd.db" paymenthd, "bank.db" bank ');
         cvReport.qryCheck.sql.add(' where (paymenthd."bankcode"=bank."bankcode") and ' +
                                   ' (paymenthd."status" = true ) and ' +
                                   ' (paymenthd."cancel" = false) and ' +
                                   ' (bank."bankname" = ''' + dlgreportparameter5.cBoxBank.text + ''') and ' +
                                   ' (paymenthd.checkdate >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                                   ' (paymenthd.checkdate <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')' +
                                   ' order by paymenthd."checkno" ');
         cvReport.qrlBankname.caption := ' - ' + dlgreportparameter5.cBoxBank.text;
         cvReport.qryCheck.Open;
         cvReport.qrlChkRange.caption := DatetoStr(dlgReportParameter5.sDate.Date) +  ' -  ' + DatetoStr(dlgReportParameter5.eDate.Date);
         Report := cvReport.CheckReg;
         PreviewClick(Report);

         cvReport.tCompany.close;
         cvReport.qryCheck.close;
    end;
    dlgReportParameter5.cBoxBank.enabled := false;
end;

procedure TMainForm.VoucherRegister1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
begin
    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin
         cvReport.tcompany.open;
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);
         cvReport.qryCheck.close;
         cvReport.qryCheck.sql.clear;
         cvReport.qryCheck.sql.add('Select * from "paymenthd.db" paymenthd, "bank.db" bank ');
         cvReport.qryCheck.sql.add(' where (paymenthd."bankcode"=bank."bankcode") and ' +
                                   ' (paymenthd."cancel" = false ) and ' +
                                   ' (paymenthd.DatePaid >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                                   ' (paymenthd.DatePaid <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')' +
                                   ' order by paymenthd."cvno" ');

         cvReport.qryCheck.Open;
         cvReport.qrlabel36.caption := 'Voucher Register';
         cvReport.qrlVoucherRange.caption := DatetoStr(dlgReportParameter5.sDate.Date) +  ' -  ' + DatetoStr(dlgReportParameter5.eDate.Date);
         Report := cvReport.VoucherReg;
         PreviewClick(Report);
         cvReport.qryCheck.close;
         cvReport.tcompany.close;
    end;
end;

procedure TMainForm.VatSummary1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
begin
    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin

         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);

         {Transfer Payments to temporary file }
         qryReusable1.sql.clear;
         qryReusable1.sql.add('select paymenthd."supplier", paymenthd."payeename", supplier."suppname", ' +
              ' supplier."tin" as SuppTin, paymenthd."tin" as PayeeTin, sum(acctdet."amount") as amount ');
         qryReusable1.sql.add('From "supplier.db" Supplier, "paymenthd.db" paymenthd, "acctdet.db" acctdet ');
         qryReusable1.sql.add('where (Supplier."suppcode"=paymenthd."suppcode") and ' +
                       '(paymenthd."cvno"=acctdet."cvno") and ' +
                       '(paymenthd."suppcode"=supplier."suppcode") and ' +
                       '(paymenthd.DatePaid >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                       '(paymenthd.DatePaid <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''') and ' +
                       '(AcctDet."acctcode"='''+'110301'+''')');
         qryReusable1.sql.add('Group by paymenthd."supplier", paymenthd."payeename", supplier."suppname", SuppTin, PayeeTin');
         qryReusable1.sql.add('Order by paymenthd."supplier", paymenthd."payeename", supplier."suppname"');

         tReusable1.close;
         treusable1.databasename := 'AccountData';
         treusable1.Tablename := 'taxreg.db';
         tReusable1.emptytable;
         treusable1.open;

         qryReusable1.Open;
         qryReusable1.first;
         while not qryreusable1.eof do
         begin
              tReusable1.append;
              if (qryreusable1.FieldByName('supplier').asboolean = true) then
              begin
                   treusable1.fieldbyname('tin').asstring      := qryreusable1.fieldbyname('supptin').asstring;
                   treusable1.fieldbyname('compname').asstring := qryreusable1.fieldbyname('suppname').asstring;
              end
              else
              begin
                   treusable1.fieldbyname('tin').asstring      := qryreusable1.fieldbyname('payeetin').asstring;
                   treusable1.fieldbyname('compname').asstring := qryreusable1.fieldbyname('payeename').asstring;
              end;
              treusable1.fieldbyname('amount').asfloat := (qryreusable1.fieldbyname('amount').asfloat);
              treusable1.post;
              qryreusable1.next;
         end;

         {Transfer Invoices to temporary file}
         qryReusable1.sql.clear;
         qryReusable1.sql.add('Select supplier."tin", supplier."suppname", sum(acctdet."amount") as amount ');
         qryReusable1.sql.add('From "supplier.db" Supplier, "purchhd.db" purchhd, "acctdet.db" acctdet ');
         qryReusable1.sql.add('where (Supplier."suppcode"=purchhd."suppcode") and ' +
                       '(purchhd."saleinv"=acctdet."cvno") and ' +
                       '(purchhd."suppcode"=supplier."suppcode") and ' +
                       '(purchhd.siDate >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                       '(purchhd.siDate <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''') and ' +
                       '(AcctDet."acctcode"='''+'110301'+''')');
         qryReusable1.sql.add('Group by supplier."suppname", supplier."tin"');
         qryReusable1.sql.add('Order by supplier."suppname"');

         qryReusable1.Open;
         qryReusable1.first;
         while not qryreusable1.eof do
         begin
              tReusable1.append;
              treusable1.fieldbyname('tin').asstring      := qryreusable1.fieldbyname('tin').asstring;
              treusable1.fieldbyname('compname').asstring := qryreusable1.fieldbyname('suppname').asstring;
              treusable1.fieldbyname('amount').asfloat := (qryreusable1.fieldbyname('amount').asfloat);
              treusable1.post;
              qryreusable1.next;
         end;
         treusable1.close;
         treusable1.databasename := '';
         treusable1.tablename := '';


         qryReusable1.close;
         qryReusable1.sql.clear;
         qryReusable1.sql.add('Select taxreg."Tin", taxreg."compname", taxreg."amount"');
         qryReusable1.sql.add('from "taxreg.db" Taxreg');
         qryReusable1.sql.add('Order by taxreg."compname"');
         qryReusable1.Open;

         cvReport.qrlVatRange.caption := DatetoStr(dlgReportParameter5.sDate.Date) +  ' -  ' + DatetoStr(dlgReportParameter5.eDate.Date);
         Report := cvReport.VatRegSum;
         PreviewClick(Report);
         qryReusable1.close;
    end;


         {
         cvReport.qryAcctDet.close;
         cvReport.qryAcctDet.sql.clear;

         cvReport.qryAcctDet.sql.add('Select acctdet."cvno", acctdet."acctcode", acctdet."deptcode", acctdet."amount" as A, Acctdet."amount"*-1 as B, ' +
                                     'paymenthd."amount" as amtpaid, paymenthd."datepaid", paymenthd."checkno", paymenthd."bankcode", paymenthd."suppcode", paymenthd."remark", ' +
                                     'bank."bankname", supplier."suppname", account."accountname" as acctname, paymenthd.payeename, paymenthd."supplier", paymenthd."DatePaid" ');
         cvReport.qryAcctDet.sql.add('from "AcctDet.db" AcctDet, "paymenthd.db" paymenthd, "bank.db" bank, "Supplier.db" supplier, "account.db" account ');
         cvReport.qryAcctDet.sql.add('where acctdet."acctcode"='''+'110301' + ''' and ' +
                                     'acctdet."cvno"=paymenthd."cvno" and ' +
                                     'paymenthd."bankcode"=bank."bankcode" and paymenthd."suppcode"=supplier."suppcode" and acctdet."acctcode"=account."accountcode" and ' +
                                     '(paymenthd.DatePaid >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                                     '(paymenthd.DatePaid <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')');

         cvReport.qryAcctDet.Open;
         cvReport.qrlVatRange.caption := DatetoStr(dlgReportParameter5.sDate.Date) +  ' -  ' + DatetoStr(dlgReportParameter5.eDate.Date);
         cvReport.VatReg.preview;
         cvReport.qryAcctDet.close;}
end;

procedure TMainForm.EWTSummary1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
begin

    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);

         {Transfer to temporary file }
         qryReusable1.sql.clear;
         qryReusable1.sql.add('select paymenthd."supplier", paymenthd."payeename", supplier."suppname", ' +
              ' supplier."tin" as SuppTin, paymenthd."tin" as PayeeTin, sum(acctdet."amount") as amount ');
         qryReusable1.sql.add('From "supplier.db" Supplier, "paymenthd.db" paymenthd, "acctdet.db" acctdet ');
         qryReusable1.sql.add('where (Supplier."suppcode"=paymenthd."suppcode") and ' +
                       '(paymenthd."cvno"=acctdet."cvno") and ' +
                       '(paymenthd."suppcode"=supplier."suppcode") and ' +
                       '(acctdet."amount" < 0 ) and ' +
                       '(paymenthd.DatePaid >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                       '(paymenthd.DatePaid <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''') and ' +
                       '(AcctDet."acctcode"='''+'200181'+''')');
         qryReusable1.sql.add('Group by paymenthd."supplier", paymenthd."payeename", supplier."suppname", SuppTin, PayeeTin');
         qryReusable1.sql.add('Order by paymenthd."supplier", paymenthd."payeename", supplier."suppname"');

         tReusable1.close;
         treusable1.databasename := 'AccountData';
         treusable1.Tablename := 'taxreg.db';
         tReusable1.emptytable;
         treusable1.open;

         qryReusable1.Open;
         qryReusable1.first;
         while not qryreusable1.eof do
         begin
              tReusable1.append;
              if (qryreusable1.FieldByName('supplier').asboolean = true) then
              begin
                   treusable1.fieldbyname('tin').asstring      := qryreusable1.fieldbyname('supptin').asstring;
                   treusable1.fieldbyname('compname').asstring := qryreusable1.fieldbyname('suppname').asstring;
              end
              else
              begin
                   treusable1.fieldbyname('tin').asstring      := qryreusable1.fieldbyname('payeetin').asstring;
                   treusable1.fieldbyname('compname').asstring := qryreusable1.fieldbyname('payeename').asstring;
              end;
              treusable1.fieldbyname('amount').asfloat := (qryreusable1.fieldbyname('amount').asfloat)*-1;
              treusable1.post;
              qryreusable1.next;
         end;
         treusable1.close;
         treusable1.databasename := '';
         treusable1.tablename := '';

         qryReusable1.close;
         qryReusable1.sql.clear;
         qryReusable1.sql.add('Select taxreg."Tin", taxreg."compname", taxreg."amount"');
         qryReusable1.sql.add('from "taxreg.db" Taxreg');
         qryReusable1.sql.add('Order by taxreg."compname"');
         qryReusable1.Open;

         cvReport.qryAcctDet.Open;
         cvReport.qrlEWTRange.caption := DatetoStr(dlgReportParameter5.sDate.Date) +  ' -  ' + DatetoStr(dlgReportParameter5.eDate.Date);
         Report := cvReport.EWTRegSum;
         PreviewClick(Report);
         cvReport.qryAcctDet.close;
    end;
    

end;

procedure TMainForm.MonthlyReport1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
    cType                 : string;
begin
    if sender = mainform.AP1 then
         cType := 'AP'
    else
         cType := 'CV';
    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);
         cvReport.qryJE.close;

         if cType = 'AP' then
              begin
                   cvReport.qryJe.sql.clear;
                   cvReport.qryje.sql.add('select * ');
                   cvReport.qryJe.sql.add('From  "acctdet.db" acctdet, "Purchhd.db" Purchhd ');
                   cvReport.qryje.sql.add('where purchhd."saleinv"=acctdet."cvNo" ');
                   cvReport.qryJE.sql.add('order by purchhd."apno", acctdet."recno" ');
              end
         else
              begin
                   cvReport.qryJe.sql.clear;
                   cvReport.qryje.sql.add('select * ');
                   cvReport.qryJe.sql.add('From  "acctdet.db" acctdet, "Paymenthd.db" PaymentHd ');
                   cvReport.qryje.sql.add('where paymenthd."cvno"=acctdet."cvNo" ');
                   cvReport.qryJE.sql.add('order by paymenthd."cvno", acctdet."recno" ');
              end;
         cvReport.qryJE.Open;

         tReusable1.close;
         treusable1.databasename := 'AccountData';
         treusable1.Tablename := 'acctreg.db';
         tReusable1.emptytable;
         treusable1.open;
         cvReport.qryJE.first;
         while not cvReport.qryje.eof do
         begin
         if (cvreport.qryJE.fieldbyname('sourcecode').asstring = cType) then
         begin
              treusable1.append;
              if (ctype = 'CV') then
                   if (cvReport.qryje.fieldbyname('acctcode').asstring = '100309') or
                      (cvReport.qryJe.fieldbyname('acctcode').asstring = '100306') or
                      ((cvreport.qryje.fieldbyname('acctcode').asstring = '200130') and (cvReport.qryje.fieldbyname('DebitAmt').asfloat > 0)) then
                   begin
                        treusable1.fieldbyname('cvno').asstring := 'CK ' + cvreport.qryje.fieldbyname('checkno').asstring;
                        treusable1.fieldbyname('checkdate').asdatetime  := cvreport.qryje.fieldbyname('checkdate').asdatetime;
                        treusable1.fieldbyname('datepaid').asdatetime   := cvreport.qryje.fieldbyname('checkdate').asdatetime;
                   end
                   else
                   begin
                        treusable1.fieldbyname('cvno').asstring := 'CV ' + cvreport.qryje.fieldbyname('cvno').asstring;
                        treusable1.fieldbyname('checkdate').asdatetime  := cvreport.qryje.fieldbyname('datepaid').asdatetime;
                        treusable1.fieldbyname('datepaid').asdatetime   := cvreport.qryje.fieldbyname('datepaid').asdatetime;
                   end
              else
                   treusable1.fieldbyname('cvno').asstring     := 'APV ' + cvreport.qryje.fieldbyname('apno').asstring;

              treusable1.fieldbyname('acctcode').asstring := cvreport.qryje.fieldbyname('acctcode').asstring;
              treusable1.fieldbyname('deptcode').asstring := cvreport.qryje.fieldbyname('deptcode').asstring;
              treusable1.fieldbyname('remark').asstring   := cvreport.qryje.fieldbyname('remark').asstring;
              treusable1.fieldbyname('acctname').asstring := cvreport.qryje.fieldbyname('acctname').asstring;
              if cType = 'CV' then
                   begin
                        if (cvreport.qryje.fieldbyname('supplier').asboolean = true) then
                             treusable1.fieldbyname('name').asstring     := cvreport.qryje.fieldbyname('suppname').asstring
                        else
                              treusable1.fieldbyname('name').asstring     := cvreport.qryje.fieldbyname('payeename').asstring;
                   end
              else
                   begin
                        treusable1.fieldbyname('name').asstring      := cvreport.qryje.fieldbyname('pusuname').asstring;
                        treusable1.fieldbyname('checkdate').asstring := cvreport.qryje.fieldbyname('sidate').asstring;
                        treusable1.fieldbyname('datepaid').asdatetime   := cvreport.qryje.fieldbyname('sidate').asdatetime;
                   end;
              treusable1.fieldbyname('amount').asfloat    := cvreport.qryje.fieldbyname('amount').asfloat;
              treusable1.fieldbyname('debitamt').asfloat  := cvreport.qryje.fieldbyname('debitamt').asfloat;
              treusable1.fieldbyname('creditamt').asfloat := cvreport.qryje.fieldbyname('creditamt').asfloat;
              treusable1.post;
         end;
              cvreport.qryje.next;
         end;
         cvReport.qryJE.Close;
         treusable1.close;

         qryReusable1.close;
         qryReusable1.sql.clear;
         qryReusable1.sql.add('Select * ');
         qryReusable1.sql.add('from "acctreg.db" Acctreg');
         qryReusable1.sql.add('Where (AcctReg.DatePaid >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
         '(AcctReg.DatePaid <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')');
         qryReusable1.Open;
         cvReport.qrlJVRange.caption := DatetoStr(dlgReportParameter5.sDate.Date) +  ' -  ' + DatetoStr(dlgReportParameter5.eDate.Date);
         if cType = 'CV' then
              cvReport.qrlabel61.caption := 'CV Journal Entry'
         else
              cvReport.qrlabel61.caption := 'AP Journal Entry';
         Report := cvReport.JVReg;
         PreviewClick(Report);

         qryReusable1.close;

    end;
end;

procedure TMainForm.Export1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
    tJVEntry             : tStrings;
    cJVEntry,cFileName   : String;
    cM,cD,cY,pY,pM,pD    : String;
    Y,M,D                : word;
    nAmt                 : real;
    cType,cReference,cRemark,cAmt  : String;
    lValid               : Boolean;

begin
    if sender = mainform.AP2 then
         cType := 'AP'
    else
         cType := 'CV';
    DecodeDate(date,Y,M,D);
    if (m < 10) then
         cM := '0' + floattostr(M)
    else
         cM := floattostr(m);
    if (d < 10) then
        cD := '0' + floattostr(D)
    else
    cD := floattostr(D);
    cY := copy(floattostr(Y),3,2);
    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin
         ShowMessage('Please insert diskette in drive [A]...');
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);
         cvReport.qryJE.close;
         if cType = 'AP' then
              begin
                   cvReport.qryJe.sql.clear;
                   cvReport.qryJE.sql.add('select * ');
                   cvReport.qryJe.sql.add('From  "acctdet.db" acctdet, "Purchhd.db" Purchhd ');
                   cvReport.qryje.sql.add('where purchhd."saleinv"=acctdet."cvNo" ');
                   cvReport.qryJE.sql.add('order by purchhd."apno", acctdet."recno"');
              end
         else
              begin
                   cvReport.qryJe.sql.clear;
                   cvReport.qryje.sql.add('select * ');
                   cvReport.qryJe.sql.add('From  "acctdet.db" acctdet, "Paymenthd.db" PaymentHd ');
                   cvReport.qryje.sql.add('where paymenthd."cvno"=acctdet."cvNo" ');
                   cvReport.qryJE.sql.add('order by paymenthd."cvno", acctdet."recno" ');
              end;

         cvReport.qryJE.open;

         tJVEntry := TStringList.Create;
         try
            cvReport.qryJE.first;
            while not cvReport.qryJE.eof do
            begin
            if ((cvReport.qryJe.fieldbyname('sourcecode').asstring  = 'CV')) or
               ((cvReport.qryJE.fieldbyname('sidate').asDateTime >= int(dlgReportparameter5.sDate.Date)) and
               (cvReport.qryJE.fieldbyname('sidate').asDateTime <= int(dlgReportParameter5.eDate.Date)) and
               (cvReport.qryJe.fieldbyname('sourcecode').asstring  = 'AP')) then
            begin
                   lValid := false;
                   nAmt := cvReport.qryJE.fieldbyname('Amount').asfloat;
                   str(nAmt:10:2,cAmt);

                   if cType = 'CV' then
                        begin
                             if (((cvReport.qryJE.fieldbyname('acctcode').asstring='200130') and (cvReport.qryJE.fieldbyname('amount').asfloat > 0)) or
                                ((cvReport.qryJE.fieldbyname('acctcode').asstring='100309') or (cvReport.qryJE.fieldbyname('acctcode').asstring='100306') and (cvReport.qryJE.fieldbyname('amount').asfloat < 0))) then
                                  begin
                                       if (cvReport.qryJE.fieldbyname('CheckDate').asdateTime >= int(DlgReportparameter5.sdate.date)) and
                                          (cvReport.qryJE.fieldbyname('CheckDate').asdateTime <= int(DlgReportParameter5.eDate.date)) then
                                       begin
                                            decodedate(cvReport.qryJE.fieldbyname('Checkdate').asDatetime,Y,M,D);
                                            lValid := true;
                                            cReference := 'CK ' + cvReport.qryJe.fieldbyname('checkno').asstring;
                                            if (cvreport.qryje.fieldbyname('supplier').asboolean = true) then
                                               cRemark    := 'CV' + cvReport.qryJe.fieldbyname('cvno').asstring + '-'+copy(cvReport.qryJE.fieldbyname('SuppName').asstring,1,21)
                                            else
                                               cRemark    := 'CV' + cvReport.qryJe.fieldbyname('cvno').asstring + '-'+copy(cvReport.qryJE.fieldbyname('Payeename').asstring,1,21);
                                       end;
                                  end
                             else
                                  begin
                                       if ((cvReport.qryJE.fieldbyname('DatePaid').asdatetime >= int(DlgReportParameter5.sDate.date)) and
                                           (cvReport.qryJE.fieldbyname('DatePaid').asdatetime <= int(DlgReportparameter5.eDate.date))) then
                                       begin
                                            decodedate(cvReport.qryJE.fieldbyname('DatePaid').asDatetime,Y,M,D);
                                            lValid := true;
                                            creference := 'CV '  + cvReport.qryJE.fieldbyname('cvno').asstring;
                                            cRemark    := copy(cvreport.qryJE.fieldbyname('remark').asstring,1,30);
                                       end;
                                  end;
                        end
                   else
                        begin
                             {creference := 'SI '+cvReport.qryJE.fieldbyname('saleinv').asstring;}
                             decodedate(cvReport.qryJE.fieldbyname('sidate').asDateTime,Y,M,D);
                             lValid := true;
                             cReference := 'APV ' + cvReport.qryJE.fieldbyname('APNo').asstring;
                             cRemark    := copy(cvReport.qryje.fieldbyname('siremark').asstring,1,20) + ' SI' + cvReport.qryJE.fieldbyname('saleinv').asstring;
                        end;

                   if lValid  then
                   begin
                        if (m < 10) then
                             pM := '0' + floattostr(M)
                        else
                             pM := floattostr(m);
                        if (d < 10) then
                             pD := '0' + floattostr(D)
                        else
                             pD := floattostr(D);
                        pY := copy(floattostr(Y),3,2);

                        cJVEntry := '"E",1,"'+cY+cM+cD+'",0,' +
                               '"'+cvReport.qryJE.fieldbyname('AcctCode').asString+'",'+
                               '"'+cvReport.qryJE.fieldbyname('deptcode').asstring+'",'+
                                '"GL'+cType+'","'+creference+'",'+
                                '"'+pY+pM+pD+'","'+cRemark+'",'+
                                camt;

                        tJVEntry.Add(cJVEntry);
                   end;
            end;
            cvReport.qryJE.next;
            end;
            if cType = 'CV' then
               cFileName := 'a:\CV'+cY+cM+cD+'.txt'
            else
               cFileName := 'a:\AP'+cy+cm+cd+'.txt';
            with tJVEntry do
            begin
                   SaveToFile(cFileName);
            end;
         Finally
            tJVEntry.free;
            cvReport.qryJE.close;
            showmessage('Exporting completed...');
         end;
    end;
end;

procedure TMainForm.Check2Click(Sender: TObject);
var
   Line      : integer;
   PrintText : System.text;
begin
    dlgReportParameter1.caption  := 'Check No. ';
    dlgReportParameter1.sCheckNo.text := '0';
    dlgReportParameter1.eCheckNo.text := '0';
    dlgReportParameter1.ShowModal;
    if dlgReportParameter1.modalresult = mrok then
    begin
         AssignPrn(PrintText);
         Rewrite(PrintText);
         cvReport.qryCheck.close;
         cvReport.qryCheck.Open;
         cvReport.qryCheck.parambyname('sCheckNo').asstring := dlgReportParameter1.sCheckNo.text;
         cvReport.qryCheck.parambyname('eCheckno').asstring := dlgReportParameter1.eCheckNo.text;
         cvReport.qryCheck.parambyname('cBankName').asstring:= dlgReportParameter1.cBoxBank.text;
         {cvReport.qryCheck.Open;}
         cvReport.qryCheck.First;
         while not cvReport.qryCheck.eof do
         begin
             writeln(PrintText,cvReport.qryCheck.fieldbyname('cvno').asstring);
             writeln(PrintText,cvReport.qryCheck.fieldbyname('checkno').asstring);
             writeln(PrintText,cvReport.qryCheck.fieldbyname('checkdate').asstring);
             writeln(PrintText,cvReport.qryCheck.fieldbyname('payeename').asstring);
             writeln(PrintText,cvReport.qryCheck.fieldbyname('checkword').asstring);
             writeln(PrintText,floattostr(cvReport.qryCheck.fieldbyname('amount').asfloat));
             cvReport.qryCheck.next;
         end;
         cvReport.qryCheck.close;
    end;
end;

procedure TMainForm.AccountsPayable1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
begin
    CursorWait := LoadCursor(0,IDC_WAIT);
    SetCursor(CursorWait);
    CursorStd  := LoadCursor(0,IDC_ARROW);
    SetCursor(CursorStd);
    cvReport.qrySalesInv.close;
    cvReport.qrySalesInv.Open;
    cvReport.qrlBalDate.caption := 'as of ' +  DatetoStr(date);
    Report := cvReport.BalanceReg;
    PreviewClick(Report);
    cvReport.qrySalesInv.close;
end;

procedure TMainForm.PurchaseRegister1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
begin
    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);

         cvReport.qrySalesInv.close;
         cvReport.qrySalesInv.sql.clear;
         cvReport.qrySalesInv.sql.add('Select * from "Purchhd.db" Purchhd ');
         cvReport.qrySalesInv.sql.add('where (purchhd.SIDate >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                                     '(purchhd.SIDate <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')');
         cvReport.qrySalesInv.Open;
         cvReport.qrlBalDate.caption := DatetoStr(dlgReportParameter5.sDate.Date) +  ' -  ' + DatetoStr(dlgReportParameter5.eDate.Date);
         cvReport.qrLabel46.caption  := 'Purchase Register ';
         Report := cvReport.BalanceReg;
         PreviewClick(Report);
         cvReport.qrySalesInv.close;
    end;
end;

procedure TMainForm.VatDetail1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
begin
    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin

         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);

         {Payments}
         qryreusable1.close;
         qryreusable1.sql.clear;
         qryreusable1.sql.add('Select acctdet."cvno", acctdet."acctcode", acctdet."deptcode", acctdet."amount" as A, Acctdet."amount"*-1 as B, ' +
                                     'supplier."Tin" as SuppTin, Paymenthd."tin" as PayeeTin, paymenthd."amount" as amtpaid, paymenthd."datepaid", paymenthd."checkno", paymenthd."bankcode", paymenthd."suppcode", paymenthd."remark", ' +
                                     'acctdet."recno", bank."bankname", supplier."suppname", account."accountname" as acctname, paymenthd.payeename, paymenthd."supplier", paymenthd."DatePaid" ');
         qryreusable1.sql.add('from "AcctDet.db" AcctDet, "paymenthd.db" paymenthd, "bank.db" bank, "Supplier.db" supplier, "account.db" account');
         qryreusable1.sql.add('where acctdet."acctcode"='''+'110301' + ''' and ' +
                                     'acctdet."cvno"=paymenthd."cvno" and ' +
                                     'paymenthd."bankcode"=bank."bankcode" and paymenthd."suppcode"=supplier."suppcode" and acctdet."acctcode"=account."accountcode" and ' +
                                     '(paymenthd.DatePaid >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                                     '(paymenthd.DatePaid <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')');
         qryreusable1.sql.add('order by AcctDet."cvno"');
         qryreusable1.Open;

         tReusable1.close;
         treusable1.databasename := 'AccountData';
         treusable1.Tablename := 'taxreg.db';
         tReusable1.emptytable;
         treusable1.open;

         qryreusable1.first;
         while not qryreusable1.eof do
         begin
              treusable1.append;
              treusable1.fieldbyname('cvno').asstring   :=  qryreusable1.fieldbyname('cvno').asstring;
              treusable1.fieldbyname('date').asdatetime :=  qryreusable1.fieldbyname('datepaid').asdatetime;
              treusable1.fieldbyname('amount').asfloat  :=  qryreusable1.fieldbyname('a').asfloat;
              if cvreport.qryacctdet.fieldbyname('supplier').asboolean = true then
                   begin
                        treusable1.fieldbyname('compname').asstring :=  qryreusable1.fieldbyname('suppname').asstring;
                        treusable1.fieldbyname('tin').asstring      :=  qryreusable1.fieldbyname('Supptin').asstring;
                   end
              else
                   begin
                        treusable1.fieldbyname('compname').asstring :=  qryreusable1.fieldbyname('payeename').asstring;
                        treusable1.fieldbyname('tin').asstring      :=  qryreusable1.fieldbyname('payeetin').asstring;
                   end;
              treusable1.post;
              qryreusable1.next;
         end;


        {AP}
         qryReusable1.close;
         qryReusable1.sql.clear;
         qryReusable1.sql.add('Select Purchhd."SaleInv", Purchhd."SIDate", Purchhd."GrossAmt" as AmtPaid, Purchhd."suppcode", purchhd."description", ' +
                                     'acctdet."cvno", acctdet."acctcode", acctdet."deptcode", acctdet."amount" as A, Acctdet."amount"*-1 as B, ' +
                                     'supplier."tin", supplier."suppname", ' +
                                     'acctdet."recno", account."accountname" as acctname ');
         qryReusable1.sql.add('from "AcctDet.db" AcctDet, "purchhd.db" purchhd, "Supplier.db" supplier, "account.db" account');
         qryReusable1.sql.add('where acctdet."acctcode"='''+'110301' + ''' and ' +
                                     'acctdet."cvno"=purchhd."saleinv" and ' +
                                     'purchhd."suppcode"=supplier."suppcode" and acctdet."acctcode"=account."accountcode" and ' +
                                     '(purchhd.SIDate >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                                     '(purchhd.SIDate <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')');
         qryReusable1.sql.add('order by AcctDet."cvno"');
         qryReusable1.Open;

         qryReusable1.first;
         while not qryreusable1.eof do
         begin
              treusable1.append;
              treusable1.fieldbyname('cvno').asstring     :=  qryReusable1.fieldbyname('saleinv').asstring;
              treusable1.fieldbyname('date').asdatetime   :=  qryReusable1.fieldbyname('sidate').asdatetime;
              treusable1.fieldbyname('amount').asfloat    :=  qryReusable1.fieldbyname('a').asfloat;
              treusable1.fieldbyname('compname').asstring :=  qryReusable1.fieldbyname('suppname').asstring;
              treusable1.fieldbyname('tin').asstring      :=  qryReusable1.fieldbyname('tin').asstring;
              treusable1.post;
              qryReusable1.next;
         end;

         treusable1.close;
         qryreusable1.close;

         qryReusable1.close;
         qryReusable1.sql.clear;
         qryReusable1.sql.add('Select taxreg."cvno", taxreg."date", taxreg."Tin", taxreg."compname", taxreg."amount"');
         qryReusable1.sql.add('from "taxreg.db" Taxreg');
         qryReusable1.sql.add('Order by taxreg."compname"');
         qryReusable1.Open;

         cvReport.qrlVatDetRange.caption := DatetoStr(dlgReportParameter5.sDate.Date) +  ' -  ' + DatetoStr(dlgReportParameter5.eDate.Date);
         Report := cvReport.VatRegDet;
         PreviewClick(Report);
         qryreusable1.close;
    end;
end;



procedure TMainForm.EWTDetail1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
begin
    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);
         cvReport.qryAcctDet.close;
         cvReport.qryAcctDet.sql.clear;
         cvReport.qryAcctDet.sql.add('Select acctdet."cvno", acctdet."acctcode", acctdet."deptcode", acctdet."amount" as A, Acctdet."amount"*-1 as B, ' +
                                     'acctdet."recno", paymenthd."amount" as amtpaid, paymenthd."datepaid", paymenthd."checkno", paymenthd."bankcode", paymenthd."suppcode", paymenthd."remark", ' +
                                     'bank."bankname", supplier."suppname", account."accountname" as acctname, paymenthd.payeename, paymenthd."supplier", paymenthd."DatePaid" ');
         cvReport.qryAcctDet.sql.add('from "AcctDet.db" AcctDet, "paymenthd.db" paymenthd, "bank.db" bank, "Supplier.db" supplier, "account.db" account ');
         cvReport.qryAcctDet.sql.add('where acctdet."acctcode"='''+'200181' + ''' and ' +
                                     'acctdet."cvno"=paymenthd."cvno" and ' +
                                     'paymenthd."bankcode"=bank."bankcode" and paymenthd."suppcode"=supplier."suppcode" and acctdet."acctcode"=account."accountcode" and ' +
                                     '(acctdet."amount" < 0 ) and ' +
                                     '(paymenthd.DatePaid >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                                     '(paymenthd.DatePaid <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')');
         cvReport.qryAcctDet.sql.add('order by acctdet."cvno"');
         cvReport.qryAcctDet.Open;
         cvReport.qrlEWTSummaryRange.caption := DatetoStr(dlgReportParameter5.sDate.Date) +  ' -  ' + DatetoStr(dlgReportParameter5.eDate.Date);
         Report := cvReport.EWTRegDet;
         PreviewClick(Report);
         cvReport.qryAcctDet.close;
    end;
end;

procedure TMainForm.TaxRegister1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
begin

    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);

         treusable1.close;
         treusable1.databasename := 'AccountData';
         treusable1.tablename := 'purchreg.db';
         treusable1.emptytable;
         treusable1.open;

         cvReport.qryPurchTax.close;
         cvReport.qryPurchTax.sql.clear;
         cvReport.qryPurchTax.sql.add('Select purchhd."saleinv", purchhd."sidate", purchhd."grossamt", purchhd."suppcode", supplier."suppname", acctdet."cvno", acctdet."acctcode", acctdet."amount", acctdet."sourcecode", supplier."tin", purchhd."grossamt" ');
         cvReport.qryPurchTax.sql.add('From "purchhd.db" purchhd, "supplier.db" supplier, "acctdet.db" acctdet ');
         cvReport.qryPurchTax.sql.add('Where (acctdet."acctcode"='''+'110301' + ''' or ' +
                                      ' acctdet."acctcode"='''+'110302' + ''' or ' +
                                      ' acctdet."acctcode"='''+'110303' + ''' or ' +
                                      ' acctdet."acctcode"='''+'110304' + ''') and ' +
                                      ' acctdet."sourcecode"='''+'AP'+''' and ' +
                                      ' purchhd."suppcode"=supplier."suppcode" and ' +
                                      ' purchhd."saleinv"=acctdet."cvno" and ' +
                                      '(Purchhd.SIdate >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                                      '(Purchhd.SIdate <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')');
         cvReport.qryPurchTax.sql.add('order by supplier."suppname"');
         cvReport.qryPurchTax.Open;
         cvReport.qryPurchtax.first;
         while not cvReport.qryPurchtax.eof do
         begin
              treusable1.append;
              treusable1.fieldbyname('Description').asstring:= cvReport.qrypurchtax.fieldbyname('suppname').asstring;
              treusable1.fieldbyname('tin').asstring        := cvReport.qryPurchtax.fieldbyname('tin').asstring;
              treusable1.fieldbyname('saleinv').asstring    := cvReport.qrypurchtax.fieldbyname('saleinv').asstring;
              treusable1.fieldbyname('sidate').asdatetime   := cvReport.qrypurchtax.fieldbyname('sidate').asdatetime;
              treusable1.fieldbyname('vatamt').asfloat      := cvReport.qrypurchtax.fieldbyname('vatamt').asfloat;
              treusable1.fieldbyname('novatamt').asfloat    := cvReport.qrypurchtax.fieldbyname('novatamt').asfloat;
              treusable1.fieldbyname('zeratedamt').asfloat  := cvReport.qrypurchtax.fieldbyname('zeratedamt').asfloat;
              treusable1.fieldbyname('inputtaxamt').asfloat := cvReport.qrypurchtax.fieldbyname('inputtaxamt').asfloat;
              treusable1.fieldbyname('grossamt').asfloat    := cvReport.qryPurchtax.fieldbyname('grossamt').asfloat;
              treusable1.post;
              cvReport.qrypurchtax.next;
         end;

         cvReport.qryPurchTax.close;

         {Payments}
         qryreusable1.close;
         qryreusable1.sql.clear;
         qryreusable1.sql.add('Select acctdet."cvno", acctdet."acctcode", acctdet."deptcode", acctdet."amount" as A, Acctdet."amount"*-1 as B, ' +
                                     'supplier."Tin" as SuppTin, Paymenthd."tin" as PayeeTin, paymenthd."amount" as amtpaid, paymenthd."datepaid", paymenthd."checkno", paymenthd."bankcode", paymenthd."suppcode", paymenthd."remark", ' +
                                     'acctdet."recno", bank."bankname", supplier."suppname", account."accountname" as acctname, paymenthd.payeename, paymenthd."supplier", paymenthd."DatePaid" ');
         qryreusable1.sql.add('from "AcctDet.db" AcctDet, "paymenthd.db" paymenthd, "bank.db" bank, "Supplier.db" supplier, "account.db" account');
         qryreusable1.sql.add('where acctdet."acctcode"='''+'110301' + ''' and ' +
                                     'acctdet."cvno"=paymenthd."cvno" and ' +
                                     'paymenthd."bankcode"=bank."bankcode" and paymenthd."suppcode"=supplier."suppcode" and acctdet."acctcode"=account."accountcode" and ' +
                                     '(paymenthd.DatePaid >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                                     '(paymenthd.DatePaid <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')');
         qryreusable1.sql.add('order by AcctDet."cvno"');
         qryreusable1.Open;

         qryreusable1.first;
         while not qryreusable1.eof do
         begin
              treusable1.append;
              treusable1.fieldbyname('SaleInv').asstring   :=  qryreusable1.fieldbyname('cvno').asstring;
              treusable1.fieldbyname('SiDate').asdatetime  :=  qryreusable1.fieldbyname('datepaid').asdatetime;
              tReusable1.fieldbyname('grossamt').asfloat   :=  qryreusable1.fieldbyname('amtpaid').asfloat;
              treusable1.fieldbyname('InputTaxAmt').asfloat     :=  qryreusable1.fieldbyname('a').asfloat;
              if cvreport.qryacctdet.fieldbyname('supplier').asboolean = true then
                   begin
                        treusable1.fieldbyname('Description').asstring :=  qryreusable1.fieldbyname('suppname').asstring;
                        treusable1.fieldbyname('tin').asstring      :=  qryreusable1.fieldbyname('Supptin').asstring;
                   end
              else
                   begin
                        treusable1.fieldbyname('Description').asstring :=  qryreusable1.fieldbyname('payeename').asstring;
                        treusable1.fieldbyname('tin').asstring      :=  qryreusable1.fieldbyname('payeetin').asstring;
                   end;
              treusable1.post;
              qryreusable1.next;
         end;

         treusable1.close;
         treusable1.databasename := '';
         treusable1.tablename := '';

         qryReusable1.close;
         qryReusable1.sql.clear;
         qryReusable1.sql.add('Select purchreg."saleinv", purchreg."sidate", purchreg."Description", purchreg."tin", purchreg."grossamt", ' +
                              ' sum(purchreg."vatamt") as vatamt, sum(purchreg."novatamt") as novatamt , sum(purchreg."zeratedamt") as zeratedamt, sum(purchreg."inputtaxamt") as inputtaxamt');
         qryReusable1.sql.add('From "purchreg.db" purchreg ');
         qryReusable1.sql.add('group by purchreg."saleinv", purchreg."sidate", purchreg."grossamt", purchreg."tin", purchreg."Description" ');
         qryReusable1.sql.add('order by purchreg."Description", purchreg."saleinv"');
         qryReusable1.open;
         cvReport.qrlTaxRange.caption := DatetoStr(dlgReportParameter5.sDate.Date) +  ' -  ' + DatetoStr(dlgReportParameter5.eDate.Date);
         Report := cvReport.qRepPurchtax;
         PreviewClick(Report);
         qryreusable1.close;
    end;
end;

procedure TMainForm.Summary3Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
begin

  dlgReportParameter5.Caption := 'Enter cut-off date ';
  dlgReportParameter5.sDATE.Enabled := false;
  {dlgReportParameter5.sDate.date := date;}
  dlgReportParameter5.eDate.date := date;
  dlgReportParameter5.showmodal;
  if dlgReportParameter5.ModalResult=mrOk then
  begin
    CursorWait := LoadCursor(0,IDC_WAIT);
    SetCursor(CursorWait);
    CursorStd  := LoadCursor(0,IDC_ARROW);
    SetCursor(CursorStd);
    qryreusable1.close;
    qryreusable1.sql.clear;
    qryreusable1.sql.add('Select purchhd."suppcode", sum(Purchhd."balance") as Balance, Supplier."suppname", Supplier."remark" ');
    qryreusable1.sql.add('From "Purchhd.db" Purchhd, "Supplier.db" supplier ');
    qryreusable1.sql.add('Where Purchhd."suppcode"=Supplier."suppcode"  and Purchhd."balance" > 0 and ' +
                         '(Purchhd."duedate" <= ''' + datetostr(dlgReportParameter5.edate.date) + ''')');
    qryreusable1.sql.add('Group by supplier."suppname", Purchhd."suppcode", supplier."remark" ');
    qryreusable1.sql.add('Order by supplier."suppname", purchhd."suppcode", Supplier."remark" ');
    qryreusable1.Open;
    cvReport.qrlAPDateSum.caption := 'as of ' +  DatetoStr(dlgReportparameter5.edate.date);
    Report := cvReport.APSum;
    PreviewClick(Report);
    qryreusable1.close;
  end;
  dlgReportParameter5.sDATE.Enabled := true;
end;

procedure TMainForm.Detail3Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
    y,m,d : word;
    cYear : string[4];
begin
  dlgReportParameter5.Caption := 'Enter cut-off date ';
  dlgReportParameter5.sDATE.Enabled := false;
  {dlgReportParameter5.sDate.date := date;}
  dlgReportParameter5.eDate.date := date;
  dlgReportParameter5.showmodal;
  if dlgReportParameter5.ModalResult=mrOk then
  begin
    CursorWait := LoadCursor(0,IDC_WAIT);
    SetCursor(CursorWait);
    CursorStd  := LoadCursor(0,IDC_ARROW);
    SetCursor(CursorStd);

    {Transfer purchhd.db to purchreg.db}

    treusable1.close;
    treusable1.databasename := 'AccountData';
    treusable1.tablename := 'purchreg.db';
    treusable1.emptytable;
    treusable1.open;

    qryreusable1.sql.clear;
    qryreusable1.sql.add('select * from "purchhd.db" purchhd');
    qryreusable1.open;
    qryreusable1.first;
    while not qryreusable1.eof do
    begin
         decodedate(qryreusable1.fieldbyname('duedate').asdatetime,Y,M,D);
         treusable1.append;
         treusable1.FieldByName('saleinv').asstring   := qryreusable1.fieldbyname('saleinv').asstring;
         treusable1.fieldbyname('sidate').asDatetime  := qryreusable1.fieldbyname('sidate').asdatetime;
         treusable1.fieldbyname('suppcode').asstring  := qryreusable1.fieldbyname('suppcode').asstring;
         treusable1.fieldbyname('balance').asfloat    := qryreusable1.fieldbyname('balance').asfloat;
         treusable1.fieldbyname('duedate').asdatetime := qryreusable1.fieldbyname('duedate').asdatetime;
         treusable1.fieldbyname('description').asstring    := qryreusable1.fieldbyname('remark').asstring;
         treusable1.fieldbyname('year').asinteger     := Y;
         treusable1.fieldbyname('month').asinteger    := M;
         str(treusable1.fieldbyname('year').asinteger:4,cYear);
         case m of
         1: treusable1.fieldbyname('duemonth').asstring  := 'January ' + cYear;
         2: treusable1.fieldbyname('duemonth').asstring  := 'February ' + cYear;
         3: treusable1.fieldbyname('duemonth').asstring  := 'March ' + cYear;
         4: treusable1.fieldbyname('duemonth').asstring  := 'April ' + cYear;
         5: treusable1.fieldbyname('duemonth').asstring  := 'May ' + cYear;
         6: treusable1.fieldbyname('duemonth').asstring  := 'June ' + cYear;
         7: treusable1.fieldbyname('duemonth').asstring  := 'July ' + cYear;
         8: treusable1.fieldbyname('duemonth').asstring  := 'August ' + cYear;
         9: treusable1.fieldbyname('duemonth').asstring  := 'September ' + cYear;
         10: treusable1.fieldbyname('duemonth').asstring := 'October ' + cYear;
         11: treusable1.fieldbyname('duemonth').asstring := 'November ' + cYear;
         12: treusable1.fieldbyname('duemonth').asstring := 'December ' + cYear;
         end;
         treusable1.post;
         qryreusable1.next;
    end;

    treusable1.close;
    treusable1.databasename := '';
    treusable1.tablename := '';

    qryreusable1.close;
    qryreusable1.sql.clear;
    qryreusable1.sql.add('Select Purchreg."suppcode", Purchreg."balance", purchreg."sidate", purchreg."duedate", purchreg."duemonth", purchreg."saleinv", ' +
           'Purchreg."month", purchreg."year", Supplier."suppname", purchreg."description" ');
    qryreusable1.sql.add('From "Purchreg.db" Purchreg, "Supplier.db" supplier ');
    qryreusable1.sql.add('Where Purchreg."suppcode"=Supplier."suppcode"  and Purchreg."balance" > 0 and ' +
                         '(Purchreg."duedate" <= ''' + datetostr(dlgReportParameter5.edate.date) + ''')');
    qryreusable1.sql.add('Order by Supplier."SuppName", purchreg."year", purchreg."month"');
    qryreusable1.Open;
    cvReport.qrlAPDateDet.caption := 'as of ' +  DatetoStr(dlgReportParameter5.edate.date);
    Report := cvReport.APDet;
    PreviewClick(Report);
    qryreusable1.close;
  end;
  dlgReportParameter5.sDATE.Enabled := true;
end;

procedure TMainForm.CancelChk(Sender: TObject);
begin
    BrowChk.Showmodal;
end;

procedure TMainForm.CancelChecks1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
begin
    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.cBoxBank.enabled := true;

    dlgReportParameter5.cboxBank.items.clear;

    tReusable1.close;
    tReusable1.databaseName := 'AccountData';
    tReusable1.tableName := 'Bank.db';
    tReusable1.open;
    tReusable1.first;
    while not tReusable1.eof do
    begin
         dlgReportParameter5.cboxBank.items.add( tReusable1.fieldByName('BankName').asString );
         tReusable1.next;
    end;
    tReusable1.close;
    tReusable1.databaseName := '';
    tReusable1.tableName := '';
    tReusable1.indexName := '';

    dlgReportParameter5.cboxBank.itemIndex := 0;

    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin
         cvReport := tcvReport.create(application);
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);
         qryreusable1.close;
         qryreusable1.sql.clear;
         qryreusable1.sql.add('Select * from "Check.db" Chk, "bank.db" bank ');
         qryreusable1.sql.add(' where (Chk."bankcode"=bank."bankcode") and ' +
                                   ' (bank."bankname" = ''' + dlgreportparameter5.cBoxBank.text + ''') and ' +
                                   ' (chk.checkdate >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                                   ' (chk.checkdate <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')' +
                                   ' order by chk."checkno" ');
         cvReport.qrLabel125.caption := ' - ' + dlgreportparameter5.cBoxBank.text;
         qryreusable1.Open;
         cvReport.qrLabel124.caption := DatetoStr(dlgReportParameter5.sDate.Date) +  ' -  ' + DatetoStr(dlgReportParameter5.eDate.Date);
         Report := cvReport.CancelChk;
         PreviewClick(Report);
         qryreusable1.close;
         cvReport.free;
    end;
    dlgReportParameter5.cBoxBank.enabled := false;
end;


procedure TMainForm.cancelvoucher(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
begin

    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin
         cvReport := tcvreport.create(application);
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);
         cvReport.qryCheck.close;
         cvReport.qryCheck.sql.clear;
         cvReport.qryCheck.sql.add('Select * from "paymenthd.db" paymenthd, "bank.db" bank ');
         cvReport.qryCheck.sql.add(' where (paymenthd."bankcode"=bank."bankcode") and ' +
                                   ' (paymenthd."cancel" = true ) and ' +
                                   ' (paymenthd.DatePaid >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
                                   ' (paymenthd.DatePaid <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')' +
                                   ' order by paymenthd."cvno" ');

         cvReport.qryCheck.Open;
         cvReport.qrlabel36.caption := 'Cancelled Voucher Register';
         cvReport.qrlVoucherRange.caption := DatetoStr(dlgReportParameter5.sDate.Date) +  ' -  ' + DatetoStr(dlgReportParameter5.eDate.Date);
         Report := cvReport.VoucherReg;
         PreviewClick(Report);
         cvReport.qryCheck.close;
         cvreport.free;
    end;
end;

Procedure TMainForm.Setreport(value : TQuickRep);
begin
    Freport := value;
end;

Procedure TMainForm.PreviewClick(Sender : TObject);
begin
    Report.Preview;
end;

procedure TMainForm.AP3Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
    cType                 : string;
    reptyp  : string;
    Sheet,Column,Range : Variant;
    nrow : integer;

begin
    dlgreportparameter5 := tdlgreportparameter5.create(application);
    cType := 'AP';
    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin
         cvreport := tcvreport.create(application);
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);
         cvReport.qryJE.close;

         if cType = 'AP' then
              begin
                   cvReport.qryJe.sql.clear;
                   cvReport.qryje.sql.add('select * ');
                   cvReport.qryJe.sql.add('From  "acctdet.db" acctdet, "Purchhd.db" Purchhd ');
                   cvReport.qryje.sql.add('where purchhd."saleinv"=acctdet."cvNo" ');
                   cvReport.qryJE.sql.add('order by purchhd."apno", acctdet."recno" ');
              end
         else
              begin
                   cvReport.qryJe.sql.clear;
                   cvReport.qryje.sql.add('select * ');
                   cvReport.qryJe.sql.add('From  "acctdet.db" acctdet, "Paymenthd.db" PaymentHd ');
                   cvReport.qryje.sql.add('where paymenthd."cvno"=acctdet."cvNo" ');
                   cvReport.qryJE.sql.add('order by paymenthd."cvno", acctdet."recno" ');
              end;
         cvReport.qryJE.Open;

         tReusable1.close;
         treusable1.databasename := 'AccountData';
         treusable1.Tablename := 'acctreg.db';
         tReusable1.emptytable;
         treusable1.open;

         cvReport.qryJE.first;
         while not cvReport.qryje.eof do
         begin
         if (cvreport.qryJE.fieldbyname('sourcecode').asstring = cType) then
         begin
              treusable1.append;
              if (ctype = 'CV') then
                   if (cvReport.qryje.fieldbyname('acctcode').asstring = '100309') or
                      (cvReport.qryJe.fieldbyname('acctcode').asstring = '100306') or
                      ((cvreport.qryje.fieldbyname('acctcode').asstring = '200130') and (cvReport.qryje.fieldbyname('DebitAmt').asfloat > 0)) then
                   begin
                        treusable1.fieldbyname('cvno').asstring := 'CK ' + cvreport.qryje.fieldbyname('checkno').asstring;
                        treusable1.fieldbyname('checkdate').asdatetime  := cvreport.qryje.fieldbyname('checkdate').asdatetime;
                        treusable1.fieldbyname('datepaid').asdatetime   := cvreport.qryje.fieldbyname('checkdate').asdatetime;
                   end
                   else
                   begin
                        treusable1.fieldbyname('cvno').asstring := 'CV ' + cvreport.qryje.fieldbyname('cvno').asstring;
                        treusable1.fieldbyname('checkdate').asdatetime  := cvreport.qryje.fieldbyname('datepaid').asdatetime;
                        treusable1.fieldbyname('datepaid').asdatetime   := cvreport.qryje.fieldbyname('datepaid').asdatetime;
                   end
              else
                   treusable1.fieldbyname('cvno').asstring     := 'APV ' + cvreport.qryje.fieldbyname('apno').asstring;

              {    treusable1.fieldbyname('cvno').asstring     := 'SI ' + cvreport.qryje.fieldbyname('saleinv').asstring;}
              treusable1.fieldbyname('acctcode').asstring := cvreport.qryje.fieldbyname('acctcode').asstring;
              treusable1.fieldbyname('deptcode').asstring := cvreport.qryje.fieldbyname('deptcode').asstring;
              treusable1.fieldbyname('remark').asstring   := cvreport.qryje.fieldbyname('remark').asstring;
              treusable1.fieldbyname('acctname').asstring := cvreport.qryje.fieldbyname('acctname').asstring;
              if cType = 'CV' then
                   begin
                        if (cvreport.qryje.fieldbyname('supplier').asboolean = true) then
                             treusable1.fieldbyname('name').asstring     := cvreport.qryje.fieldbyname('suppname').asstring
                        else
                              treusable1.fieldbyname('name').asstring     := cvreport.qryje.fieldbyname('payeename').asstring;
                   end
              else
                   begin
                        treusable1.fieldbyname('name').asstring      := cvreport.qryje.fieldbyname('pusuname').asstring;
                        treusable1.fieldbyname('checkdate').asstring := cvreport.qryje.fieldbyname('sidate').asstring;
                        treusable1.fieldbyname('datepaid').asdatetime   := cvreport.qryje.fieldbyname('sidate').asdatetime;
                   end;
              treusable1.fieldbyname('amount').asfloat    := cvreport.qryje.fieldbyname('amount').asfloat;
              treusable1.fieldbyname('debitamt').asfloat  := cvreport.qryje.fieldbyname('debitamt').asfloat;
              treusable1.fieldbyname('creditamt').asfloat := cvreport.qryje.fieldbyname('creditamt').asfloat;
              treusable1.fieldbyname('SaleInv').asstring  := cvReport.qryje.fieldbyname('saleInv').asstring;
              {
              treusable1.fieldbyname('PurchNo').asstring  := cvReport.qryJe.fieldbyname('PurchNo').asstring;}
              treusable1.post;
         end;
              cvreport.qryje.next;
         end;
         cvReport.qryJE.Close;
         treusable1.close;

         qryReusable1.close;
         qryReusable1.sql.clear;
         qryReusable1.sql.add('Select * ');
         qryReusable1.sql.add('from "acctreg.db" Acctreg');
         qryReusable1.sql.add('Where (AcctReg.DatePaid >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
         '(AcctReg.DatePaid <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')');
         qryReusable1.Open;

         reptyp := 'AP Journal Entry';
         XLApplication := CreateOleObject('Excel.application');
         XLApplication.WorkBooks.Add(XLWBatWorkSheet);
         XLApplication.WorkBooks[1].WorkSheets[1].Name := RepTyp;
         Sheet := XLApplication.WorkBooks[1].WorkSheets[RepTyp];
         Column:= XLApplication.WorkBooks[1].WorkSheets[RepTyp].columns;

         Column.Font.size := 8;

         {Header}
         Sheet.cells[1,1] := 'AP Journal Entry';
         Sheet.cells[2,1] := 'Period Covered ' + datetostr(dlgreportparameter5.sDATE.Date) + ' - ' + datetostr(dlgreportparameter5.eDate.Date);

         {Column Header}
         Sheet.cells[5,2] := 'Account Code';
         Sheet.cells[5,3] := 'Dept. Code';
         Sheet.cells[5,4] := 'Reference No';
         Sheet.cells[5,5] := 'Purchase/Payment Date';
         Sheet.cells[5,6] := 'Payee Name';
         Sheet.cells[5,7] := 'Account Name';
         Sheet.cells[5,8] := 'Debit';
         Sheet.cells[5,9] := 'Credit';
         {
         Sheet.cells[5,10]:= 'Sales Inv.';
         Sheet.cells[5,11]:= 'PO No';
          }

         Column.Columns[1].columnwidth  := 15;
         Column.Columns[2].columnwidth  := 15;
         Column.Columns[3].columnwidth  := 15;
         Column.columns[4].columnwidth  := 15;
         Column.Columns[5].columnwidth  := 15;
         Column.Columns[6].columnwidth  := 30;
         Column.columns[7].columnwidth  := 15;
         Column.Columns[8].columnwidth  := 15;
         Column.Columns[9].columnwidth  := 15;

         nrow:=7;
         qryreusable1.First;
         while not qryreusable1.eof do
         begin
              Sheet.cells[nrow,2] := qryreusable1.fieldbyname('AcctCode').asstring;
              Sheet.cells[nrow,3] := qryreusable1.fieldbyname('DeptCode').asstring;
              Sheet.cells[nrow,4] := qryreusable1.fieldbyname('CVNo').asstring;
              Sheet.cells[nrow,5] := qryreusable1.fieldbyname('CheckDate').asdatetime;
              Sheet.cells[nrow,6] := qryreusable1.fieldbyname('Name').asstring;
              Sheet.cells[nrow,7] := qryreusable1.fieldbyname('AcctName').asstring;
              Sheet.cells[nrow,8] := qryreusable1.fieldbyname('DebitAmt').asfloat;
              Sheet.cells[nrow,9] := qryreusable1.fieldbyname('CreditAmt').asfloat;
              {
              Sheet.cells[nrow,10] := qryreusable1.fieldbyname('SaleInv').asstring;

              Sheet.cells[nrow,11] := qryreusable1.fieldbyname('PurchNo').asstring;
              }
              qryreusable1.next;
              nrow := nrow + 1;
         end;
         XLApplication.visible := true;
         qryReusable1.close;
         cvreport.free;
    end;
    dlgreportparameter5.free;
end;


procedure TMainForm.CV3Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
    cType                 : string;
    reptyp  : string;
    Sheet,Column,Range : Variant;
    nrow : integer;

begin
    cType := 'CV';
    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);
         cvReport.qryJE.close;

         if cType = 'AP' then
              begin
                   cvReport.qryJe.sql.clear;
                   cvReport.qryje.sql.add('select * ');
                   cvReport.qryJe.sql.add('From  "acctdet.db" acctdet, "Purchhd.db" Purchhd ');
                   cvReport.qryje.sql.add('where purchhd."saleinv"=acctdet."cvNo" ');
                   cvReport.qryJE.sql.add('order by purchhd."apno", acctdet."recno" ');
              end
         else
              begin
                   cvReport.qryJe.sql.clear;
                   cvReport.qryje.sql.add('select * ');
                   cvReport.qryJe.sql.add('From  "acctdet.db" acctdet, "Paymenthd.db" PaymentHd ');
                   cvReport.qryje.sql.add('where paymenthd."cvno"=acctdet."cvNo" ');
                   cvReport.qryJE.sql.add('order by paymenthd."cvno", acctdet."recno" ');
              end;
         cvReport.qryJE.Open;

         tReusable1.close;
         treusable1.databasename := 'AccountData';
         treusable1.Tablename := 'acctreg.db';
         tReusable1.emptytable;
         treusable1.open;

         cvReport.qryJE.first;
         while not cvReport.qryje.eof do
         begin
         if (cvreport.qryJE.fieldbyname('sourcecode').asstring = cType) then
         begin
              treusable1.append;
              if (ctype = 'CV') then
                   if (cvReport.qryje.fieldbyname('acctcode').asstring = '100309') or
                      (cvReport.qryJe.fieldbyname('acctcode').asstring = '100306') or
                      ((cvreport.qryje.fieldbyname('acctcode').asstring = '200130') and (cvReport.qryje.fieldbyname('DebitAmt').asfloat > 0)) then
                   begin
                        treusable1.fieldbyname('cvno').asstring := 'CK ' + cvreport.qryje.fieldbyname('checkno').asstring;
                        treusable1.fieldbyname('checkdate').asdatetime  := cvreport.qryje.fieldbyname('checkdate').asdatetime;
                        treusable1.fieldbyname('datepaid').asdatetime   := cvreport.qryje.fieldbyname('checkdate').asdatetime;
                   end
                   else
                   begin
                        treusable1.fieldbyname('cvno').asstring := 'CV ' + cvreport.qryje.fieldbyname('cvno').asstring;
                        treusable1.fieldbyname('checkdate').asdatetime  := cvreport.qryje.fieldbyname('datepaid').asdatetime;
                        treusable1.fieldbyname('datepaid').asdatetime   := cvreport.qryje.fieldbyname('datepaid').asdatetime;
                   end
              else
                   treusable1.fieldbyname('cvno').asstring     := 'APV ' + cvreport.qryje.fieldbyname('apno').asstring;

              {    treusable1.fieldbyname('cvno').asstring     := 'SI ' + cvreport.qryje.fieldbyname('saleinv').asstring;}
              treusable1.fieldbyname('acctcode').asstring := cvreport.qryje.fieldbyname('acctcode').asstring;
              treusable1.fieldbyname('deptcode').asstring := cvreport.qryje.fieldbyname('deptcode').asstring;
              treusable1.fieldbyname('remark').asstring   := cvreport.qryje.fieldbyname('remark').asstring;
              treusable1.fieldbyname('acctname').asstring := cvreport.qryje.fieldbyname('acctname').asstring;
              if cType = 'CV' then
                   begin
                        if (cvreport.qryje.fieldbyname('supplier').asboolean = true) then
                             treusable1.fieldbyname('name').asstring     := cvreport.qryje.fieldbyname('suppname').asstring
                        else
                              treusable1.fieldbyname('name').asstring     := cvreport.qryje.fieldbyname('payeename').asstring;
                   end
              else
                   begin
                        treusable1.fieldbyname('name').asstring      := cvreport.qryje.fieldbyname('pusuname').asstring;
                        treusable1.fieldbyname('checkdate').asstring := cvreport.qryje.fieldbyname('sidate').asstring;
                        treusable1.fieldbyname('datepaid').asdatetime   := cvreport.qryje.fieldbyname('sidate').asdatetime;
                   end;
              treusable1.fieldbyname('amount').asfloat    := cvreport.qryje.fieldbyname('amount').asfloat;
              treusable1.fieldbyname('debitamt').asfloat  := cvreport.qryje.fieldbyname('debitamt').asfloat;
              treusable1.fieldbyname('creditamt').asfloat := cvreport.qryje.fieldbyname('creditamt').asfloat;
              treusable1.post;
         end;
              cvreport.qryje.next;
         end;
         cvReport.qryJE.Close;
         treusable1.close;

         qryReusable1.close;
         qryReusable1.sql.clear;
         qryReusable1.sql.add('Select * ');
         qryReusable1.sql.add('from "acctreg.db" Acctreg');
         qryReusable1.sql.add('Where (AcctReg.DatePaid >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
         '(AcctReg.DatePaid <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')');
         qryReusable1.Open;

         reptyp := 'AP Journal Entry';
         XLApplication := CreateOleObject('Excel.application');
         XLApplication.WorkBooks.Add(XLWBatWorkSheet);
         XLApplication.WorkBooks[1].WorkSheets[1].Name := RepTyp;
         Sheet := XLApplication.WorkBooks[1].WorkSheets[RepTyp];
         Column:= XLApplication.WorkBooks[1].WorkSheets[RepTyp].columns;

         Column.Font.size := 8;

         {Header}
         Sheet.cells[1,1] := 'CV Journal Entry';
         Sheet.cells[2,1] := 'Period Covered ' + datetostr(dlgreportparameter5.sDATE.Date) + ' - ' + datetostr(dlgreportparameter5.eDate.Date);

         {Column Header}
         Sheet.cells[5,2] := 'Account Code';
         Sheet.cells[5,3] := 'Dept. Code';
         Sheet.cells[5,4] := 'Reference No';
         Sheet.cells[5,5] := 'Purchase/Payment Date';
         Sheet.cells[5,6] := 'Payee Name';
         Sheet.cells[5,7] := 'Account Name';
         Sheet.cells[5,8] := 'Debit';
         Sheet.cells[5,9] := 'Credit';
         Sheet.cells[5,10]:= 'Particulars';

         Column.Columns[1].columnwidth  := 15;
         Column.Columns[2].columnwidth  := 15;
         Column.Columns[3].columnwidth  := 15;
         Column.columns[4].columnwidth  := 15;
         Column.Columns[5].columnwidth  := 15;
         Column.Columns[6].columnwidth  := 30;
         Column.columns[7].columnwidth  := 15;
         Column.Columns[8].columnwidth  := 15;
         Column.Columns[9].columnwidth  := 15;

         nrow:=7;
         qryreusable1.First;
         while not qryreusable1.eof do
         begin
              Sheet.cells[nrow,2] := qryreusable1.fieldbyname('AcctCode').asstring;
              Sheet.cells[nrow,3] := qryreusable1.fieldbyname('DeptCode').asstring;
              Sheet.cells[nrow,4] := qryreusable1.fieldbyname('CVNo').asstring;
              Sheet.cells[nrow,5] := qryreusable1.fieldbyname('CheckDate').asdatetime;
              Sheet.cells[nrow,6] := qryreusable1.fieldbyname('Name').asstring;
              Sheet.cells[nrow,7] := qryreusable1.fieldbyname('AcctName').asstring;
              Sheet.cells[nrow,8] := qryreusable1.fieldbyname('DebitAmt').asfloat;
              Sheet.cells[nrow,9] := qryreusable1.fieldbyname('CreditAmt').asfloat;
              Sheet.cells[nrow,10]:= qryreusable1.fieldbyname('Remark').asstring;
              qryreusable1.next;
              nrow := nrow + 1;
         end;
         XLApplication.visible := true;
         qryReusable1.close;
    end;
end;

procedure TMainForm.ExporttoExcel1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
    cType                 : string;
    reptyp  : string;
    Sheet,Column,Range : Variant;
    nrow : integer;

begin
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);
         {
         cvReport.qryreusable1.close;
         cvreport.qryreusable1.sql.clear;
         cvreport.qryreusable1.sql.add('select * from Supplier order by suppname');
         cvreport.qryreusable1.Open;
         cvReport.qryreusable1.First;
          }
         reptyp := 'Supplier List';
         XLApplication := CreateOleObject('Excel.application');
         XLApplication.WorkBooks.Add(XLWBatWorkSheet);
         XLApplication.WorkBooks[1].WorkSheets[1].Name := RepTyp;
         Sheet := XLApplication.WorkBooks[1].WorkSheets[RepTyp];
         Column:= XLApplication.WorkBooks[1].WorkSheets[RepTyp].columns;

         Column.Font.size := 8;

         {Header}
         Sheet.cells[1,1] := 'Supplier List ';
         Sheet.cells[2,1] := 'as of  ' + datetostr(date());

         {Column Header}
         Sheet.cells[5,2] := 'Supplier Code';
         Sheet.cells[5,3] := 'Supplier Name';
         Sheet.cells[5,4] := 'Tin No.';
         Sheet.cells[5,5] := 'Address';

         Column.Columns[1].columnwidth  := 15;
         Column.Columns[2].columnwidth  := 15;
         Column.Columns[3].columnwidth  := 15;
         Column.columns[4].columnwidth  := 15;
         Column.Columns[5].columnwidth  := 15;
         Column.Columns[6].columnwidth  := 30;
         Column.columns[7].columnwidth  := 15;
         Column.Columns[8].columnwidth  := 15;
         Column.Columns[9].columnwidth  := 15;

         nrow:=7;
         {
         cvReport.qryreusable1.First;
         while not cvReport.qryreusable1.eof do
         begin
              Sheet.cells[nrow,2] := cvreport.qryreusable1.fieldbyname('Suppcode').asstring;
              Sheet.cells[nrow,3] := cvReport.qryreusable1.fieldbyname('suppname').asstring;
              Sheet.cells[nrow,4] := cvReport.qryreusable1.fieldbyname('Tin').asstring;
              Sheet.cells[nrow,5] := cvReport.qryreusable1.fieldbyname('Address').asstring;
              cvReport.qryreusable1.next;
              nrow := nrow + 1;
         end;
         XLApplication.visible := true;
         cvReport.qryReusable1.close;
         }
end;


procedure TMainForm.Print1Click(Sender: TObject);
var CursorStd,CursorWait : HCursor ;
    cType                 : string;
begin
    if sender = mainform.AP1 then
         cType := 'AP'
    else
         cType := 'CV';

    dlgReportParameter5.sDate.date := date;
    dlgReportParameter5.eDate.date := date;
    dlgReportParameter5.showmodal;
    if dlgReportParameter5.ModalResult=mrOk then
    begin
         {
         CursorWait := LoadCursor(0,IDC_WAIT);
         SetCursor(CursorWait);
         CursorStd  := LoadCursor(0,IDC_ARROW);
         SetCursor(CursorStd);
         cvReport.qryJE.close;

         if cType = 'AP' then
              begin
                   cvReport.qryJe.sql.clear;
                   cvReport.qryje.sql.add('select * ');
                   cvReport.qryJe.sql.add('From  "acctdet.db" acctdet, "Purchhd.db" Purchhd ');
                   cvReport.qryje.sql.add('where purchhd."saleinv"=acctdet."cvNo" ');
                   cvReport.qryJE.sql.add('order by purchhd."apno", acctdet."recno" ');
              end
         else
              begin
                   cvReport.qryJe.sql.clear;
                   cvReport.qryje.sql.add('select * ');
                   cvReport.qryJe.sql.add('From  "acctdet.db" acctdet, "Paymenthd.db" PaymentHd ');
                   cvReport.qryje.sql.add('where paymenthd."cvno"=acctdet."cvNo" ');
                   cvReport.qryJE.sql.add('order by paymenthd."cvno", acctdet."recno" ');
              end;
         cvReport.qryJE.Open;

         tReusable1.close;
         treusable1.databasename := 'AccountData';
         treusable1.Tablename := 'acctreg.db';
         tReusable1.emptytable;
         treusable1.open;

         cvReport.qryJE.first;
         while not cvReport.qryje.eof do
         begin
         if (cvreport.qryJE.fieldbyname('sourcecode').asstring = cType) then
         begin
              treusable1.append;
              if (ctype = 'CV') then
                   if (cvReport.qryje.fieldbyname('acctcode').asstring = '100309') or
                      (cvReport.qryJe.fieldbyname('acctcode').asstring = '100306') or
                      ((cvreport.qryje.fieldbyname('acctcode').asstring = '200130') and (cvReport.qryje.fieldbyname('DebitAmt').asfloat > 0)) then
                   begin
                        treusable1.fieldbyname('cvno').asstring := 'CK ' + cvreport.qryje.fieldbyname('checkno').asstring;
                        treusable1.fieldbyname('checkdate').asdatetime  := cvreport.qryje.fieldbyname('checkdate').asdatetime;
                        treusable1.fieldbyname('datepaid').asdatetime   := cvreport.qryje.fieldbyname('checkdate').asdatetime;
                   end
                   else
                   begin
                        treusable1.fieldbyname('cvno').asstring := 'CV ' + cvreport.qryje.fieldbyname('cvno').asstring;
                        treusable1.fieldbyname('checkdate').asdatetime  := cvreport.qryje.fieldbyname('datepaid').asdatetime;
                        treusable1.fieldbyname('datepaid').asdatetime   := cvreport.qryje.fieldbyname('datepaid').asdatetime;
                   end
              else
                   treusable1.fieldbyname('cvno').asstring     := 'APV ' + cvreport.qryje.fieldbyname('apno').asstring;

              treusable1.fieldbyname('acctcode').asstring := cvreport.qryje.fieldbyname('acctcode').asstring;
              treusable1.fieldbyname('deptcode').asstring := cvreport.qryje.fieldbyname('deptcode').asstring;
              treusable1.fieldbyname('remark').asstring   := cvreport.qryje.fieldbyname('remark').asstring;
              treusable1.fieldbyname('acctname').asstring := cvreport.qryje.fieldbyname('acctname').asstring;
              if cType = 'CV' then
                   begin
                        if (cvreport.qryje.fieldbyname('supplier').asboolean = true) then
                             treusable1.fieldbyname('name').asstring     := cvreport.qryje.fieldbyname('suppname').asstring
                        else
                              treusable1.fieldbyname('name').asstring     := cvreport.qryje.fieldbyname('payeename').asstring;
                   end
              else
                   begin
                        treusable1.fieldbyname('name').asstring      := cvreport.qryje.fieldbyname('pusuname').asstring;
                        treusable1.fieldbyname('checkdate').asstring := cvreport.qryje.fieldbyname('sidate').asstring;
                        treusable1.fieldbyname('datepaid').asdatetime   := cvreport.qryje.fieldbyname('sidate').asdatetime;
                   end;
              treusable1.fieldbyname('amount').asfloat    := cvreport.qryje.fieldbyname('amount').asfloat;
              treusable1.fieldbyname('debitamt').asfloat  := cvreport.qryje.fieldbyname('debitamt').asfloat;
              treusable1.fieldbyname('creditamt').asfloat := cvreport.qryje.fieldbyname('creditamt').asfloat;
              treusable1.post;
         end;
              cvreport.qryje.next;
         end;
         cvReport.qryJE.Close;
         treusable1.close;
         }
         qryReusable1.close;
         qryReusable1.sql.clear;
         qryReusable1.sql.add('Select * ');
         qryReusable1.sql.add('from "acctreg.db" Acctreg');
         qryReusable1.sql.add('Where (AcctReg.DatePaid >= ''' + DatetoStr(dlgReportParameter5.sdate.Date) + ''') and ' +
         '(AcctReg.DatePaid <= ''' + DatetoStr(dlgReportparameter5.edate.Date) + ''')');
         qryReusable1.Open;
         {
         cvReport.qrlJVRange.caption := DatetoStr(dlgReportParameter5.sDate.Date) +  ' -  ' + DatetoStr(dlgReportParameter5.eDate.Date);
         if cType = 'CV' then
              cvReport.qrlabel61.caption := 'CV Journal Entry'
         else
              cvReport.qrlabel61.caption := 'AP Journal Entry';
         Report := cvReport.JVReg;
         PreviewClick(Report);

         qryReusable1.close;


         Report := cvReport.QuickRep1;
         PreviewClick(Report);
          }

    end;

end;


end.
