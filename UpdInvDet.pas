unit UpdInvDet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Mask, ExtCtrls, Grids, DBGrids, Buttons, Db, DBTables;

type
  TInvDet = class(TForm)
    DBGrid1: TDBGrid;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeSalesInv: TDBEdit;
    dbeAmount: TDBEdit;
    btnAdd: TButton;
    btnEdit: TButton;
    tPaymentDet: TTable;
    dsPaymentDet: TDataSource;
    sbInvoice: TSpeedButton;
    btnDelete: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    btnClose: TButton;
    tPurchhd: TTable;
    tPaymentDetCVNO: TStringField;
    tPaymentDetSALEINV: TStringField;
    tPaymentDetAMOUNT: TFloatField;
    tPaymentDetBalance: TFloatField;
    DBEdit1: TDBEdit;
    tPurchhdSaleInv: TStringField;
    tPurchhdPurchNo: TStringField;
    tPurchhdSIDate: TDateField;
    tPurchhdSuppCode: TStringField;
    tPurchhdTermCode: TStringField;
    tPurchhdGrossAmt: TFloatField;
    tPurchhdBalance: TFloatField;
    tPurchhdAmtPaid: TFloatField;
    tPurchhdDescription: TMemoField;
    tPurchhdDueDate: TDateField;
    tPurchhdTranType: TFloatField;
    procedure FormActivate(Sender: TObject);
    procedure AddInv(Sender: TObject);
    procedure InvOk(Sender: TObject);
    procedure CancelInv(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure LookInv(Sender: TObject);
    procedure DeleteInv(Sender: TObject);
    procedure EditInv(Sender: TObject);
    procedure SearchInv(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InvDet: TInvDet;
  nOldAmt: real;

implementation

uses BrowPayment, mainmenu, tselect;

{$R *.DFM}

procedure TInvDet.FormActivate(Sender: TObject);
begin
     tPaymentDet.Active := true;
     tPurchHd.Active := true;

     tPaymentDet.Filtered := true;
     tPaymentDet.Filter := 'CVNo = ''' + BrowVoucher.tPaymenthd.fieldbyname('CVNo').asstring+'''';

     if (browvoucher.tpaymenthd.fieldbyname('approved').asboolean = true) and
        (mainform.tcompany.fieldbyname('userlevel').asinteger > 0 ) then
         begin
              btnadd.enabled := false;
              btnedit.enabled := false;
         end
     else
         begin
              btnadd.enabled := true;
              btnedit.enabled := true;
         end;
end;

procedure TInvDet.AddInv(Sender: TObject);
begin
     dbeSalesInv.Enabled := true;
     dbeAmount.Enabled   := true;
     sbInvoice.Enabled   := true;

     btnOk.Enabled       := true;
     btnCancel.Enabled   := true;
     btnAdd.Enabled      := false;
     btnEdit.Enabled     := false;
     btnDelete.Enabled   := false;
     btnClose.Enabled    := false;

     tPaymentDet.Append;
     tPaymentDet.FieldByName('CVNo').asstring := BrowVoucher.tPaymenthd.fieldbyname('CVNo').asstring;
end;

procedure TInvDet.InvOk(Sender: TObject);
begin

     tPaymentDet.Post;

     tPurchHd.Edit;
     tPurchhd.FieldByName('Balance').asFloat := tPurchhd.fieldbyname('Balance').asFloat - tPaymentDet.Fieldbyname('amount').asFloat + nOldAmt ;
     tPurchhd.fieldbyname('AmtPaid').asFloat := tPurchhd.fieldbyname('AmtPaid').asFloat + tPaymentDet.Fieldbyname('amount').asfloat - nOldAmt ;
     tPurchhd.post;

     BrowVoucher.tPaymentHd.Edit;
     BrowVoucher.tPaymenthd.Fieldbyname('Amount').asfloat := BrowVoucher.tPaymenthd.fieldbyname('amount').asfloat + tPaymentdet.fieldbyname('amount').asfloat - nOldAmt ;
     BrowVoucher.tPaymenthd.post;

     dbeSalesInv.Enabled:= false;
     dbeAmount.Enabled  := false;
     sbInvoice.Enabled  := false;
     btnOk.Enabled      := false;
     btnCancel.Enabled  := false;

     btnAdd.Enabled     := true;
     btnEdit.Enabled    := true;
     btnDelete.Enabled  := true;
     btnClose.Enabled   := true;

end;

procedure TInvDet.CancelInv(Sender: TObject);
begin
     tPaymentDet.Cancel;
     dbeSalesInv.Enabled:= false;
     dbeAmount.Enabled  := false;
     sbInvoice.Enabled  := false;
     btnOk.Enabled      := false;
     btnCancel.Enabled  := false;

     btnAdd.Enabled     := true;
     btnEdit.Enabled    := true;
     btnDelete.Enabled  := true;
     btnClose.Enabled   := true;

     nOldAmt := 0 
end;

procedure TInvDet.FormClose(Sender: TObject);
begin
    tPaymentDet.Active := false;
    tPurchhd.Active := false;
    {modalresult := mrNone;}
    InvDet.close;
end;

procedure TInvDet.LookInv(Sender: TObject);
var SearchOptions : tLocateOptions;
begin
    tPurchhd.first;
    if not tPurchhd.locate('SaleInv',tPaymentDet.Fieldbyname('SaleInv').asString,SearchOptions) then
         begin
              tPaymentDet.Cancel;
              ShowMessage('Sales Invoice not found...');
         end
    else
         if BrowVoucher.tPaymenthd.Fieldbyname('SuppCode').asString <> tPurchhd.fieldbyname('SuppCode').asString then
              begin
                   tPaymentDet.Cancel;
                   ShowMessage('This Sales Invoice belong to another customer...')
              end
         else
              if tPurchhd.FieldByName('Balance').asFloat = 0 then
                 Begin
                      tPaymentDet.Cancel;
                      ShowMessage('This Sales Invoice is already paid...');
                 end;

end;

procedure TInvDet.DeleteInv(Sender: TObject);
var SearchOptions : tLocateOptions;
begin
    if MessageDlg('Delete current record ?',mtconfirmation,[mbYes,mbNo],0) = mrYes then
    begin
         tPurchhd.first;
         if tPurchhd.locate('SaleInv',tPaymentDet.Fieldbyname('SaleInv').asString,SearchOptions) then
         begin
              tPurchhd.edit;
              tPurchhd.Fieldbyname('Balance').asfloat := tPurchhd.fieldbyname('balance').asfloat + tPaymentDet.fieldbyname('amount').asfloat;
              tPurchhd.Fieldbyname('AmtPaid').asfloat := tPurchhd.fieldbyname('AmtPaid').asfloat - tPaymentdet.fieldbyname('amount').asfloat;
              tPurchhd.post;
              
              BrowVoucher.tPaymenthd.edit;
              BrowVoucher.tPaymenthd.Fieldbyname('Amount').asFloat  := BrowVoucher.tPaymenthd.Fieldbyname('amount').asfloat - tPaymentDet.fieldbyname('amount').asfloat;
              BrowVoucher.tPaymenthd.post;

              tPaymentDet.delete;
         end;
    end;
end;

procedure TInvDet.EditInv(Sender: TObject);
var SearchOptions : tLocateOptions;

begin

     tPurchhd.first;
     if tPurchhd.locate('SaleInv',tPaymentDet.Fieldbyname('SaleInv').asString,SearchOptions) then
         begin

              btnAdd.Enabled      := false;
              btnEdit.Enabled     := false;
              btnDelete.Enabled   := false;
              btnClose.Enabled    := false;

              dbeAmount.Enabled   := true;
              sbInvoice.Enabled   := true;

              btnOk.Enabled       := true;
              btnCancel.Enabled   := true;

              tPaymentDet.Edit;

              nOldAmt := tPaymentDet.fieldbyname('amount').asfloat;
         end
     else
         Showmessage('Sales Invoice detail not found...');
end;

procedure TInvDet.SearchInv(Sender: TObject);
begin
   MainForm.tReusable1.close;
   MainForm.tReusable1.DatabaseName := 'AccountData';
   MainForm.tReusable1.tablename := 'PurchHd.db';
   MainForm.DataSource1.DataSet := Mainform.tReusable1;
   MainForm.tReusable1.Open;

   Mainform.tReusable1.Filtered := true;
   Mainform.tReusable1.Filter := 'SuppCode = ''' + BrowVoucher.tPaymenthd.fieldbyname('SuppCode').asstring+''' and Balance > 0 ';

   rSelect.Caption := 'Select Sales Invoice';
   rSelect.dbNavigator1.DataSource := MainForm.DataSource1;
   rSelect.DBGrid1.DataSource := MainForm.DataSource1;
   rSelect.dbGrid1.Columns.add;
   rSelect.dbGrid1.Columns[0].FieldName := 'SaleInv';
   rSelect.dbGrid1.Columns[0].Title.Caption:='Sales Invoice';
   rSelect.dbGrid1.Columns.add;
   rSelect.dbGrid1.Columns[1].FieldName := 'SIDate';
   rSelect.dbGrid1.Columns[1].Title.Caption:='Invoice Date';
   rSelect.dbGrid1.Columns.add;
   rSelect.dbGrid1.Columns[2].FieldName := 'Balance';
   rSelect.dbGrid1.Columns[2].Title.Caption:='Balance';

   rSelect.Showmodal;
   try
      if rSelect.Modalresult=mrOk then
         begin
            tPaymentDet.fieldbyname('SaleInv').asString :=
                  Mainform.tReusable1.fieldbyname('SaleInv').asString;
            tPaymentDet.fieldbyname('Balance').asFloat :=
                  Mainform.tReusable1.fieldbyname('Balance').asFloat;

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

   LookInv(Sender);

end;

end.
