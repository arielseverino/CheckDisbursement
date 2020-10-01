unit Payfunc;

interface

uses Dialogs, SysUtils, WinTypes, WinProcs, Classes, DBTables;

function GetWithholdingTax(TaxClass,TaxStatus:String;GP:Real):Real;
function GetYerSSS(GP:Real):Real;
function GetYerMcr(GP:Real):Real;
function GetYeeSSS(GP:Real):Real;
function GetYeeMcr(GP:Real):Real;
procedure PreUpdatePayrollRegister;
procedure UpdatePaysetup;
procedure IdentifyPaidDeduction;
function GetEmpListExpression(ColumnType,ReportType:integer):string;
function GetEmpListColumnLabel(ColumnType,ReportType:integer):string;
function GetEmpListAlignment(ColumnType,ReportType:integer):TAlignment;
function GetEmpListOrder(ColumnType,ReportType:integer):string;
procedure ApplyManyTransactions;
function GetSubtotalExpression(ColumnType,ReportType:integer):string;
Function GetVL(LeaveMode:String):Real;
Function GetSL(LeaveMode:String):Real;
Function LastYearBnft(TranType:String):Integer;
Function LastMonthBnft(TranType:String):Integer;
Function LastDayBnft(TranType:String):Integer;
Function GetYerEC(GP:Real):Real;
Function ConvAcct(pAcctNo:String):String;
Function ConvNet(nNetAmt:Real):String;


implementation

uses Main, Payreg, dlgSetup, updpreg, updtded, rpthold, select, dlgRPar7;

function GetWithholdingTax(TaxClass,TaxStatus:String;GP:Real):Real;
begin

  UpdPayrollRegister.qryTaxTable.Close;
  UpdPayrollRegister.qryTaxTable.ParamByName('Classification').AsString :=
    TaxClass;
  UpdPayrollRegister.qryTaxTable.ParamByName('TaxStatus').AsString :=
    TaxStatus;

      UpdPayrollRegister.qryTaxTable.ParamByName('GrossPay').AsFloat :=
        (round((GP)*100))/100;
      UpdPayrollRegister.qryTaxTable.Open;
      UpdPayrollRegister.qryTaxTable.First;
      Result := UpdPayrollRegister.qryTaxTableExemption.Value +
        ( (GP - UpdPayrollRegister.qryTaxTableAmount.Value) *
        (UpdPayrollRegister.qryTaxTableExcessRate.Value/100) ) ;
      Result := round((result)*100)/100;
  UpdPayrollRegister.qryTaxTable.Close;
end;

function GetYerSSS(GP:Real):Real;
begin
  UpdPayrollRegister.qrySSSTable.Close;
  UpdPayrollRegister.qrySSSTable.ParamByName('GrossPay').AsFloat := GP;
  UpdPayrollRegister.qrySSSTable.Open;
  UpdPayrollRegister.qrySSSTable.First;
  Result := UpdPayrollRegister.qrySSSTable.FieldByName('YerSSS').AsFloat;
  UpdPayrollRegister.qrySSSTable.Close;
end;

function GetYerEC(GP:Real):Real;
begin
  UpdPayrollRegister.qrySSSTable.Close;
  UpdPayrollRegister.qrySSSTable.ParamByName('GrossPay').AsFloat := GP;
  UpdPayrollRegister.qrySSSTable.Open;
  UpdPayrollRegister.qrySSSTable.First;
  Result := UpdPayrollRegister.qrySSSTable.FieldByName('EC').AsFloat;
  UpdPayrollRegister.qrySSSTable.Close;
end;


function GetYerMcr(GP:Real):Real;
begin
  UpdPayrollRegister.qryPHTable.Close;
  UpdPayrollRegister.qryPHTable.ParamByName('GrossPay').AsFloat := GP;
  UpdPayrollRegister.qryPHTable.Open;
  UpdPayrollRegister.qryPHTable.First;
  Result := UpdPayrollRegister.qryPHTable.FieldByName('YerMcr').AsFloat;
  UpdPayrollRegister.qryPHTable.Close;
end;

