unit UpdInvoice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons, Db, DBTables;

type
  TUpdSI = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    dbeSaleInv: TDBEdit;
    dbeSuppCode: TDBEdit;
    dbeSIDate: TDBEdit;
    dbeGrossAmt: TDBEdit;
    Label7: TLabel;
    sBtnSearch1: TSpeedButton;
    dbtSuppName: TDBText;
    Button1: TButton;
    Button2: TButton;
    Label8: TLabel;
    dbePurchNo: TDBEdit;
    dblcTermCode: TDBLookupComboBox;
    dsTerm: TDataSource;
    dbtTermName: TDBText;
    dbtDays: TDBText;
    dbeAmtPaid: TDBText;
    dbeBalance: TDBText;
    Label9: TLabel;
    Label10: TLabel;
    dbeDueDate: TDBEdit;
    Label11: TLabel;
    rgTranTYpe: TRadioGroup;
    Label12: TLabel;
    dbeAPNo: TDBEdit;
    dbeRemark: TDBEdit;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SearchSupp(Sender: TObject);
    procedure ChkSupp(Sender: TObject);
    procedure FuncDuedate(Sender: TObject);
    procedure TranTypeFunc(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdSI: TUpdSI;

implementation

Uses BrowSI, mainmenu, tselect, UpdAccount, BrowPayment;

{$R *.DFM}

procedure TUpdSI.FormActivate(Sender: TObject);
begin
     dbeSaleInv.SetFocus;
     sBtnSearch1.enabled := true;
end;

procedure TUpdSI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if Modalresult=mrOk then
       begin
            BrowInvoice.tPurchhd.fieldbyname('Balance').value :=
                   BrowInvoice.tPurchHd.fieldbyname('GrossAmt').value;
            BrowInvoice.tPurchHd.post;
            {
            if rgTranType.ItemIndex = 1 then
                   BrowInvoice.tPurchhd.fieldbyname('vat').asBoolean := true;}
       end
    else
       BrowInvoice.tPurchHd.Cancel;
end;

procedure TUpdSI.SearchSupp(Sender: TObject);
begin
   MainForm.tReusable1.close;
   MainForm.tReusable1.DatabaseName := 'AccountData';
   MainForm.tReusable1.tablename := 'Supplier.db';
   MainForm.DataSource1.DataSet := Mainform.tReusable1;
   MainForm.tReusable1.Open;

   rSelect.Caption := 'Select Supplier';
   rSelect.dbNavigator1.DataSource := MainForm.DataSource1;
   rSelect.DBGrid1.DataSource := MainForm.DataSource1;
   rSelect.dbGrid1.Columns.add;
   rSelect.dbGrid1.Columns[0].FieldName := 'SuppCode';
   rSelect.dbGrid1.Columns[0].Title.Caption:='Supplier Code';
   rSelect.dbGrid1.Columns.add;
   rSelect.dbGrid1.Columns[1].FieldName := 'SuppName';
   rSelect.dbGrid1.Columns[1].Title.Caption:='Supplier Name';
   rSelect.Showmodal;
   if rSelect.Modalresult=mrOk then
       begin
            BrowInvoice.tPurchHd.fieldbyname('suppcode').asString :=
                  Mainform.tReusable1.fieldbyname('suppcode').asString;
       end;

end;

procedure TUpdSI.ChkSupp(Sender: TObject);
var SearchOptions : tLocateOptions;
begin
    BrowInvoice.tSupplier.first;
    if not BrowInvoice.tSupplier.Locate('suppcode',BrowInvoice.tPurchhd.fieldbyname('suppcode').asstring,SearchOptions) then
         ShowMessage('Supplier code not found...');
end;

procedure TUpdSI.FuncDuedate(Sender: TObject);
begin
     BrowInvoice.tPurchhd.fieldbyname('duedate').asdatetime := BrowInvoice.tpurchhd.fieldbyname('sidate').asdatetime +
              BrowInvoice.tTerm.fieldbyname('days').asinteger;
end;


procedure TUpdSI.TranTypeFunc(Sender: TObject);
begin
    BrowInvoice.tPurchhd.fieldbyname('TranType').asInteger := rgTranType.itemindex;
end;

end.
