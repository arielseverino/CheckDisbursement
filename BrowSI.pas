unit BrowSI;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, StdCtrls, ExtCtrls, DBCtrls, jpeg, Buttons;

type
  TBrowInvoice = class(TForm)
    dsPurchHd: TDataSource;
    tPurchHd: TTable;
    tPurchHdSaleInv: TStringField;
    tPurchHdPurchNo: TStringField;
    tPurchHdSIDate: TDateField;
    tPurchHdSuppCode: TStringField;
    tPurchHdTermCode: TStringField;
    tPurchHdGrossAmt: TFloatField;
    tPurchHdBalance: TFloatField;
    tPurchHdAmtPaid: TFloatField;
    tSupplier: TTable;
    tPurchHdSuppName: TStringField;
    tTerm: TTable;
    tTermTermCode: TStringField;
    tTermTermName: TStringField;
    tTermDays: TFloatField;
    tPurchHdDueDate: TDateField;
    pnlHeader2: TPanel;
    Label2: TLabel;
    tPurchHdTranType: TFloatField;
    tPurchHdAPNo: TStringField;
    tPurchHdDescription: TMemoField;
    tPurchHdRemark: TStringField;
    pnlHeader: TPanel;
    Image1: TImage;
    Label3: TLabel;
    pnlHeader1: TPanel;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    Edit1: TEdit;
    Bevel1: TBevel;
    pnlDet1: TPanel;
    DBGrid1: TDBGrid;
    pnlDet2: TPanel;
    DBGrid2: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    procedure AddInvoice(Sender: TObject);
    procedure EditInvoice(Sender: TObject);
    procedure DeleteInvoice(Sender: TObject);
    procedure SearchKey(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AddAcctDet(Sender: TObject);
    procedure EditAcctDet(Sender: TObject);
    procedure DelAcctDet(Sender: TObject);
    procedure Refresh(Column: TColumn);
    procedure Refresh1(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BrowInvoice: TBrowInvoice;

implementation

uses UpdInvoice, UpdAccount, mainmenu, cvFunc;

{$R *.DFM}

procedure TBrowInvoice.AddInvoice(Sender: TObject);
var nVatAmt, nNoVatAmt, nVPAmt : real;
    SearchOptions : tLocateOptions;
    cAcctCode      : String;
begin

    mainform.tcompany.active := true;
    tPurchHd.Append;
    tPurchhd.fieldbyname('apno').asstring := PadLZero(mainform.tCompany.Fieldbyname('APCtr').asInteger,6);
    mainform.tCompany.active := false;
    UpdSI.rgTranType.itemindex := 0;
    UpdSI.Caption := 'New Sales Invoice';
    UpdSI.ShowModal;
    if (updsi.modalresult = mrOk) then
    begin
         mainform.tCompany.Active := true;
         mainform.tcompany.edit;
         mainform.tcompany.fieldbyname('APctr').asinteger := tPurchHd.fieldbyname('APNo').asinteger + 1;
         mainform.tcompany.post;
         mainform.tcompany.Active := false;

         UpdAcct.tAcctDet.Filtered := true;
         UpdAcct.tAcctDet.Filter := 'CVNo = ''' + tPurchhd.fieldbyname('SaleInv').asstring+''' and sourcecode = ' + '''AP''';
         UpdAcct.tAcctDet.Edit;

         {Vat}
         if tPurchhd.fieldbyname('trantype').asInteger = 1 then
              begin
                   nVatAmt := tPurchhd.fieldbyname('grossamt').asfloat;
                   nVPAmt  := (nVatAmt*10)/11;
              end
         else
              {Non vat & Zero Rated}
              if tPurchhd.fieldbyname('trantype').asInteger > 1 then
                   begin
                        nNoVatAmt := tPurchhd.fieldbyname('grossamt').asfloat;
                        nVPAmt    := nNoVatAmt;
                   end;

         if tPurchhd.fieldbyname('trantype').asInteger > 0 then
              begin
                   UpdAcct.tAcctDet.Append;
                   UpdAcct.tAcctDet.FieldByName('CVNo').asString      := tPurchhd.Fieldbyname('SaleInv').asString;
                   UpdAcct.tAcctDet.Fieldbyname('SourceCode').asstring:= 'AP';

                   {Vat}
                   if tPurchHd.fieldbyname('TranType').asInteger = 1 then
                        begin
                             UpdAcct.tAccount.first;
                             if UpdAcct.tAccount.locate('Code','06',SearchOptions) then
                                  begin
                                       UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := UpdAcct.tAccount.Fieldbyname('AccountCode').asString;
                                       UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat    := nVatAmt ;
                                  end
                        end
                   else {Non Vat}
                        if tPurchhd.fieldbyname('TranType').asInteger = 2  then
                             begin
                                  UpdAcct.tAccount.first;
                                  if UpdAcct.tAccount.locate('Code','01',SearchOptions) then
                                       begin
                                            UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := UpdAcct.tAccount.Fieldbyname('AccountCode').asString;
                                            UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat    := nNoVatAmt;
                                       end
                             end
                        else {zero rated}
                             if tPurchhd.fieldbyname('trantype').asinteger = 3 then
                                  begin
                                       UpdAcct.tAccount.first;
                                       if UpdAcct.tAccount.locate('Code','08',SearchOptions) then
                                            begin
                                                 UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := UpdAcct.tAccount.Fieldbyname('AccountCode').asString;
                                                 UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat    := nNoVatAmt;
                                            end;
                                  end;
                   UpdAcct.tAcctDet.Post;
              end;

         {Vat Input Tax}
         if tPurchhd.fieldbyname('trantype').asInteger = 1 then
              begin
                   UpdAcct.tAccount.first;
                   if UpdAcct.tAccount.locate('Code','07',SearchOptions) then
                        begin
                             cAcctCode := UpdAcct.tAccount.fieldbyname('AccountCode').asstring;
                             UpdAcct.tAcctDet.Append;
                             UpdAcct.tAcctDet.Fieldbyname('CVno').asstring     := tPurchhd.fieldbyname('saleinv').asstring;
                             UpdAcct.tAcctDet.fieldbyname('sourcecode').asstring:= 'AP';
                             UpdAcct.tAcctDet.Fieldbyname('AcctCode').asString := cAcctCode;
                             UpdAcct.tAcctDet.Fieldbyname('Amount').asFloat    := nVPAmt*0.10 ;
                             UpdAcct.tAcctDet.Post;
                        end;
              end;
    end;
end;

procedure TBrowInvoice.EditInvoice(Sender: TObject);
begin
     if dsPurchHd.dataset.RecordCount = 0 then
        ShowMessage('Operation not supported.')
     else
        begin
             tPurchHd.Edit;
             UpdSI.Caption := 'Edit Sales Invoice';
             UpdSI.dbeSaleInv.readonly := true;
             if tPurchHd.FieldbyName('Amtpaid').value <> 0 then
                 UpdSI.dbeSaleInv.Readonly := true;
             UpdSI.ShowModal;
             UpdSI.dbeSaleInv.ReadOnly := false;
             UpdSi.dbeGrossAmt.ReadOnly := false;
        end;
end;

procedure TBrowInvoice.DeleteInvoice(Sender: TObject);
begin
     if dsPurchHd.dataset.recordcount = 0 then
        ShowMessage('Operation not supported.')
     else
        if tPurchhd.fieldbyname('AmtPaid').asFloat <> 0 then
              ShowMessage('This Sales Invoice has already payment, cannot be deleted.')
        else
              if MessageDlg('Delete current record ?',mtconfirmation,[mbYes,mbNo],0) = mrYes then
                   tPurchHD.Delete;
end;

procedure TBrowInvoice.SearchKey(Sender: TObject);
begin
     if (Edit1.text <> '') then
        tPurchHd.FindNearest([Edit1.text]);
end;

procedure TBrowInvoice.FormActivate(Sender: TObject);
begin
     tPurchHd.Active  := true;
     tPurchhd.last;

     tSupplier.Active := true;
     tTerm.Active     := true;

     UpdAcct.tAccount.Active  := true;
     UpdAcct.tAcctDet.Active  := true;
     UpdAcct.tDepartment.active:= true;

     UpdAcct.tAcctDet.Filtered := true;
     UpdAcct.tAcctDet.Filter := 'CVNo = ''' + tPurchhd.fieldbyname('SaleInv').asstring+''' and sourcecode = ' + '''AP''';

end;

procedure TBrowInvoice.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     tPurchhd.Active  := false;
     tSupplier.Active := false;
     tTerm.Active     := false;

     UpdAcct.tAccount.Active  := false;
     UpdAcct.tAcctDet.Active  := false;
     UpdAcct.tDepartment.active:= false;
end;

procedure TBrowInvoice.AddAcctDet(Sender: TObject);
begin
    UpdAcct.tAcctDet.Append;
    UpdAcct.tAcctdet.FieldByName('recno').asfloat  := UpdAcct.tAcctdet.recordcount;
    UpdAcct.tAcctDet.FieldByName('CVNo').asString := tPurchhd.fieldbyname('saleinv').asstring;
    UpdAcct.tAcctDet.Fieldbyname('sourcecode').asstring := 'AP';
    UpdAcct.Caption := 'Account Distribution';
    UpdAcct.ShowModal;
end;

procedure TBrowInvoice.EditAcctDet(Sender: TObject);
begin
    UpdAcct.tAcctDet.Edit;
    UpdAcct.Caption := 'Account Distribution';
    UpdAcct.ShowModal;
end;

procedure TBrowInvoice.DelAcctDet(Sender: TObject);
begin
        if UpdAcct.dsAcctDet.dataset.recordcount = 0 then
        ShowMessage('Operation not supported.')
    else
         if MessageDlg('Delete current record ?',mtconfirmation,[mbYes,mbNo],0) = mrYes then
              UpdAcct.tAcctDet.Delete;
end;

procedure TBrowInvoice.Refresh(Column: TColumn);
begin
    UpdAcct.tAcctDet.Filtered := true;
    UpdAcct.tAcctDet.Filter := 'CVNo = ''' + tPurchhd.fieldbyname('SaleInv').asstring+''' and sourcecode = ' + '''AP''';
end;

procedure TBrowInvoice.Refresh1(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    UpdAcct.tAcctDet.Filtered := true;
    UpdAcct.tAcctDet.Filter := 'CVNo = ''' + tPurchhd.fieldbyname('SaleInv').asstring+''' and sourcecode = ' + '''AP''';
end;

end.




