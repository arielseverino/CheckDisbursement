unit Updtded;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, DBLookup,
  Mask, DBTables, DB, TabNotBk, Buttons, ComCtrls;

type
  TUpdTDeduction = class(TForm)
    dsTDeduction: TDataSource;
    tDeductionType: TTable;
    dsDeductionType: TDataSource;
    tEmployee: TTable;
    dsEmployee: TDataSource;
    tEmployeeEmpCode: TStringField;
    tPosition: TTable;
    dsPosition: TDataSource;
    tEmployeePosition: TStringField;
    tJobGroup: TTable;
    tJobGroupKeyField: TStringField;
    tDeductLookup: TTable;
    DataSource1: TDataSource;
    StatusBar: TStatusBar;
    ScrollBox1: TScrollBox;
    Panel1: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label4: TLabel;
    Label3: TLabel;
    sbtnSearch1: TSpeedButton;
    dbeEmpCode: TDBEdit;
    cboxDeductionType: TDBLookupComboBox;
    Label5: TLabel;
    DBText1: TDBText;
    Label7: TLabel;
    DBText2: TDBText;
    Label1: TLabel;
    DBText3: TDBText;
    dbeAmount: TDBEdit;
    Label6: TLabel;
    lAmortization: TLabel;
    dbeAmortization: TDBEdit;
    rgrpScheme: TDBRadioGroup;
    qryTotalApplied: TQuery;
    qryTotalPaid: TQuery;
    tTDeduct: TTable;
    tTDeductKeyField: TIntegerField;
    tTDeductDate: TDateField;
    tTDeductDeductionKey: TStringField;
    tTDeductAmount: TFloatField;
    tTDeductApprovedBy: TStringField;
    tTDeductDeductWhen: TStringField;
    tTDeductScheme: TStringField;
    tTDeductAmortization: TFloatField;
    tTDeductGuarantor: TStringField;
    tTDeductStatus: TStringField;
    tTDeductFullyPaid: TStringField;
    tTDeductGuarantor2: TStringField;
    tTDeductLastname: TStringField;
    tTDeductFirstname: TStringField;
    tTDeductGLastname: TStringField;
    tTDeductGFirstname: TStringField;
    tTDeductG2Lastname: TStringField;
    tTDeductG2Firstname: TStringField;
    tTDeductEmpCode: TStringField;
    tTDeductEmployerShare: TFloatField;
    GroupBox1: TGroupBox;
    chkSemiMonthly: TDBCheckBox;
    chkIncentive: TDBCheckBox;
    chkWeekly: TDBCheckBox;
    tTDeductDeductWhenPayType0: TStringField;
    tTDeductDeductWhenPayType1: TStringField;
    tTDeductDeductWhenPayType2: TStringField;
    tTDeductDeductWhenPayType3: TStringField;
    tTDeductDeductWhenPayType4: TStringField;
    chk13thMthPay: TDBCheckBox;
    tTDeductLoanamt: TFloatField;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure dbeEmpCodeEnter(Sender: TObject);
    procedure dbeEmpCodeExit(Sender: TObject);
    procedure sbtnSearch1Click(Sender: TObject);
    procedure cboxDeductionTypeExit(Sender: TObject);
    procedure qryTotalAppliedAfterOpen(DataSet: TDataSet);
    procedure qryTotalPaidAfterOpen(DataSet: TDataSet);
    procedure rgrpSchemeClick(Sender: TObject);
    procedure dbeAmortizationExit(Sender: TObject);
    procedure dbeAmountExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdTDeduction: TUpdTDeduction;
  Balance: Real;

procedure GetStatBarInfo;

implementation

{uses Main, Select, Dlgappr, Brmfile;}
uses Select, pSelect, BrowSI, mainmenu, tselect;

{$R *.DFM}

