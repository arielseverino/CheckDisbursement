unit browcheck;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, StdCtrls;

type
  TBrowChk = class(TForm)
    tCheck: TTable;
    dsCheck: TDataSource;
    DBGrid1: TDBGrid;
    tCheckCheckno: TStringField;
    tCheckBankcode: TStringField;
    tCheckCvno: TStringField;
    tCheckPayeename: TStringField;
    tCheckAmount: TFloatField;
    tCheckCheckdate: TDateField;
    tCheckbankname: TStringField;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormActive(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AddCheck(Sender: TObject);
    procedure EditCheck(Sender: TObject);
    procedure DelCheck(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BrowChk: TBrowChk;

implementation

Uses BrmFile, checkform;

{$R *.DFM}

procedure TBrowChk.FormActive(Sender: TObject);
begin
    BrowFormMFiles := tBrowFormMFiles.create(application);
    BrowFormMFiles.tBank.open;
    tCheck.open;
    BrowFormMFiles.dsReference.dataset := BrowFormMFiles.tbank;
end;

procedure TBrowChk.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    BrowFormMFiles.tbank.close;
    tCheck.close;
    BrowFormMFiles.free;
end;

procedure TBrowChk.AddCheck(Sender: TObject);
begin
    tCheck.append;
    ChkForm.showmodal;
    if chkForm.ModalResult = mrOk then
         begin
              tcheck.post;
              BrowFormMFiles.tBank.edit;
              BrowFormMFiles.tbank.fieldbyname('chkctr').asinteger:= tCheck.fieldbyname('checkno').asinteger +1;
              BrowFormMFiles.tBank.post;
         end
    else
         tCheck.cancel;
end;

procedure TBrowChk.EditCheck(Sender: TObject);
begin
    chkform.caption := 'Edit Cancelled Check';
    chkform.dblcbankcode.readonly := true;
    chkform.dbeCheckno.readonly := true;
    chkform.showmodal;
    chkform.dblcbankcode.readonly := false;
    chkform.dbeCheckno.readonly := false;
    if chkform.modalresult=mrOk then
         tcheck.post
    else
         tcheck.cancel;
end;

procedure TBrowChk.DelCheck(Sender: TObject);
begin
    if dsCheck.dataset.recordcount = 0 then
        ShowMessage('Operation not supported.')
    else
         if MessageDlg('Delete current record ?',mtconfirmation,[mbYes,mbNo],0) = mrYes then
              tCheck.Delete;
end;

end.