function GetYeeSSS(GP:Real):Real;
begin
  UpdPayrollRegister.qrySSSTable.Close;
  UpdPayrollRegister.qrySSSTable.ParamByName('GrossPay').AsFloat := GP;
  UpdPayrollRegister.qrySSSTable.Open;
  UpdPayrollRegister.qrySSSTable.First;
  Result := UpdPayrollRegister.qrySSSTable.FieldByName('YeeSSS').AsFloat;
  UpdPayrollRegister.qrySSSTable.Close;
end;

function GetYeeMcr(GP:Real):Real;
begin
  UpdPayrollRegister.qryPHTable.ParamByName('GrossPay').AsFloat := GP;
  UpdPayrollRegister.qryPHTable.Open;
  UpdPayrollRegister.qryPHTable.First;
  Result := UpdPayrollRegister.qryPHTable.FieldByName('YeeMcr').AsFloat;
  UpdPayrollRegister.qryPHTable.Close;
end;

procedure PreUpdatePayrollRegister;
var CursorStd,CursorWait: HCursor;

begin
  CursorWait := LoadCursor(0,IDC_WAIT);
  SetCursor(CursorWait);


  mainForm.tReusable1.close;
  mainForm.tReusable1.databaseName := 'Payroll';
  mainForm.tReusable1.tableName := 'Payregd.db';
  mainForm.tReusable1.open;

  with mainForm.qryReusable1 do
  begin
    // part 1 - for deduction transactions
    close;
    databaseName := 'Payroll';
    sql.clear;
    sql.add( 'SELECT TDEDUCT."KeyField", TDEDUCT."DeductionKey", TDEDUCT."Amount", ' +
             'TDEDUCT."Amortization", TDEDUCT."Scheme", TDEDUCT."EmployerShare" FROM "TDEDUCT.DB" TDEDUCT ' +
             'WHERE (TDEDUCT."FullyPaid" = "N") AND ' +
             '(TDEDUCT."EmpCode" = "' + UpdPayrollRegister.tPayrollRegisterEmpCode.asString +
             '") AND (TDEDUCT."Date" <= ''' +
             PayrollRegister.tPayrollSetupPeriodTo.asString + ''') ' );
    if (PayrollRegister.tPayrollSetupPaytype.asString = '0') then
      sql.add( 'and (TDeduct."DeductWhenPayType0" = "Y") ' )
    else if (PayrollRegister.tPayrollSetupPaytype.asString = '1') then
      sql.add( 'and (TDeduct."DeductWhenPayType1" = "Y") ' )
    else if (PayrollRegister.tPayrollSetupPaytype.asString = '2') then
      sql.add( 'and (TDeduct."DeductWhenPayType2" = "Y") ' )
    else if (PayrollRegister.tPayrollSetupPaytype.asString = '3') then
      sql.add( 'and (TDeduct."DeductWhenPayType3" = "Y") ' );
    open;

    UpdTDeduction.qryTotalPaid.Close;
    UpdTDeduction.qryTotalPaid.databaseName := 'Payroll';
    UpdTDeduction.qryTotalPaid.sql.clear;

    while not eof do
    begin
      if fieldByName('Scheme').asString = '2' then
      begin
        UpdTDeduction.qryTotalPaid.sql.add( 'Select sum(Payregd."Amount") As Amount ' +
          'From "Payregd.db" Payregd Where (Payregd."Type" = "0") And ' +
          '(Payregd."TDeductionKey" = ' + fieldByName('KeyField').asString + ') ' );
        UpdTDeduction.qryTotalPaid.open;
      end; {if fieldByName('Scheme')...}

      mainForm.tReusable1.insert;
      mainForm.tReusable1.fieldByName('Type').asString := '0';
      mainForm.tReusable1.fieldByName('Code').asString :=
        fieldByName('DeductionKey').asString;
      mainForm.tReusable1.fieldByName('TDeductionKey').asInteger :=
        fieldByName('KeyField').asInteger;
      mainForm.tReusable1.fieldByName('PayrollKey').asInteger :=
        PayrollRegister.tPayrollSetupKeyField.asInteger;
      mainForm.tReusable1.fieldByName('EmpCode').asString :=
        UpdPayrollRegister.tPayrollRegisterEmpCode.asString;

      if (fieldByName('Scheme').asString = '0') then
      begin
        mainForm.tReusable1.fieldByName('Amount').asFloat := fieldByName('Amount').asFloat;

        UpdTDeduction.tTDeduct.open;
        if UpdTDeduction.tTDeduct.findKey([fieldByName('Keyfield')]) then
        begin
          UpdTDeduction.tTDeduct.edit;
          UpdTDeduction.tTDeduct.fieldByName('FullyPaid').asString := 'Y';
          UpdTDeduction.tTDeduct.post;
        end;

      end;

      if (fieldByName('Scheme').asString = '1') then
        mainForm.tReusable1.fieldByName('Amount').asFloat := fieldByName('Amount').asFloat;

      if fieldByName('Scheme').asString = '2' then
      begin
        {
        if fieldByName('Amortization').asFloat <= (fieldByName('Amount').asFloat -
        UpdTDeduction.qryTotalPaid.fieldByName('Amount').asFloat) then
          mainForm.tReusable1.fieldByName('Amount').asFloat := fieldByName('Amortization').asFloat
        else
          mainForm.tReusable1.fieldByName('Amount').asFloat := fieldByName('Amount').asFloat -
            UpdTDeduction.qryTotalPaid.fieldByName('Amount').asFloat;}

        if (fieldbyname('Amortization').asFloat) <= (fieldbyname('amount').asFloat) then
                mainform.tReusable1.Fieldbyname('amount').asFloat := fieldbyname('amortization').asfloat
        else
                mainform.tReusable1.Fieldbyname('amount').asfloat := fieldbyname('amount').asFLoat;

        {
        mainform.tReusable2.Close;
        mainform.tReusable2.databasename:='Payroll';
        mainform.tReusable2.TableName := 'TDeduct.db';
        mainform.tReusable2.Open;
        mainform.tReusable2.Edit;
        mainform.tReusable2.first;

        if mainform.tReusable2.Findkey([FieldbyName('keyfield').asInteger]) then
           begin
                mainform.tReusable2.edit;
                mainform.tReusable2.fieldbyname('amount').asfloat :=
                       mainform.tReusable2.fieldbyname('amount').asfloat -
                       mainform.tReusable1.fieldbyname('amount').asfloat;
                if mainform.tReusable2.fieldbyname('amount').asfloat = 0 then
                       mainform.tReusable2.fieldbyname('fullypaid').asString := 'Y';
           end;

        mainform.tReusable2.post;
        mainform.tReusable2.close;}

        UpdTDeduction.qryTotalPaid.Close;
        UpdTDeduction.qryTotalPaid.sql.clear;

      end; {if fieldByName('Scheme').asString = '2'...}

      mainForm.tReusable1.fieldByName('EmployerShare').asFloat :=
        fieldByName('EmployerShare').asFloat;

      mainForm.tReusable1.post;
      next;
    end; {while not eof...}

    UpdTDeduction.qryTotalPaid.databaseName := '';

    // part 2 - for other earning transactions
    close;
    sql.clear;
    sql.add( 'SELECT TRev."RevenueCode", TRev."Amount", Revenue."Taxable" ' +
             'FROM "TRev.DB" TRev, "Revenue.db" Revenue ' +
             'WHERE (TRev."RevenueCode" = Revenue."KeyField") ' +
             'And (TRev."EmpCode" = "' +
             UpdPayrollRegister.tPayrollRegisterEmpCode.asString + '") ' );
    open;

    while not eof do
    begin
      mainForm.tReusable1.append;
      mainForm.tReusable1.fieldByName('Type').asString := '2';
      mainForm.tReusable1.fieldByName('Code').asString :=
        fieldByName('RevenueCode').asString;
      mainForm.tReusable1.fieldByName('PayrollKey').asInteger :=
        PayrollRegister.tPayrollSetupKeyField.asInteger;
      mainForm.tReusable1.fieldByName('EmpCode').asString :=
        UpdPayrollRegister.tPayrollRegisterEmpCode.asString;
      mainForm.tReusable1.fieldByName('Amount').asFloat :=
        fieldByName('Amount').asFloat;
      mainForm.tReusable1.fieldByName('Taxable').asString :=
        fieldByName('Taxable').asString;
      mainForm.tReusable1.post;

      next;
    end; {while not eof...}

    close;
    requestLive := true;
    sql.clear;
    sql.add( 'SELECT * FROM "TRev.DB" TRev WHERE (TRev."Scheme" = "0") ' +
             'And (TRev."EmpCode" = "' +
             UpdPayrollRegister.tPayrollRegisterEmpCode.asString + '") ' );
    open;
    while not eof do delete;


    close;
    databaseName := '';
    requestLive := false;
    sql.clear;
  end; {with mainForm.qryReusable1...}

  mainForm.tReusable1.close;
  mainForm.tReusable1.databaseName := '';
  mainForm.tReusable1.tableName := '';

  CursorStd := LoadCursor(0,IDC_ARROW);
  SetCursor(CursorStd);
end;

procedure UpdatePaysetup;
begin
  PayrollRegister.Close;
  with PayrollRegister.tPayrollSetup do
  begin
    Open;
    Insert;
    mainForm.tReusable1.DatabaseName := 'Payroll';
    mainForm.tReusable1.TableName := 'CONTROL';
    mainForm.tReusable1.Open;

    PayrollRegister.tPayrollSetupKeyField.Value :=
      mainForm.tReusable1.FieldByName('Payroll').AsInteger;
    PayrollRegister.tPayrollSetupPeriodFrom.Value := DlgPayrollSetup.dpStart.date;
    PayrollRegister.tPayrollSetupPeriodTo.Value := DlgPayrollSetup.dpEnd.date;
    PayrollRegister.tPayrollSetupPayType.Value :=
      IntToStr(DlgPayrollSetup.rgrpPayrollType.ItemIndex);
    PayrollRegister.tPayrollSetupPayOut.Value := DlgPayrollSetup.dpPayout.date;
    PayrollRegister.tPayrollSetupBindNo.Value :=
      DlgPayrollSetup.rgrpMonth.ItemIndex;

    if dlgPayrollSetup.rbtnOneDept.checked then
    begin
      mainForm.tReusable2.close;
      mainForm.tReusable2.databaseName := 'Payroll';
      mainForm.tReusable2.tableName := 'Dept.db';
      mainForm.tReusable2.indexName := 'ByName';
      mainForm.tReusable2.open;
      if mainForm.tReusable2.findKey([dlgPayrollSetup.cboxOneDept.text]) then
        PayrollRegister.tPayrollSetupDept.value :=
          mainForm.tReusable2.fieldByName('KeyField').asString;
    end;

    mainForm.tReusable2.close;
    mainForm.tReusable2.databaseName := 'Payroll';
    mainForm.tReusable2.tableName := 'JobGrp.db';
    mainForm.tReusable2.indexName := 'ByName';
    mainForm.tReusable2.open;
    if mainForm.tReusable2.findKey([dlgPayrollSetup.lEmpLevel.caption]) then
      PayrollRegister.tPayrollSetupEmpLevel.value :=
        mainForm.tReusable2.fieldByName('KeyField').asString;
    mainForm.tReusable2.close;
    mainForm.tReusable2.databaseName := '';
    mainForm.tReusable2.tableName := '';
    mainForm.tReusable2.indexName := '';

    case PayrollRegister.tPayrollSetupPayType.asInteger of
      0:
        begin

          case StrToInt(MainForm.tCompanySetupWtaxSemiMonthlySched.Value) of
            0: PayrollRegister.tPayrollSetupTaxTableClassification.Value := '2';
            1:
              begin
                if DlgPayrollSetup.chkboxEndOfMonth.Checked then
                  PayrollRegister.tPayrollSetupEndOfMonth.Value := 'Y'
                else PayrollRegister.tPayrollSetupEndOfMonth.Value := 'N';
                PayrollRegister.tPayrollSetupTaxTableClassification.Value := '3';
              end;
          end;

        end;

      1:
        begin

          case StrToInt(MainForm.tCompanySetupWtaxWeeklySched.Value) of
            0: PayrollRegister.tPayrollSetupTaxTableClassification.Value := '1';
            1:
              begin
                if DlgPayrollSetup.chkboxEndOfMonth.Checked then
                  PayrollRegister.tPayrollSetupEndOfMonth.Value := 'Y'
                else PayrollRegister.tPayrollSetupEndOfMonth.Value := 'N';
                  PayrollRegister.tPayrollSetupTaxTableClassification.Value := '3';
              end;
          end;

        end;
    end; {case PayrollRegister.tPayrollSetupPayType.asInteger}

    if DlgPayrollSetup.rgrpPayrollType.ItemIndex = 1 then
      PayrollRegister.tPayrollSetupEndOfMonth.Value := 'Y';

    Post;

    mainForm.tReusable1.Edit;
    mainForm.tReusable1.FieldByName('Payroll').AsInteger :=
      mainForm.tReusable1.FieldByName('Payroll').AsInteger + 1;
    mainForm.tReusable1.Post;
    mainForm.tReusable1.Close;
    mainForm.tReusable1.DatabaseName := '';
    mainForm.tReusable1.TableName := '';
  end; {with PayrollRegister...}
end;

procedure IdentifyPaidDeduction;
var CursorStd,CursorWait: HCursor;
begin
  CursorWait := LoadCursor(0,IDC_WAIT);
  SetCursor(CursorWait);

  with mainForm.tReusable1 do
  begin
    close;
    databaseName := 'Payroll';
    tableName := 'TDeduct.db';
    filtered := true;
    filter := '(Status = ''P'') and (Scheme <> ''1'')';
    open;
    first;
    while not EOF do
    begin
      if upperCase(fieldByName('FullyPaid').asString) = 'N' then
      begin
        mainForm.qryReusable1.close;
        mainForm.qryReusable1.databasename := 'Payroll';
        mainForm.qryReusable1.sql.clear;
        mainForm.qryReusable1.sql.add( 'Select sum(Payregd."Amount") as Amount ' +
          'From "Payregd.db" Payregd Where Payregd."TDeductionKey" = ' +
          fieldByName('KeyField').asString );
        mainForm.qryReusable1.open;

        if formatFloat('#.##',fieldByName('Amount').AsFloat) =
        formatFloat('#.##',mainForm.qryReusable1.FieldByName('Amount').AsFloat) then
        begin
          edit;
          fieldByName('FullyPaid').AsString := 'Y';
          post;
        end;
      end; {if upperCase(fieldByName('FullyPaid')....}
      next;
    end; {while not EOF...}
    close;
    databaseName := '';
    tableName := '';
    filtered := false;
    filter := '';
  end; {with mainForm.tReusable1...}

  CursorStd := LoadCursor(0,IDC_ARROW);
  SetCursor(CursorStd);
end;

function GetEmpListExpression(ColumnType,ReportType:integer):string;
begin
  if ReportType = 0 then
    case columnType of
      0: result := 'qryEmployeeList.EmpCode';
      1: result := 'qryEmployeeList.Firstname + '' '' + qryEmployeeList.Middlename + '' '' + qryEmployeeList.Lastname';
      2: result := 'qryEmployeeList.Firstname + '' '' + COPY(qryEmployeeList.Middlename, 1, 1) + ''. '' + qryEmployeeList.Lastname';
      3: result := 'qryEmployeeList.Firstname + '' '' + qryEmployeeList.Lastname';
      4: result := 'qryEmployeeList.Lastname + '' '' + qryEmployeeList.Firstname + '' '' + qryEmployeeList.Middlename';
      5: result := 'qryEmployeeList.Lastname + '', '' + qryEmployeeList.Firstname + '' '' + COPY(qryEmployeeList.Middlename, 1, 1) + ''.''';
      6: result := 'qryEmployeeList.Lastname + '', '' + qryEmployeeList.Firstname';
      7: result := 'qryEmployeeList.Lastname';
      8: result := 'qryEmployeeList.Firstname';
      9: result := 'qryEmployeeList.Middlename';
      10: result := 'qryEmployeeList.Nickname';
      11: result := 'qryEmployeeList.Name';
      12: result := 'qryEmployeeList.NumberOfChildren';
      13: result := 'qryEmployeeList.Birthday';
      14: result := 'qryEmployeeList.Address1 + '' '' + qryEmployeeList.Address2';
      15: result := 'qryEmployeeList.Telephone';
      16: result := 'qryEmployeeList.ContactPerson';
      17: result := 'qryEmployeeList.ContPersRelationship';
      18: result := 'qryEmployeeList.SSS';
      19: result := 'qryEmployeeList.TIN';
      20: result := 'qryEmployeeList.Name_3';
      21: result := 'qryEmployeeList.DateRegular';
      22: result := 'qryEmployeeList.Name_1';
      23: result := 'qryEmployeeList.Name_2';
      24: result := 'FORMATNUMERIC(''#,##0.00'', qryEmployeeList.Rate)';
      25: result := 'qryEmployeeList.RecommendedBy';
      26: result := 'qryEmployeeList.HiredBy';
      27: result := 'qryEmployeeList.DateHired';
      28: result := 'qryEmployeeList.BankAccountNo';
    end
  else if ReportType = 1 then
    case columnType of
      0: result := 'qryDeduction.EmpCode';
      1: result := 'qryDeduction.Firstname + '' '' + qryDeduction.Middlename + '' '' + qryDeduction.Lastname';
      2: result := 'qryDeduction.Firstname + '' '' + COPY(qryDeduction.Middlename, 1, 1) + ''. '' + qryDeduction.Lastname';
      3: result := 'qryDeduction.Firstname + '' '' + qryDeduction.Lastname';
      4: result := 'qryDeduction.Lastname + '' '' + qryDeduction.Firstname + '' '' + qryDeduction.Middlename';
      5: result := 'qryDeduction.Lastname + '', '' + qryDeduction.Firstname + '' '' + COPY(qryDeduction.Middlename, 1, 1) + ''.''';
      6: result := 'qryDeduction.Lastname + '', '' + qryDeduction.Firstname';
      7: result := 'qryDeduction.Lastname';
      8: result := 'qryDeduction.Firstname';
      9: result := 'qryDeduction.Middlename';
      10: result := 'qryDeduction.PagIbig';
      11: result := 'FORMATNUMERIC(''#,##0.00'', qryDeduction.Amount)';
      12: result := 'FORMATNUMERIC(''#,##0.00'', qryDeduction.EmployerShare)';
      13: result := 'FORMATNUMERIC(''#,##0.00'', qryDeduction.Total)';
    end;

end;

function GetEmpListColumnLabel(ColumnType,ReportType:integer):string;
begin
  if ReportType = 0 then
    case columnType of
      0: result := 'Employee Code';
      1: result := 'Fullname';
      2: result := 'Fullname';
      3: result := 'Fullname';
      4: result := 'Fullname';
      5: result := 'Fullname';
      6: result := 'Fullname';
      7: result := 'Lastname';
      8: result := 'Firstname';
      9: result := 'Middlename';
      10: result := 'Nickname';
      11: result := 'Tax Status';
      12: result := 'No. of Chldrn';
      13: result := 'Birthday';
      14: result := 'Address';
      15: result := 'Telephone';
      16: result := 'Contact Person';
      17: result := 'Relationship to Contact Person';
      18: result := 'SSS #';
      19: result := 'TIN';
      20: result := 'Employee Status';
      21: result := 'Date Regularized';
      22: result := 'Position';
      23: result := 'Department';
      24: result := 'Rate';
      25: result := 'Recommended By';
      26: result := 'Hired By';
      27: result := 'Date Hired';
      28: result := 'Bank Acct #';
    end
  else if ReportType = 1 then
    case columnType of
      0: result := 'Employee Code';
      1: result := 'Fullname';
      2: result := 'Fullname';
      3: result := 'Fullname';
      4: result := 'Fullname';
      5: result := 'Fullname';
      6: result := 'Fullname';
      7: result := 'Lastname';
      8: result := 'Firstname';
      9: result := 'Middlename';
      10: result := 'PagIbig #';
      11: result := 'Amount';
      12: result := 'Employer Share';
      13: result := 'Total';
    end;
end;

function GetEmpListAlignment(ColumnType,ReportType:integer):TAlignment;
begin
  result := taLeftJustify;
  if ReportType = 0 then
    case columnType of
      12: result := taRightJustify;
      24: result := taRightJustify;
    end

  else if ReportType = 1 then
    case columnType of
      11: result := taRightJustify;
      12: result := taRightJustify;
      13: result := taRightJustify;
    end;

end;

function GetEmpListOrder(ColumnType,ReportType:integer):string;
begin
  if ReportType = 0 then
    case columnType of
      0: result := 'EmpCode';
      1: result := 'Lastname';
      2: result := 'Firstname';
      3: result := 'Middlename';
      4: result := 'Nickname';
      5: result := 'Name';
      6: result := 'NumberOfChildren';
      7: result := 'Birthday';
      8: result := 'Telephone';
      9: result := 'ContactPerson';
      10: result := 'ContPersRelationship';
      11: result := 'SSS';
      12: result := 'TIN';
      13: result := 'EmpStat.Name';
      14: result := 'DateRegular';
      15: result := 'P.Name';
      16: result := 'Department.Name';
      17: result := 'Rate';
      18: result := 'RecommendedBy';
      19: result := 'HiredBy';
      20: result := 'DateHired';
      21: result := 'BankAccountNo';
    end
  else if ReportType = 1 then
    case columnType of
      0: result := 'EmpCode';
      1: result := 'Lastname';
      2: result := 'Firstname';
      3: result := 'Middlename';
      4: result := 'PagIbig';
      5: result := 'Amount';
      6: result := 'EmployerShare';
      7: result := 'Total';
    end;
end;

procedure ApplyManyTransactions;
begin
  mainForm.qryReusable1.close;
  mainForm.qryReusable1.databaseName := 'Payroll';
  mainForm.qryReusable1.sql.clear;
  mainForm.qryReusable1.sql.add( 'select Employee."EmpCode", ' +
    'Employee."Lastname" + ", " + Employee."Firstname" as EmpName ' +
    'From "Employee.db" Employee, "Dept.db" Dept ' );
  mainForm.qryReusable1.sql.add( 'Where (Employee."Department" = Dept."KeyField") ' +
    'and not (Employee."Inactive" = "Y") ' +
    'and (Dept."Name" = "' + dlgReportParameter7.cboxDepartment.text + '") ' );
  mainForm.qryReusable1.open;

  mainForm.tReusable1.close;
  mainForm.tReusable1.databaseName := 'PayrollTemp';
  mainForm.tReusable1.tableName := 'ManyTrans.db';
  mainForm.tReusable1.emptyTable;

  mainForm.batchMove.source := mainForm.qryReusable1;
  mainForm.batchMove.destination := mainForm.tReusable1;
  mainForm.batchMove.mode := batAppend;
  mainForm.batchMove.execute;

  mainForm.qryReusable1.close;
  mainForm.qryReusable1.databaseName := '';
  mainForm.qryReusable1.sql.clear;

  mainForm.tReusable1.close;
  mainForm.tReusable1.databaseName := '';
  mainForm.tReusable1.tableName := '';
end;

function GetSubtotalExpression(ColumnType,ReportType:integer):string;
begin
  result := '';
  if ReportType = 1 then
    case columnType of
      11: result := 'FORMATNUMERIC(''#,##0.00'', SUM(qryDeduction.Amount))';
      12: result := 'FORMATNUMERIC(''#,##0.00'', SUM(qryDeduction.EmployerShare))';
      13: result := 'FORMATNUMERIC(''#,##0.00'', SUM(qryDeduction.Total))';
    end;

end;

Function GetSL(LeaveMode:String):Real;
begin
  UpdPayrollRegister.qrySLVLTable.Close;
  UpdPayrollRegister.qrySLVLTable.ParamByName('LeaveMode').AsString := LeaveMode;
  UpdPayrollRegister.qrySLVLTable.Open;
  UpdPayrollRegister.qrySLVLTable.First;
  Result := UpdPayrollRegister.qrySLVLTable.FieldByName('SLMonth').AsFloat;
  UpdPayrollRegister.qrySLVLTable.Close;
end;

Function GetVL(LeaveMode:String):Real;
begin
  UpdPayrollRegister.qrySLVLTable.Close;
  UpdPayrollRegister.qrySLVLTable.ParamByName('LeaveMode').AsString := LeaveMode;
  UpdPayrollRegister.qrySLVLTable.Open;
  UpdPayrollRegister.qrySLVLTable.First;
  Result := UpdPayrollRegister.qrySLVLTable.FieldByName('VLMonth').AsFloat;
  UpdPayrollRegister.qrySLVLTable.Close;
end;

Function LastYearBnft(TranType:String):Integer;
Var BnftMonth, BnftYear, BnftDay, PayMonth, PayYear, PayDay : Word;

begin
     if TranType = 'N' then
        begin
           DecodeDate(PayrollRegister.tPayrollSetupPeriodto.asDateTime,PayYear,PayMonth,PayDay);
           result := PayYear;
        end
     else
        Begin
           DecodeDate(mainform.tReusable1.Fieldbyname('LastBnft').asDateTime,BnftYear,BnftMonth,BnftDay);
           BnftMonth := BnftMonth - 1;
           if BnftMonth=0 then
              BnftYear := BnftYear - 1;
           result := BnftYear;
        end;
end;

Function LastMonthBnft(TranType:String):Integer;
Var BnftMonth, BnftYear, BnftDay, PayMonth, PayYear, PayDay : Word;

begin
     if TranType = 'N' then
        begin
           DecodeDate(PayrollRegister.tPayrollSetupPeriodto.asDateTime,PayYear,PayMonth,PayDay);
           result := PayMonth;
        end
     else
        Begin
           DecodeDate(mainform.tReusable1.Fieldbyname('LastBnft').asDateTime,BnftYear,BnftMonth,BnftDay);
           BnftMonth := BnftMonth - 1;
           if BnftMonth=0 then
              BnftMonth := 12;
           result := BnftMonth;
        end;
end;

Function LastDayBnft(TranType:String):Integer;
Var BnftMonth, BnftYear, BnftDay, PayMonth, PayYear, PayDay : Word;

begin
     if TranType = 'N' then
        begin
           DecodeDate(PayrollRegister.tPayrollSetupPeriodto.asDateTime,PayYear,PayMonth,PayDay);
           DecodeDate(mainform.tReusable1.Fieldbyname('LastBnft').asDateTime,BnftYear,BnftMonth,BnftDay);
           if PayMonth = 2 then
              begin
                   if BnftYear/4 = 0 then
                      if BnftDay >= 29  then
                         result := 29
                      else
                          result := BnftDay
                   else
                       if BnftDay >= 28 then
                          result := 28
                       else
                           result := BnftDay;
              end
           else
              if (PayMonth = 4) or (Paymonth=6) or (Paymonth=9) or (Paymonth=11) then
                  if BnftDay = 31 then
                     result := 30
                  else
                     result := BnftDay
              else
                  result := BnftDay;

        end
     else
        Begin
           DecodeDate(mainform.tReusable1.Fieldbyname('LastBnft').asDateTime,BnftYear,BnftMonth,BnftDay);
           BnftMonth := BnftMonth - 1;
           if BnftMonth = 0 then
                result := BnftDay
           else
               if BnftMonth = 2 then
                  if (BnftYear/4) = 0 then
                     if BnftDay >= 29 then
                        result := 29
                     else
                         result := BnftDay
                  else
                      if BnftDay >= 28 then
                         result := 28
                      else
                          result := BnftDay
               else
                  if (BnftMonth=4) or (BnftMonth=6) or (BnftMonth=9) or (BnftMonth=11) then
                     if BnftDay = 31 then
                        result := 30
                     else
                         result := BnftDay
                  else
                      result := BnftDay;
        end;
end;

Function ConvAcct(pAcctNo:String):String;
var k : integer;
    cAcctNo : string;

begin
    for k:= 1 to length(pAcctNo) do
    begin
         if (pAcctNo[k] <> ' ') and (pAcctNo[k] <> '-') then
                   cAcctNo := cAcctNo + pAcctNo[k];
    end;
    if length(cAcctNo) <> 10 then
         showmessage('Error Account # ' + mainform.qryReusable1.fieldbyname('empcode').asstring);
    result := cAcctNo;
end;

Function ConvNet(nNetAmt:real):string;
var cNetAmt,cNetPay : string;
    k       : integer;

begin
    nNetAmt := nNetAmt * 100;
    str(nNetAmt:15:0,cNetAmt);
    for k:= 1 to 15 do
    begin
        if cNetAmt[k] = ' ' then
              cNetPay := cNetPay + '0'
        else
              cNetPay := cNetPay + cNetAmt[k];
    end;
    result := cNetPay 
end;

end.
