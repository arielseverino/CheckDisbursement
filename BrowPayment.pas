unit BrowPayment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, StdCtrls, DBCtrls, ExtCtrls, Buttons, jpeg;

type
  TBrowVoucher = class(TForm)
    pnlHeader1: TPanel;
    DBNavigator1: TDBNavigator;
    Edit1: TEdit;
    Label1: TLabel;
    tPaymentHD: TTable;
    dsPaymentHd: TDataSource;
    tSupplier: TTable;
    tPaymentHDsuppname: TStringField;
    tPaymentHDCVNO: TStringField;
    tPaymentHDSuppCode: TStringField;
    tPaymentHDCheckNo: TStringField;
    tPaymentHDDatePaid: TDateField;
    tPaymentHDAmount: TFloatField;
    tPaymentHDRemark: TMemoField;
    tPaymentHDBankCode: TStringField;
    tPaymentHDVat: TBooleanField;
    tPaymentHDEWT: TBooleanField;
    tPaymentHDDept: TBooleanField;
    pnlHeader2: TPanel;
    BitBtn1: TBitBtn;
    Button8: TButton;
    tPaymentHDORNo: TStringField;
    tBank: TTable;
    tPaymentHDBankName: TStringField;
    tPaymentHDFullpay: TBooleanField;
    tPaymentHDCheckDate: TDateField;
    tPaymentHDStatus: TBooleanField;
    tPaymentHDSupplier: TBooleanField;
    tPaymentHDPayeeName: TStringField;
    tPaymentHDpayee: TStringField;
    tPaymentHDTin: TStringField;
    tPaymentHDTranType: TFloatField;
    tPaymentHDCancel: TBooleanField;
    tPaymentHDApproved: TBooleanField;
    pnlHeader: TPanel;
    Image1: TImage;
    Label3: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    pnlDetail1: TPanel;
    DBGrid1: TDBGrid;
    pnlDetail2: TPanel;
    DBGrid2: TDBGrid;
    procedure AddVoucher(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ClickInv(Sender: TObject);
    procedure SearchKey(Sender: TObject);
    procedure EditVoucher(Sender: TObject);
    procedure DeleteCV(Sender: TObject);
    procedure AddAcctDet(Sender: TObject);
    procedure DeleteAcct(Sender: TObject);
    procedure RefResh(Column: TColumn);
    procedure EditAcct(Sender: TObject);
    procedure RepVoucher(Sender: TObject);
    procedure RepCheck(Sender: TObject);
    procedure GetPayee(DataSet: TDataSet);
    procedure Refresh1(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BrowVoucher: TBrowVoucher;

implementation

uses UpdVoucher, UpdInvDet, UpdAcctDet, UpdAccount, RepCV, CVFunc, mainmenu;


{$R *.DFM}

procedure TBrowVoucher.AddVoucher(Sender: TObject);
begin
    UpdCV := tUpdCV.create(application);
    InvDet := tInvDet.create(application);
    AcctDet:=tAcctDet.create(application);

    Updcv.rgTranType.ItemIndex := 0;
    tPaymenthd.append;
    tPaymenthd.fieldbyname('cvno').asstring    := padlzero(mainform.tcompany.fieldbyname('cvctr').asinteger,6);

    UpdCV.Caption := 'New Check Voucher';
    UpdCV.ShowModal;
    if UpdCV.ModalResult = mrOk then
    begin
         mainform.tcompany.edit;
         mainform.tcompany.fieldbyname('cvctr').asinteger := tPaymenthd.fieldbyname('cvno').asinteger + 1;
         mainform.tcompany.post;
         tBank.edit;
         tbank.fieldbyname('chkctr').asinteger:= tpaymenthd.fieldbyname('checkno').asinteger +1;
         tBank.post;
         if (tPaymenthd.fieldbyname('supplier').asboolean = true ) then
         begin
              InvDet.Caption  := 'Check Voucher Detail';
              InvDet.ShowModal;
              {if tPaymenthd.FieldByName('fullpay').asBoolean = true then
               begin}
              AcctDet.Caption := 'Account Distribution';
              AcctDet.ShowModal;
         end
               {end;}
         else
              begin
                   AcctDet.Caption := 'Account Distribution';
                   AcctDet.ShowModal;
              end;
    end
    else
         tPaymenthd.cancel;

    UpdCV.free;
    InvDet.free;
    AcctDet.free; 
end;

procedure TBrowVoucher.FormActivate(Sender: TObject);
begin

    mainform.tcompany.active := true;

    tPaymenthd.active := true;
    tpaymenthd.last;

    tSupplier.Active  := true;
    tBank.Active      := true;

    UpdAcct.tAccount.Active := true;
    UpdAcct.tAcctDet.Active := true;
    UpdAcct.tDepartment.active:=true;

    UpdAcct.tAcctDet.Filtered := true;
    UpdAcct.tAcctDet.Filter := 'CVNo = ''' + tPaymenthd.fieldbyname('CVNo').asstring+''' and sourcecode = ' + '''CV''';

end;

procedure TBrowVoucher.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

    mainform.tcompany.active := false;

    tPaymenthd.active := false;
    tSupplier.Active  := false;
    tBank.Active      := false;

    UpdAcct.tAccount.Active   := false;
    UpdAcct.tAcctDet.Active   := false;
    UpdAcct.tDepartment.active := false;
end;

procedure TBrowVoucher.ClickInv(Sender: TObject);
begin
   InvDet := tInvDet.create(application);
   InvDet.ShowModal;
   InvDet.free; 
end;

procedure TBrowVoucher.SearchKey(Sender: TObject);
begin
     if (Edit1.text <> '') then
        tPaymentHd.FindNearest([Edit1.text]);
end;

procedure TBrowVoucher.EditVoucher(Sender: TObject);
begin
    InvDet := tInvDet.create(application);
    AcctDet:=tAcctDet.create(application);

    if dsPaymentHd.dataset.RecordCount = 0 then
        ShowMessage('Operation not supported.')
     else
        begin
             tPaymentHd.Edit;
             UpdCV.dbeCVNo.ReadOnly := true;
             UpdCV.cbSupplier.Enabled := false;
             UpdCV.Caption := 'Edit Check Voucher';
             if tPaymentHd.FieldbyName('Amount').value <> 0 then
                 UpdCV.dbeCVNo.Readonly := true;
                 UpdCV.cbSupplier.Enabled := false;
             UpdCV.ShowModal;
             UpdCV.dbeCVNo.ReadOnly := false;
             UpdCV.cbSupplier.Enabled := true;
        end;
end;

procedure TBrowVoucher.DeleteCV(Sender: TObject);
begin
    if dsPaymentHd.dataset.recordcount = 0 then
        ShowMessage('Operation not supported.')
    else
         if tPaymenthd.fieldbyname('Amount').asFloat <> 0 then
              ShowMessage('This Check Voucher has detail already, delete detail first.')
        else
              if MessageDlg('Delete current record ?',mtconfirmation,[mbYes,mbNo],0) = mrYes then
                   tPaymentHD.Delete;
end;

procedure TBrowVoucher.AddAcctDet(Sender: TObject);
var precno : real;
begin
if (tpaymenthd.fieldbyname('approved').asboolean = true) and
   (mainform.tcompany.fieldbyname('userlevel').asinteger > 0 ) then
    showmessage('Already approved for check printing, cannot allow addition...')
else
    begin
         UpdAcct.tAcctDet.Append;
         UpdAcct.tAcctdet.FieldByName('recno').asfloat  := UpdAcct.tAcctdet.recordcount;
         UpdAcct.tAcctDet.FieldByName('CVNo').asString := tPaymenthd.fieldbyname('cvno').asstring;
         UpdAcct.tAcctDet.Fieldbyname('sourcecode').asstring := 'CV';
         UpdAcct.Caption := 'Account Distribution';
         UpdAcct.ShowModal;
    end;
end;

procedure TBrowVoucher.DeleteAcct(Sender: TObject);
begin
    if UpdAcct.dsAcctDet.dataset.recordcount = 0 then
        ShowMessage('Operation not supported.')
    else
         if MessageDlg('Delete current record ?',mtconfirmation,[mbYes,mbNo],0) = mrYes then
                   UpdAcct.tAcctDet.Delete;

end;

procedure TBrowVoucher.RefResh(Column: TColumn);
begin
     UpdAcct.tAcctDet.Filtered := true;
     UpdAcct.tAcctDet.Filter := 'CVNo = ''' + tPaymenthd.fieldbyname('CVNo').asstring+''' and sourcecode = ' + '''CV''';
end;

procedure TBrowVoucher.EditAcct(Sender: TObject);
begin
if (tpaymenthd.fieldbyname('approved').asboolean = true) and
   (mainform.tcompany.fieldbyname('userlevel').asinteger > 0 ) then
    showmessage('Already approved for check printing, cannot allow editing...')
else
    begin
         UpdAcct.tAcctDet.Edit;
         UpdAcct.Caption := 'Account Distribution';
         UpdAcct.ShowModal;
    end;     
end;

procedure TBrowVoucher.RepVoucher(Sender: TObject);
var sChkAmt,sCent : string;
    tChkAmt : tStrings;
    Y,M,D   : word;
    pdMonth  : string;
    chkMonth : string;
    precno   : integer;
begin

    precno := tpaymenthd.recno;
    cvReport.qrlDatepaid.caption  := '';
    cvReport.qrlCheckDate.caption := '';
    if tpaymenthd.fieldbyname('datepaid').asdatetime<>0 then
    begin
       decodedate(tpaymenthd.fieldbyname('datepaid').asdatetime,y,m,d);
       case m of
       1: pdMonth := 'Jan.';
       2: pdMonth := 'Feb.';
       3: pdMonth := 'Mar.';
       4: pdMonth := 'Apr.';
       5: pdMonth := 'May.';
       6: pdMonth := 'Jun.';
       7: pdMonth := 'Jul.';
       8: pdMonth := 'Aug.';
       9: pdMonth := 'Sep.';
       10: pdMonth := 'Oct.';
       11: pdMonth := 'Nov.';
       12: pdMonth := 'Dec.';
       end;
       cvReport.qrlDatePaid.caption := pdmonth+' '+IntToStr(D)+', '+IntToStr(Y);
    end;

    if tpaymenthd.fieldbyname('CheckDate').asdatetime<>0 then
    begin
       decodedate(tpaymenthd.fieldbyname('CheckDate').asdatetime,y,m,d);
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
       cvReport.qrlCheckDate.caption := Chkmonth+' '+IntToStr(D)+', '+IntToStr(Y);
    end;


    Str(tPaymenthd.fieldbyname('amount').asfloat:12:2,sChkAmt);
    sCent := copy(sChkAmt,length(sChkAmt)-1,2);
    if sCent <> '00' then
       sCent := ' AND ' + sCent + '/100 ONLY'
    else
       sCent := ' ONLY';
    tChkAmt := tStringList.Create;
    tChkAmt.add(ConvAmt(sChkAmt)+ sCent);
    cvReport.cCheckAmt.lines.assign(tChkAmt);
    tChkAmt.free;
    cvReport.qryAcctDet.close;
    cvReport.qryAcctDet.sql.clear;
    cvReport.qryAcctDet.sql.Add('Select AcctDet."CvNo", AcctDet."AcctCode", ' +
         'AcctDet."DeptCode", AcctDet."Amount" as A, AcctDet."Amount"*-1 as B, AcctDet."SourceCode",' +
         'Paymenthd."Amount" as AmtPaid, Paymenthd."SuppCode", Paymenthd."remark", ' +
         'Paymenthd."DatePaid", Paymenthd."bankcode", Paymenthd."Checkno", ' +
         'Paymenthd."supplier" as Supplier, Paymenthd."PayeeName" as PayeeName, AcctDet."recno" ');
    cvReport.qryAcctDet.sql.add('From "AcctDet.db" AcctDet, "Paymenthd.db" Paymenthd ');
    cvReport.qryAcctDet.sql.add('Where (paymenthd."cvno" = ''' + tPaymenthd.fieldbyname('cvno').asstring + ''') and ' +
          '(AcctDet."SourceCode"='''+ 'CV'+ ''') and ' +
          '(AcctDet."cvno"=paymenthd."cvno")');
    cvReport.qryAcctDet.sql.add('order by acctdet."recno"');
    cvReport.qryAcctDet.open;
   { cvReport.qryAcctDet.parambyname('cvno').asstring := tPaymenthd.fieldbyname('cvno').asstring;}
    cvReport.qRepCV.preview;
    cvReport.qryAcctDet.close;
    tpaymenthd.recno := precno;

end;

procedure TBrowVoucher.RepCheck(Sender: TObject);
var sChkAmt,sCent : string;
    tChkAmt : tStrings;
    Y,M,D   : word;
    chkMonth : string;

begin
    if tpaymenthd.fieldbyname('CheckDate').asdatetime<>0 then
    begin
       decodedate(tpaymenthd.fieldbyname('CheckDate').asdatetime,y,m,d);
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
       cvReport.qrlChkDate.caption := Chkmonth+' '+IntToStr(D)+', '+IntToStr(Y);
    end;
    Str(tPaymenthd.fieldbyname('amount').asfloat:12:2,sChkAmt);
    sCent := copy(sChkAmt,length(sChkAmt)-1,2);
    if sCent <> '00' then
       sCent := ' AND ' + sCent + '/100 ONLY'
    else
       sCent := ' ONLY';
    tChkAmt := tStringList.Create;
    tChkAmt.add(ConvAmt(sChkAmt)+ sCent);
    cvReport.qrmChkword.lines.assign(tChkAmt);
    tChkAmt.free;
    if (tpaymenthd.fieldbyname('supplier').asboolean=true) then
         cvReport.qrlSuppname.caption := tpaymenthd.fieldbyname('suppname').asstring
    else
         cvReport.qrlSuppname.caption := tpaymenthd.fieldbyname('payeename').asstring;
    cvreport.qrlcvno.caption     := tpaymenthd.fieldbyname('cvno').asstring;
    cvreport.qrlckno.caption     := tpaymenthd.fieldbyname('checkno').asstring;
    {cvreport.qrlchkamt.caption   := tpaymenthd.fieldbyname('amount').asstring;}
    cvreport.qrdbchkamt.dataset  := tpaymenthd;
    cvreport.qrdbchkamt.datafield:= 'amount';
    {cvreport.qrdbtext2.dataset   := tPaymenthd;
    cvreport.qrdbtext2.datafield := 'cvno';
    cvreport.qreCheckAmt.expression := 'formatnumeric(tpaymenthd.fieldbyname(''' +
    'checkamt'''+').asfloat,'+'''#,###.##'''+')';}
    MainForm.Report := cvReport.qRepSCheck;
    Mainform.PreviewClick(MainForm.Report);
    {cvReport.qRepSCheck.preview;}
end;

procedure TBrowVoucher.GetPayee(DataSet: TDataSet);
begin
     if (tpaymenthd.fieldbyname('supplier').asBoolean = true) then
         tpaymenthd.fieldbyname('payee').asstring := tpaymenthd.fieldbyname('suppname').asstring
     else
         tpaymenthd.fieldbyname('payee').asstring := tpaymenthd.fieldbyname('payeename').asstring;
end;

procedure TBrowVoucher.Refresh1(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    UpdAcct.tAcctDet.Filtered := true;
    UpdAcct.tAcctDet.Filter := 'CVNo = ''' + tPaymenthd.fieldbyname('CVNo').asstring+''' and sourcecode = ' + '''CV''';
end;

end.
