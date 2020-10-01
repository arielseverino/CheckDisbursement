unit UpdAccount;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, DBCtrls, ExtCtrls,Db,DBGrids, DBTables;
type
  TUpdAcct = class(TForm)
    Bevel1: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeDeptCode: TDBEdit;
    dbeAcctCode: TDBEdit;
    SpeedButton1: TSpeedButton;
    btnOk: TButton;
    btnCancel: TButton;
    dbeAmount: TDBEdit;
    dbtAcctName: TDBText;
    tAcctDet: TTable;
    tAcctDetCVNO: TStringField;
    tAcctDetACCTCODE: TStringField;
    tAcctDetAMOUNT: TFloatField;
    tAcctDetDEPTCODE: TStringField;
    tAcctDetDebit: TFloatField;
    tAcctDetCredit: TFloatField;
    tAcctDetAcctName: TStringField;
    tAcctDetPercent: TFloatField;
    tAcctDetSourceCode: TStringField;
    tAccount: TTable;
    dsAcctDet: TDataSource;
    tDepartment: TTable;
    tAcctDetRecno: TFloatField;
    procedure CloseUpdAcct(Sender: TObject);
    procedure ChkAcct(Sender: TObject);
    procedure SearchAcct(Sender: TObject);
    procedure ChkDept(Sender: TObject);
    procedure CalcField(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdAcct: TUpdAcct;

implementation

uses BrowPayment, mainmenu, tselect, BrowSI;

{$R *.DFM}


procedure TUpdAcct.CloseUpdAcct(Sender: TObject);
begin
    if Modalresult = mrOk then
         tAcctDet.post
end;


procedure TUpdAcct.ChkAcct(Sender: TObject);
var SearchOptions : tLocateOptions;
begin
     tAccount.first;
     if not tAccount.locate('AccountCode',tAcctDet.fieldbyname('AcctCode').asstring,SearchOptions) then
         ShowMessage('Account Code not found...');
end;

procedure TUpdAcct.SearchAcct(Sender: TObject);
begin
    MainForm.tReusable1.close;
    MainForm.tReusable1.DatabaseName := 'AccountData';
    MainForm.tReusable1.tablename := 'Account.db';
    MainForm.DataSource1.DataSet := Mainform.tReusable1;
    MainForm.tReusable1.Open;

    rSelect.Caption := 'Select Account';
    rSelect.dbNavigator1.DataSource := MainForm.DataSource1;
    rSelect.DBGrid1.DataSource := MainForm.DataSource1;
    {rSelect.dbGrid1.Columns.RestoreDefaults;}
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
            tAcctDet.fieldbyname('Acctcode').asString :=
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

procedure TUpdAcct.ChkDept(Sender: TObject);
var SearchOptions : tLocateOptions;
begin
     if not tAcctDetDeptCode.isNull  then
     begin
        tAccount.first;
        if not tDepartment.locate('DeptCode',tAcctDet.fieldbyname('DeptCode').asstring,SearchOptions) then
           ShowMessage('Department Code not found...');
     end;
end;

procedure TUpdAcct.CalcField(DataSet: TDataSet);
Var SearchOptions : tLocateOptions;
begin
    if tAcctDet.FieldByName('amount').asfloat > 0 then
         begin
              tAcctDet.fieldbyname('Debit').asfloat := tAcctDet.fieldbyname('Amount').asfloat;
              tAccount.first;
              if tAccount.locate('AccountCode',tAcctDet.fieldbyname('acctcode').asstring,SearchOptions) then
                   tAcctDet.fieldbyname('AcctName').asString := tAccount.fieldbyname('AccountName').asstring;
         end
    else
         if tAcctDet.Fieldbyname('amount').asfloat < 0 then
              begin
                   tAcctDet.fieldbyname('Credit').asfloat := (tAcctDet.fieldbyname('amount').asfloat)*-1;
                   tAccount.first;
                   if tAccount.locate('AccountCode',tAcctDet.fieldbyname('acctcode').asstring,SearchOptions) then
                        tAcctDet.fieldbyname('AcctName').asString := '          '+tAccount.fieldbyname('AccountName').asstring;
              end
         else
              begin
                   tAcctDet.fieldbyname('debit').asfloat  := 0.00 ;
                   tAcctDet.Fieldbyname('credit').asfloat := 0.00;
              end;

end;

end.