procedure GetStatBarInfo;
begin
  UpdTDeduction.qryTotalApplied.Close;
  UpdTDeduction.qryTotalApplied.databaseName := 'Payroll';
  UpdTDeduction.qryTotalApplied.sql.clear;

  UpdTDeduction.qryTotalPaid.Close;
  UpdTDeduction.qryTotalPaid.databaseName := 'Payroll';
  UpdTDeduction.qryTotalPaid.sql.clear;

      UpdTDeduction.qryTotalApplied.sql.add( 'Select Sum(b."Amount") ' +
        'From DEDUCT a, TDEDUCT b Where (a."KeyField" = b."DeductionKey") ' +
        'and (b."FullyPaid" = "N") and (b."EmpCode" = "' +
        UpdTDeduction.tTDeductEmpCode.asString + '") ' +
        'and (a."KeyField" = "' + UpdTDeduction.tTDeductDeductionKey.asString + '") ' );
      if UpdTDeduction.tTDeduct.state in [dsEdit] then
        UpdTDeduction.qryTotalApplied.sql.add( 'and not (b."KeyField" = ' +
          UpdTDeduction.tTDeductKeyField.asString + ') ' );

      UpdTDeduction.qryTotalPaid.sql.add( 'Select SUM(a."Amount") ' +
        'From PAYREGD a, DEDUCT b, TDEDUCT c Where (c."KeyField" = a."TDeductionKey") ' +
        'and (c."DeductionKey" = b."KeyField") and (c."FullyPaid" = "N") ' +
        'and (a."EmpCode" = "' + UpdTDeduction.tTDeductEmpCode.asString + '") ' +
        'and (b."KeyField" = "' + UpdTDeduction.tTDeductDeductionKey.asString + '") ' );

  UpdTDeduction.qryTotalApplied.Open;
  UpdTDeduction.qryTotalPaid.Open;

  UpdTDeduction.StatusBar.Panels[1].text := 'Balance: ' +
    FormatFloat( '#,##0.00',UpdTDeduction.qryTotalApplied.FieldByName('SUM Of Amount').AsFloat -
    UpdTDeduction.qryTotalPaid.FieldByName('SUM Of Amount').AsFloat );
  Balance := UpdTDeduction.qryTotalApplied.FieldByName('SUM Of Amount').AsFloat -
    UpdTDeduction.qryTotalPaid.FieldByName('SUM Of Amount').AsFloat;

  UpdTDeduction.qryTotalApplied.Close;
  UpdTDeduction.qryTotalApplied.sql.clear;
  UpdTDeduction.qryTotalApplied.sql.add( 'Select Sum( b."Amount" ) ' +
    'From DEDUCT a, TDEDUCT b Where (a."KeyField" = b."DeductionKey") ' +
    'and (b."FullyPaid" = "N") and (a."KeyField" = "' +
    UpdTDeduction.tTDeductDeductionKey.asString + '") ' );
  UpdTDeduction.qryTotalApplied.Open;

  UpdTDeduction.qryTotalPaid.Close;
  UpdTDeduction.qryTotalPaid.sql.clear;
  UpdTDeduction.qryTotalPaid.sql.add( 'Select  SUM(a."Amount") ' +
    'From PAYREGD a, DEDUCT b, TDEDUCT c Where (c."KeyField" = a."TDeductionKey") ' +
    'and (c."DeductionKey" = b."KeyField") and (c."FullyPaid" = "N") ' +
    'and (b."KeyField" = "' + UpdTDeduction.tTDeductDeductionKey.asString + '") ' );
  UpdTDeduction.qryTotalPaid.Open;

  UpdTDeduction.StatusBar.Panels[2].text := 'Overall Balance: ' +
    FormatFloat( '#,##0.00',UpdTDeduction.qryTotalApplied.FieldByName('SUM Of Amount').AsFloat -
    UpdTDeduction.qryTotalPaid.FieldByName('SUM Of Amount').AsFloat );

  UpdTDeduction.qryTotalApplied.Close;
  UpdTDeduction.qryTotalPaid.close;

