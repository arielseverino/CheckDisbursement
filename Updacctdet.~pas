unit UpdAcctDet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, Mask, Db, DBTables, Grids, DBGrids, DBCtrls;

type
  TAcctDet = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    btnAdd: TButton;
    btnEdit: TButton;
    btnclose: TButton;
    btnDelete: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    sbAccount: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    dbeDeptCode: TDBEdit;
    Label4: TLabel;
    dbeAcctCode: TDBEdit;
    Label5: TLabel;
    dbePercent: TDBEdit;
    dbtAcctName: TDBText;
    procedure FormActivate(Sender: TObject);
    procedure AddAcct(Sender: TObject);
    procedure AcctOk(Sender: TObject);
    procedure CancelAcct(Sender: TObject);
    procedure DistAcct(Sender: TObject);
    procedure SearchAcct(Sender: TObject);
    procedure DelAcct(Sender: TObject);
    procedure EditAcct(Sender: TObject);
    procedure CheckDept(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AcctDet: TAcctDet;
  nVatAmt, nNoVatAmt, nVPAmt : Real;

implementation

uses UpdVoucher, BrowPayment, mainmenu, tselect, UpdAccount ;

{$R *.DFM}

procedure TAcctDet.FormActivate(Sender: TObject);
var SearchOptions : tLocateOptions;
begin
    UpdAcct.tAcctDet.Filtered := true;
    UpdAcct.tAcctDet.Filter := 'CVNo = ''' + BrowVoucher.tPaymenthd.fieldbyname('CVNo').asstring+''' and sourcecode = ' + '''CV''';

    {Vat }
    if BrowVoucher.tPaymenthd.fieldbyname('trantype').asInteger=1 then
         begin
              if BrowVoucher.tPaymenthd.fieldbyname('EWT').asBoolean = true then
                   nVatAmt   := (BrowVoucher.tPaymentHd.fieldbyname('Amount').asFloat)/0.95
              else
                   nVatAmt   := BrowVoucher.tPaymenthd.fieldbyname('Amount').asfloat;
              nVPAmt := (nVatAmt*10)/11;
         end
    else  {Non Vat & Zero Rated & Normal}
         begin
              if BrowVoucher.tPaymenthd.fieldbyname('EWT').asBoolean = true then
                   nNoVatAmt := (BrowVoucher.tPaymenthd.fieldbyname('amount').asfloat)/0.95
              else
                   nNoVatAmt := BrowVoucher.tPaymenthd.fieldbyname('amount').asfloat;
              nVPAmt    := nNoVatAmt;
         end;

    {Vat / Non Vat / Zero Rated}
    if (BrowVoucher.tPaymenthd.fieldbyname('supplier').asBoolean = false) and
       (BrowVoucher.tPaymenthd.fieldbyname('trantype').asInteger > 0 )  then
         begin
              UpdAcct.tacctdet.edit;
              UpdAcct.tacctDet.append;
              UpdAcct.tacctdet.FieldByName('recno').asfloat := UpdAcct.tAcctdet.RecordCount;
              UpdAcct.tAcctDet.FieldByName('cvno').asstring := BrowVoucher.tPaymentHD.fieldbyname('cvno').asstring;
              updacct.tacctdet.fieldbyname('sourcecode').asstring := 'CV';

              {Vat}
              if (BrowVoucher.tPaymenthd.fieldbyname('trantype').asInteger = 1) then
                   begin
                        UpdAcct.tAccount.first;
                        if UpdAcct.tAccount.locate('Code','06',SearchOptions) then
                             begin
                                  UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := UpdAcct.tAccount.Fieldbyname('AccountCode').asString;
                                  UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat    := nVatAmt ;
                             end
                   end
              else {Non Vat}
                   if (BrowVoucher.tPaymenthd.fieldbyname('trantype').asInteger=2) then
                        begin
                             UpdAcct.tAccount.first;
                             if UpdAcct.tAccount.locate('Code','01',SearchOptions) then
                                  begin
                                       UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := UpdAcct.tAccount.Fieldbyname('AccountCode').asString;
                                       UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat    := nNoVatAmt;
                                  end;
                        end
                   else {Zero Rated}
                        if UpdAcct.tAccount.locate('Code','08',SearchOptions) then
                             begin
                                  UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := UpdAcct.tAccount.Fieldbyname('AccountCode').asString;
                                  UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat    := nNoVatAmt;
                             end;
              UpdAcct.tAcctDet.Post;
         end;
end;

procedure TAcctDet.AddAcct(Sender: TObject);
begin

    UpdAcct.tAcctDet.Append;
    UpdAcct.tacctdet.FieldByName('recno').asfloat := UpdAcct.tAcctdet.recordcount;
    if BrowVoucher.tPaymentHd.fieldbyname('Dept').asBoolean = true then
         begin
              dbeDeptCode.Enabled := true;
              dbePercent.Enabled  := true;
         end
    else
         begin
            {
            if BrowVoucher.tPaymenthd.fieldbyname('EWT').asBoolean = true then
                BrowVoucher.tAcctDet.fieldbyname('Percent').asfloat := (100/95)*100
            else
                BrowVoucher.tAcctDet.fieldbyname('Percent').asfloat := 100;}
             UpdAcct.tAcctDet.fieldbyname('Percent').asfloat := 100;
         end;
    dbeAcctCode.Enabled := true;

    btnOk.Enabled       := true;
    btnCancel.Enabled   := true;
    btnAdd.Enabled      := false;
    btnEdit.Enabled     := false;
    btnDelete.Enabled   := false;
    btnClose.Enabled    := false;
    sbAccount.Enabled   := true;

    UpdAcct.tAcctDet.FieldByName('CVNo').asstring     := BrowVoucher.tPaymenthd.fieldbyname('CVNo').asstring;
    updAcct.tAcctDet.fieldbyname('sourcecode').asstring := 'CV';

end;

procedure TAcctDet.AcctOk(Sender: TObject);
begin

    if BrowVoucher.tPaymenthd.fieldbyname('Dept').asBoolean = true then
         UpdAcct.tAcctDet.fieldbyname('amount').asfloat := nVPAmt * ((UpdAcct.tAcctDet.Fieldbyname('Percent').asfloat)/100)
    else

         UpdAcct.tAcctDet.FieldByName('amount').asfloat := nVPAmt * ((UpdAcct.tAcctDet.Fieldbyname('Percent').asfloat)/100);
    UpdAcct.tAcctDet.post;

    dbeAcctCode.Enabled := false;
    dbePercent.Enabled  := false;
    sbAccount.Enabled   := false;
    btnOk.Enabled       := false;
    btnCancel.Enabled   := false;

    btnAdd.Enabled     := true;
    btnEdit.Enabled    := true;
    btnDelete.Enabled  := true;
    btnClose.Enabled   := true;

end;

procedure TAcctDet.CancelAcct(Sender: TObject);
begin

     UpdAcct.tAcctDet.Cancel;

     dbeAcctCode.Enabled := false;
     dbePercent.Enabled  := false;

     sbAccount.Enabled   := false;
     btnOk.Enabled       := false;
     btnCancel.Enabled   := false;

     btnAdd.Enabled     := true;
     btnEdit.Enabled    := true;
     btnDelete.Enabled  := true;
     btnClose.Enabled   := true;

     {nOldAmt := 0}

end;

procedure TAcctDet.DistAcct(Sender: TObject);
var SearchOptions : tLocateOptions;
    cAcctCode     : String;
begin

    {vat}
    if BrowVoucher.tPaymentHd.fieldbyname('TranType').asInteger = 1 then
         begin
              {07-Vat Input tax}
              UpdAcct.tAccount.first;
              if UpdAcct.tAccount.locate('Code','07',SearchOptions) then
                   begin
                        cAcctCode := UpdAcct.tAccount.fieldbyname('AccountCode').asstring;
                        UpdAcct.tAcctDet.Append;
                        UpdAcct.tAcctdet.fieldbyname('recno').asfloat      := UpdAcct.tAcctdet.recordcount;
                        UpdAcct.tAcctDet.Fieldbyname('CVno').asstring     := BrowVoucher.tPaymenthd.fieldbyname('cvno').asstring;
                        UpdAcct.tAcctDet.fieldbyname('sourcecode').asstring:= 'CV';
                        UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := cAcctCode;
                        UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat    := nVPAmt*0.10 ;
                        UpdAcct.tAcctDet.Post;
                   end;
              {05-EWT}
              if BrowVoucher.tPaymenthd.fieldbyname('EWT').asBoolean = true then
                   begin
                        UpdAcct.tAccount.First;
                        if UpdAcct.tAccount.locate('Code','05',SearchOptions) then
                             begin
                                  cAcctCode := UpdAcct.tAccount.fieldbyname('accountcode').asstring;
                                  UpdAcct.tAcctDet.Append;
                                  UPdAcct.tAcctDet.fieldbyname('recno').asfloat     := UpdAcct.tAcctDet.recordcount;
                                  UpdAcct.tAcctDet.Fieldbyname('CVNO').asstring     := BrowVoucher.tPaymenthd.fieldbyname('cvno').asstring;
                                  UpdAcct.tAcctDet.fieldbyname('sourcecode').asstring:= 'CV';
                                  UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := cAcctCode;
                                  UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat    := (nVatAmt*0.05)*-1;
                                  UpdAcct.tAcctDet.Post;
                             end
                   end;
         end
    else {non vat, zero rated, normal}
         begin
              {05 - EWT}
              if BrowVoucher.tPaymenthd.fieldbyname('ewt').asBoolean = true then
                   begin
                        UpdAcct.tAccount.first;
                        if UpdAcct.tAccount.locate('Code','05',SearchOptions) then
                             begin
                                  cAcctCode := UpdAcct.tAccount.fieldbyname('AccountCode').asstring;
                                  UpdAcct.tAcctDet.Append;
                                  UpdAcct.tAcctdet.fieldbyname('recno').asfloat     := UpdAcct.tAcctDet.recordcount;
                                  UpdAcct.tAcctDet.Fieldbyname('CVNO').asstring     := BrowVoucher.tPaymenthd.fieldbyname('cvno').asstring;
                                  UpdAcct.tAcctDet.fieldbyname('sourcecode').asstring:= 'CV';
                                  UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := cAcctCode;
                                  UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat    := (nNoVatAmt*0.05)*-1;
                                  UpdAcct.tAcctDet.Post;
                             end
                   end
         end;
    {03 - Account Payable}
    UpdAcct.tAccount.first;
    if UpdAcct.tAccount.locate('Code','03',SearchOptions) then
         begin
              cAcctCode := UpdAcct.tAccount.fieldbyname('AccountCode').asstring;
              UpdAcct.tAcctDet.Append;
              UpdAcct.tAcctDet.FieldByName('recno').asfloat     := UpdAcct.tAcctDet.recordcount;
              UpdAcct.tAcctDet.Fieldbyname('CVNO').asstring     := BrowVoucher.tPaymenthd.fieldbyname('cvno').asstring;
              UpdAcct.tAcctDet.fieldbyname('sourcecode').asstring:= 'CV';
              UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := cAcctCode;
              UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat    := (BrowVoucher.tPaymentHD.fieldbyname('amount').asFloat)*-1;
              UpdAcct.tAcctDet.Post;
         end;

    {02-Vat Clearing}
    if (BrowVoucher.tpaymenthd.fieldbyname('supplier').asboolean = false) and
       (BrowVoucher.tPaymenthd.fieldbyname('Trantype').asInteger > 0) then
    begin
         if UpdAcct.tAccount.locate('Code','02',SearchOptions) then
         begin
              cAcctCode := UpdAcct.tAccount.fieldbyname('accountcode').asstring;
              UpdAcct.tAcctDet.Append;
              UpdAcct.tAcctDet.fieldbyname('recno').asfloat     := UpdAcct.tAcctDet.recordcount;
              UpdAcct.tAcctDet.Fieldbyname('CVNO').asstring     := BrowVoucher.tPaymenthd.fieldbyname('cvno').asstring;
              UpdAcct.tAcctDet.fieldbyname('sourcecode').asstring:= 'CV';
              UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := cAcctCode;
              if BrowVoucher.tPaymentHD.fieldbyname('Vat').asBoolean = true then
                   begin
                        UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat  := nVatAmt*-1;
                   end
              else
                   begin
                        UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat  := nNoVatAmt*-1;
                   end;
              UpdAcct.tAcctDet.Post;
         end;
    end;

    {03 - Account Payable}
    {
    BrowVoucher.tAccount.first;
    if BrowVoucher.tAccount.locate('Code','03',SearchOptions) then
         begin
              cAcctCode := BrowVoucher.tAccount.fieldbyname('AccountCode').asstring;
              BrowVoucher.tAcctDet.Append;
              BrowVoucher.tAcctDet.Fieldbyname('CVNO').asstring     := BrowVoucher.tPaymenthd.fieldbyname('cvno').asstring;
              BrowVoucher.tAcctDet.Fieldbyname('AcctCode').asString := cAcctCode;
              BrowVoucher.tAcctDet.Fieldbyname('Amount').asFloat    := (BrowVoucher.tPaymentHD.fieldbyname('amount').asFloat)*-1;
              BrowVoucher.tAcctDet.Post;
         end;}

    {03 - Account Payable}
    UpdAcct.tAccount.first;
    if UpdAcct.tAccount.locate('Code','03',SearchOptions) then
         begin
              cAcctCode := UpdAcct.tAccount.fieldbyname('AccountCode').asstring;
              UpdAcct.tAcctDet.Append;
              UpdAcct.tAcctDet.fieldbyname('recno').asfloat     := UpdAcct.tAcctdet.recordcount;
              UpdAcct.tAcctDet.Fieldbyname('CVNO').asstring     := BrowVoucher.tPaymenthd.fieldbyname('cvno').asstring;
              UpdAcct.tAcctDet.fieldbyname('sourcecode').asstring:= 'CV';
              UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := cAcctCode;
              UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat    := (BrowVoucher.tPaymentHD.fieldbyname('amount').asFloat);
              UpdAcct.tAcctDet.Post;
         end;

    {02-Cash in bank}
    if UpdAcct.tAccount.locate('Code','04',SearchOptions) then
         begin
              cAcctCode := UpdAcct.tAccount.fieldbyname('accountcode').asstring;
              UpdAcct.tAcctDet.Append;
              UPdAcct.tAcctDet.fieldbyname('recno').asfloat     := UpdAcct.tAcctDet.recordcount;
              UpdAcct.tAcctDet.Fieldbyname('CVNO').asstring     := BrowVoucher.tPaymenthd.fieldbyname('cvno').asstring;
              UpdAcct.tAcctDet.fieldbyname('sourcecode').asstring:= 'CV';
              UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := cAcctCode;
              UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat    := (BrowVoucher.tPaymentHD.fieldbyname('amount').asFloat)*-1;
              UpdAcct.tAcctDet.Post;
         end;


end;

procedure TAcctDet.SearchAcct(Sender: TObject);
begin
    begin
    MainForm.tReusable1.close;
    MainForm.tReusable1.DatabaseName := 'AccountData';
    MainForm.tReusable1.tablename := 'Account.db';
    MainForm.DataSource1.DataSet := Mainform.tReusable1;
    MainForm.treusable1.Open;

    rSelect.Caption := 'Select Account';
    rSelect.dbNavigator1.DataSource := MainForm.DataSource1;
    rSelect.DBGrid1.DataSource := MainForm.DataSource1;
    rSelect.dbGrid1.Columns.State := csDefault;
    rSelect.dbGrid1.Columns.add;
    rSelect.dbGrid1.Columns[0].FieldName := 'AccountCode';
    rSelect.dbGrid1.Columns[0].Title.Caption:='Account Code';
    rSelect.dbGrid1.Columns.add;
    rSelect.dbGrid1.Columns[1].FieldName := 'AccountName';
    rSelect.dbGrid1.Columns[1].Title.Caption:='Account Name';
    rSelect.Showmodal;
    try
      if rSelect.Modalresult=mrOk then
         begin
            UpdAcct.tAcctDet.fieldbyname('Acctcode').asString :=
                  Mainform.tReusable1.fieldbyname('Accountcode').asString;
         end
   except
      ShowMessage('Operation not supported.');
   end;

   {rSelect.dbGrid1.Columns.RestoreDefaults;}
   MainForm.tReusable1.Filtered := false;
   Mainform.tReusable1.Filter := '';
   MainForm.tReusable1.close;
   MainForm.tReusable1.DatabaseName := '';
   MainForm.tReusable1.tablename := '';

end;


end;

procedure TAcctDet.DelAcct(Sender: TObject);
begin
    if UpdAcct.dsAcctDet.dataset.recordcount = 0 then
        ShowMessage('Operation not supported.')
    else
         if MessageDlg('Delete current record ?',mtconfirmation,[mbYes,mbNo],0) = mrYes then
              UpdAcct.tAcctDet.Delete;

end;

procedure TAcctDet.EditAcct(Sender: TObject);
begin
    btnAdd.Enabled      := false;
    btnEdit.Enabled     := false;
    btnDelete.Enabled   := false;
    btnClose.Enabled    := false;

    btnOk.Enabled       := true;
    btnCancel.Enabled   := true;

    if BrowVoucher.tPaymentHd.fieldbyname('Dept').asBoolean = true then
         begin
              dbeDeptCode.Enabled := true;
              dbePercent.Enabled  := true;
         end;
    dbeAcctCode.Enabled := true;
    UpdAcct.tAcctDet.Edit ;
end;

procedure TAcctDet.CheckDept(Sender: TObject);
var SearchOptions : tLocateOptions;
begin
    if not UpdAcct.tAcctDetDeptCode.isNull  then
    begin
         UpdAcct.tAccount.first;
         if not UpdAcct.tDepartment.locate('DeptCode',UpdAcct.tAcctDet.fieldbyname('DeptCode').asstring,SearchOptions) then
              ShowMessage('Department Code not found...');
    end;
end;

end.
