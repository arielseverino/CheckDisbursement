unit UpdVoucher;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons, Db, DBGrids;

type
  TUpdCV = class(TForm)
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    dbeCVNo: TDBEdit;
    dbeDatePaid: TDBEdit;
    Label9: TLabel;
    dbeSuppCode: TDBEdit;
    dbtSuppname: TDBText;
    sbSupplier: TSpeedButton;
    dbeCheckNo: TDBEdit;
    Label10: TLabel;
    dbeOrNo: TDBEdit;
    dbmRemark: TDBMemo;
    btnOk: TButton;
    btnCancel: TButton;
    dbtAmount: TDBText;
    dsBank: TDataSource;
    dblcBankCode: TDBLookupComboBox;
    dbcDept: TDBCheckBox;
    dbcewt: TDBCheckBox;
    dbFullPay: TDBCheckBox;
    dbcChkStatus: TDBCheckBox;
    Label11: TLabel;
    dbeCheckDate: TDBEdit;
    cbSupplier: TCheckBox;
    dbePayeeName: TDBEdit;
    dbeAmount: TDBEdit;
    Label12: TLabel;
    dbeTin: TDBEdit;
    rgTranType: TRadioGroup;
    cbCancel: TCheckBox;
    dbcApproved: TDBCheckBox;
    procedure SearchSupp(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SuppFunc(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TranTypeFunc(Sender: TObject);
    procedure CancelCV(Sender: TObject);
    procedure AddCheck(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdCV: TUpdCV;

implementation

uses mainmenu, tselect, BrowPayment, UpdInvDet, BDE, Dlglog, UpdAccount, cvFunc;

{Uses tSelect, mainmenu;}

{$R *.DFM}


procedure TUpdCV.SearchSupp(Sender: TObject);
begin
   MainForm.tReusable1.close;
   MainForm.tReusable1.DatabaseName := 'AccountData';
   MainForm.tReusable1.tablename := 'Supplier.db';
   MainForm.DataSource1.DataSet := Mainform.tReusable1;
   MainForm.tReusable1.Open;

   rSelect.Caption := 'Select Supplier';
   rSelect.dbNavigator1.DataSource := MainForm.DataSource1;
   rSelect.DBGrid1.DataSource := MainForm.DataSource1;
   rSelect.dbGrid1.Columns.State := csDefault;
   rSelect.dbGrid1.Columns.add;
   rSelect.dbGrid1.Columns[0].FieldName := 'SuppCode';
   rSelect.dbGrid1.Columns[0].Title.Caption:='Supplier Code';
   rSelect.dbGrid1.Columns.add;
   rSelect.dbGrid1.Columns[1].FieldName := 'SuppName';
   rSelect.dbGrid1.Columns[1].Title.Caption:='Supplier Name';
   rSelect.Showmodal;
   try
      if rSelect.Modalresult=mrOk then
         begin
              BrowVoucher.tPaymentHd.fieldbyname('suppcode').asString :=
                  Mainform.tReusable1.fieldbyname('suppcode').asString;
              BrowVoucher.tPaymentHd.fieldbyname('Tin').asstring :=
                  Mainform.tReusable1.fieldbyname('Tin').asstring;
         end
   except
      ShowMessage('Operation not supported.');
      {MessageDlg('Missing field entries', [mbOk] , 0);}
   end;

   MainForm.tReusable1.Filtered := false;
   Mainform.tReusable1.Filter := '';
   MainForm.tReusable1.close;
   MainForm.tReusable1.DatabaseName := '';
   MainForm.tReusable1.tablename := '';

end;

procedure TUpdCV.FormActivate(Sender: TObject);
begin
    InvDet.tPaymentDet.Active := true;
    InvDet.tPaymentDet.Filtered := true;
    InvDet.tPaymentDet.Filter := 'CVNo = ''' + BrowVoucher.tPaymenthd.fieldbyname('CVNo').asstring+'''';

    if BrowVoucher.tpaymenthd.FieldByName('cancel').asboolean = true then
         cbCancel.state := cbChecked
    else
         cbCancel.state := cbUnchecked;
    if (mainform.tCompany.fieldbyname('userlevel').asinteger) = 0 then
         begin
              dbcChkStatus.readonly := false;
              dbeCVNo.readonly      := false;
              {dbeCheckNo.readonly   := false;}
              dbcApproved.readonly  := false;
         end
    else
         if BrowVoucher.tpaymenthd.fieldbyname('cancel').asboolean = true then
              cbCancel.Enabled := false;

    if BrowVoucher.tpaymenthd.fieldbyname('status').asboolean = false then
         dbeCheckno.readonly := false;

    if (BrowVoucher.tPaymenthd.Fieldbyname('Supplier').asBoolean = true) then
         begin
              cbSupplier.state := cbChecked;
              sbSupplier.enabled   := true;
              dbeSuppcode.enabled  := true;
              dbtSuppName.enabled  := true;
              dbtSuppName.visible  := true;
              dbePayeename.enabled := false;
              dbePayeename.visible := false;
              dbeAmount.enabled    := false;
              dbeAmount.visible    := false;
              dbtAmount.Enabled    := true;
              dbtAmount.visible    := true;
              dbeTin.Enabled       := true;
              dbeTin.visible       := true;
              label12.visible      := true;
         end
    else
         begin
              cbSupplier.state := cbUnchecked;
              dbeSuppCode.enabled  := false;
              dbtSuppName.enabled  := false;
              dbtSuppname.visible  := false;
              dbePayeeName.enabled := true;
              dbePayeeName.visible := true;
              dbeAmount.enabled    := true;
              dbeAmount.visible    := true;
              dbtAmount.Enabled    := false;
              dbtAmount.visible    := false;
              dbeTin.visible       := true;
              dbeTin.Enabled       := true;
              label12.visible      := true;
         end;

    if (BrowVoucher.tpaymenthd.FieldByName('Approved').asboolean = true) and
       (mainform.tcompany.fieldbyname('userlevel').asinteger > 0 ) then
    begin
         dbecvno.readonly     := true;
         dbedatepaid.readonly := true;
         dbesuppcode.readonly := true;
         dbepayeename.readonly:= true;
         dbeamount.readonly   := true;
         dbecheckno.readonly  := true;
         dbeorno.readonly     := true;
         dbecheckdate.readonly:= true;
         dbetin.readonly      := true;
         dbcdept.readonly     := true;
         dbcewt.readonly      := true;
         dbfullpay.readonly   := true;
         dbcchkstatus.readonly:= true;
         dbmremark.readonly   := true;
         dbcapproved.readonly := true;

         rgtrantype.enabled   := false;
         cbsupplier.enabled   := false;
         sbsupplier.enabled   := false;
         dblcbankcode.enabled := false;

    end;

end;

procedure TUpdCV.SuppFunc(Sender: TObject);
begin
    if (cbSupplier.state = cbUnChecked) then
    begin
         BrowVoucher.tPaymenthd.FieldByName('supplier').asboolean := false;
         BrowVoucher.tPaymenthd.fieldbyname('suppcode').asstring := '00000';
         sbSupplier.enabled   := false;
         dbeSuppCode.enabled  := false;
         dbtSuppName.enabled  := false;
         dbtSuppname.visible  := false;
         dbePayeeName.enabled := true;
         dbePayeeName.visible := true;
         dbeAmount.enabled    := true;
         dbeAmount.visible    := true;
         dbtAmount.Enabled    := false;
         dbtAmount.visible    := false;
    end
    else
         begin
              BrowVoucher.tPaymenthd.fieldbyname('supplier').asboolean := true;
              sbSupplier.enabled   := true;
              dbeSuppcode.enabled  := true;
              dbtSuppName.enabled  := true;
              dbtSuppName.visible  := true;
              dbePayeename.enabled := false;
              dbePayeename.visible := false;
              dbeAmount.enabled    := false;
              dbeAmount.visible    := false;
              dbtAmount.Enabled    := true;
              dbtAmount.visible    := true;
    end;
end;


procedure TUpdCV.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    InvDet.tPaymentDet.Active := false;
    if modalresult = mrok then
       begin
          if rgTranType.ItemIndex = 1 then
               BrowVoucher.tPaymenthd.fieldbyname('vat').asBoolean := true;

          browvoucher.tpaymenthd.post;
       end;
    if (mainform.tCompany.fieldbyname('userlevel').asinteger) > 0 then
         if BrowVoucher.tpaymenthd.fieldbyname('cancel').asboolean = true then
              cbCancel.Enabled := true;

    if modalresult = mrcancel then
        if BrowVoucher.tpaymenthd.FieldByName('Approved').asboolean = true then
        begin
                dbecvno.readonly     := false;
                dbedatepaid.readonly := false;
                dbesuppcode.readonly := false;
                dbepayeename.readonly:= false;
                dbeamount.readonly   := false;
                dbecheckno.readonly  := false;
                dbeorno.readonly     := false;
                dbecheckdate.readonly:= false;
                dbetin.readonly      := false;
                dbcdept.readonly     := false;
                dbcewt.readonly      := false;
                dbfullpay.readonly   := false;
                dbcchkstatus.readonly:= false;
                dbmremark.readonly   := false;
                dbcapproved.readonly := false;

                rgtrantype.enabled   := true;
                cbsupplier.enabled   := true;
                sbsupplier.enabled   := true;
                dblcbankcode.enabled := true;
        end;

end;

procedure TUpdCV.TranTypeFunc(Sender: TObject);
begin
    BrowVoucher.tpaymenthd.edit;
    BrowVoucher.tPaymenthd.fieldbyname('trantype').asInteger := rgTranType.ItemIndex;
end;


procedure TUpdCV.CancelCV(Sender: TObject);
begin
    if cbCancel.state = cbChecked then
         if InvDet.dsPaymentdet.dataset.recordcount = 0 then
              if UpdAcct.dsAcctDet.dataset.recordcount = 0 then
                   begin
                        if MessageDlg('Cancel Check Voucher ?',mtconfirmation,[mbYes,mbNo],0) = mrYes then
                             BrowVoucher.tPaymentHD.fieldbyname('cancel').asboolean := true
                   end
              else
                   begin
                        showmessage('Cannot cancel CV with Acct. Entry detail...');
                        cbCancel.state := cbUnchecked;
                   end

         else
              begin
                   showmessage('Cannot cancel CV with Invoice detail...');
                   cbCancel.state := cbUnchecked;
              end
    else
         begin
              cbcancel.state := cbUnchecked;
              BrowVoucher.tPaymenthd.fieldbyname('cancel').asboolean := false;
    end;
end;

procedure TUpdCV.AddCheck(Sender: TObject);
begin
    BrowVoucher.tPaymenthd.fieldbyname('checkno').asstring := padlzero(BrowVoucher.tBank.fieldbyname('chkctr').asinteger,6);
end;

end.