end;

procedure TUpdTDeduction.FormActivate(Sender: TObject);
begin
  dbeEmpCode.setFocus;
  sbtnSearch1.enabled := true;

  if rgrpScheme.itemIndex = 2 then
    begin
      lAmortization.enabled := true;
      dbeAmortization.enabled := true;
    end
  else
    begin
      lAmortization.enabled := false;
      dbeAmortization.enabled := false;
    end;

  if tTDeductStatus.asString = 'P' then
    begin
      dbeEmpCode.readOnly := true;
      cboxDeductionType.readOnly := true;
      dbeAmount.enabled := false;
      rgrpScheme.readOnly := true;
    end
  else
    begin
      dbeEmpCode.readOnly := false;
      cboxDeductionType.readOnly := false;
      dbeAmount.enabled := true;
      rgrpScheme.readOnly := false;
    end;

  tDeductLookup.Open;
  tDeductionType.Open;
  tPosition.Open;
  tJobGroup.Open;
  tEmployee.Open;
  tEmployee.First;

  if tTDeduct.state = dsInsert then
    begin
      UpdTDeduction.StatusBar.Panels[0].text := '';
      UpdTDeduction.StatusBar.Panels[1].text := '';
      UpdTDeduction.StatusBar.Panels[2].text := '';
    end
  else if tTDeduct.state = dsEdit then
    GetStatBarInfo;
end;

procedure TUpdTDeduction.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrOk then
    begin
      if tTDeduct.state = dsInsert then
        begin
          {
          MainForm.tReusable1.Close;
          MainForm.tReusable1.DatabaseName := 'Payroll';
          MainForm.tReusable1.TableName := 'CONTROL';
          MainForm.tReusable1.Open;
          tTDeductKeyField.Value :=
            MainForm.tReusable1.FieldByName('Deduction').AsInteger;
          if tTDeductScheme.value = '2' then
             tTDeductLoanAmt.value := tTDeductAmount.value;
          tTDeduct.Post;

          MainForm.tReusable1.Edit;
          MainForm.tReusable1.FieldByName('Deduction').AsInteger :=
            MainForm.tReusable1.FieldByName('Deduction').AsInteger + 1;
          MainForm.tReusable1.Post;

          MainForm.tReusable1.Close;
          MainForm.tReusable1.DatabaseName := '';
          MainForm.tReusable1.TableName := '';}
        end
      else if tTDeduct.state = dsEdit then
        tTDeduct.Post;
    end
  else
    tTDeduct.Cancel;

  tEmployee.Close;
  tPosition.Close;
  tJobGroup.Close;

end;

procedure TUpdTDeduction.btnOkClick(Sender: TObject);
begin
  if (tTDeductAmount.Value = 0) or
  (tTDeductAmount.IsNull) then
    begin
    ModalResult := mrNone;
    showMessage('Amount must have a value or must be greater than 0.');
    end;
end;

procedure TUpdTDeduction.dbeEmpCodeEnter(Sender: TObject);
begin
  if not (tTDeductStatus.asString = 'P') then
  sbtnSearch1.enabled := true;
end;

procedure TUpdTDeduction.dbeEmpCodeExit(Sender: TObject);
begin
  if (ActiveControl <> btnCancel) then
    begin
      {
      Mainform.tReusable1.close;
      Mainform.tReusable1.databaseName := 'Payroll';
      Mainform.tReusable1.tableName := 'Employee.db';
      Mainform.tReusable1.open;

      if Mainform.tReusable1.findKey([tTDeductEmpCode]) then
        begin
          sbtnSearch1.enabled := false;
          getStatBarInfo;
        end
      else
        begin
          MessageDlg('Employee Code not found.',mtError,[mbOk],0);
          dbeEmpCode.setFocus;
        end;

      Mainform.tReusable1.close;
      Mainform.tReusable1.databaseName := '';
      Mainform.tReusable1.tableName := '';}
    end;
