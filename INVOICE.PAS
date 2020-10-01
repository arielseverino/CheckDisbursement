unit Invoice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, StdCtrls, ExtCtrls, DBCtrls;

type
  TBrowInvoice = class(TForm)
    Bevel1: TBevel;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DBGrid1: TDBGrid;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BrowInvoice: TBrowInvoice;

implementation

{$R *.DFM}

end.
