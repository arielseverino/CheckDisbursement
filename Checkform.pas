unit checkform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, DBCtrls, Mask;

type
  Tchkform = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    dbeCheckno: TDBEdit;
    dblcBankCode: TDBLookupComboBox;
    dbeCvno: TDBEdit;
    dbePayeeName: TDBEdit;
    dbeAmount: TDBEdit;
    dbeCheckDate: TDBEdit;
    Label6: TLabel;
    mrOk: TButton;
    mrCancel: TButton;
    dsBank: TDataSource;
    procedure chkctr(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  chkform: Tchkform;

implementation

Uses BrowCheck,cvFunc, BrmFIle;

{$R *.DFM}


procedure Tchkform.chkctr(Sender: TObject);
begin
    browchk.tcheck.fieldbyname('checkno').asstring := padlzero(BrowFormMFiles.tBank.fieldbyname('chkctr').asinteger,6);
end;

end.