end;

procedure TUpdTDeduction.sbtnSearch1Click(Sender: TObject);
var ctr: smallInt;
begin
 {
  Selection.Caption:='Select';
  Selection.Table1.DataBaseName:='Payroll';
  Selection.Table1.TableName:='Employee.db';
  Selection.Table1.Active:=true;
  for ctr := 0 to Selection.Table1.FieldCount-1 do
    Selection.Table1.Fields[ctr].Visible := False;
  Selection.Table1.FieldByName('EmpCode').Visible := True;
  Selection.Table1.FieldByName('Lastname').Visible := True;
  Selection.Table1.FieldByName('Firstname').Visible := True;

  Selection.rgrpOrder.columns := 2;
  Selection.rgrpOrder.items.clear;
  Selection.rgrpOrder.items.Add('Order by Emp Code');
  Selection.rgrpOrder.items.Add('Order by Lastname');
  Selection.rgrpOrder.itemIndex := 1;

  Selection.ShowModal;
  if Selection.ModalResult = mrOk then
  begin
    tTDeductEmpCode.value := Selection.Table1.FieldByName('EmpCode').AsString;
    dbeEmpCode.setFocus;
  end;
  Selection.Table1.Active:=False;
  Selection.Table1.DataBaseName:='';
  Selection.Table1.TableName:='';
  Selection.Table1.IndexName := '';}

   {
   MainForm.Table1.close;
   MainForm.Table1.DatabaseName := 'AccountData';
   MainForm.table1.tablename := 'Supplier.db';
   MainForm.DataSource1.DataSet := Mainform.Table1;
   MainForm.table1.Open;

   fSelect.Caption := 'Select Supplier';
   fSelect.dbNavigator1.DataSource := MainForm.DataSource1;
   fSelect.DBGrid1.DataSource := MainForm.DataSource1;
   fSelect.dbGrid1.Columns.add;
   fSelect.dbGrid1.Columns[0].FieldName := 'SuppCode';
   fSelect.dbGrid1.Columns[0].Title.Caption:='Supplier Code';
   fSelect.dbGrid1.Columns.add;
   fSelect.dbGrid1.Columns[1].FieldName := 'SuppName';
   fSelect.dbGrid1.Columns[1].Title.Caption:='Supplier Name';
   fSelect.Show;
   if fSelect.Modalresult=mrOk then
       begin
            BrowInvoice.tPurchHd.fieldbyname('suppcode').asString :=
                  fSelect.Edit1.text;
       end;

   Mainform.Table1.Active:=False;
   Mainform.Table1.DataBaseName:='';
   Mainform.Table1.TableName:='';}

   rSelect.Showmodal;

end;

procedure TUpdTDeduction.cboxDeductionTypeExit(Sender: TObject);
begin
  getStatBarInfo
end;

procedure TUpdTDeduction.qryTotalAppliedAfterOpen(DataSet: TDataSet);
begin
  qryTotalApplied.first;
end;

procedure TUpdTDeduction.qryTotalPaidAfterOpen(DataSet: TDataSet);
begin
  qryTotalPaid.first;
end;


procedure TUpdTDeduction.rgrpSchemeClick(Sender: TObject);
begin
  if rgrpScheme.itemIndex = 2 then
    begin
      lAmortization.enabled := true;
      dbeAmortization.enabled := true;
    end
  else
    begin
      lAmortization.enabled := false;
      dbeAmortization.enabled := false;
    end;
end;

procedure TUpdTDeduction.dbeAmortizationExit(Sender: TObject);
begin
  if tTDeductAmortization.value > tTDeductAmount.value then
    begin
      showMessage('Invalid Amortization value.');
      dbeAmortization.setFocus;
    end;
end;

procedure TUpdTDeduction.dbeAmountExit(Sender: TObject);
begin
  getStatBarInfo;
end;


end.
