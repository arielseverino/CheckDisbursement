unit CompForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Db, ExtCtrls, DBTables, Buttons, printers, jpeg;

type
  TCompInfo = class(TForm)
    tCompany: TTable;
    DataSource: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    tCompanyCompCode: TStringField;
    tCompanyCompName: TStringField;
    tCompanyCompAdd: TStringField;
    tCompanyCvctr: TFloatField;
    dbeCompName: TDBEdit;
    dbeAddress: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    dbeCompTin: TDBEdit;
    Label4: TLabel;
    dbeCVCtr: TDBEdit;
    tCompanyCompTin: TStringField;
    tCompanyApCtr: TFloatField;
    dbeAPCtr: TDBEdit;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    Label16: TLabel;
    Label17: TLabel;
    DBEdit19: TDBEdit;
    tCompanyUserLevel: TFloatField;
    tCompanyChkSignatory: TStringField;
    tCompanyCheckPrintType: TStringField;
    tCompanyCVNoRow: TFloatField;
    tCompanyCVNoCol: TFloatField;
    tCompanyCheckNoRow: TFloatField;
    tCompanyCheckNoCol: TFloatField;
    tCompanyCheckDateRow: TFloatField;
    tCompanyCheckDateCol: TFloatField;
    tCompanyCheckAmtRow: TFloatField;
    tCompanyCheckAmtCol: TFloatField;
    tCompanyCheckWord1Row: TFloatField;
    tCompanyCheckWord1Col: TFloatField;
    tCompanyCheckWord2Row: TFloatField;
    tCompanyCheckWord2Col: TFloatField;
    tCompanySignatoryRow: TFloatField;
    tCompanySignatoryCol: TFloatField;
    tCompanySpaceMD: TFloatField;
    tCompanySpaceDY: TFloatField;
    tCompanySupplierRow: TFloatField;
    tCompanySupplierCol: TFloatField;
    Label18: TLabel;
    DBEdit18: TDBEdit;
    BitBtn1: TBitBtn;
    pnlHeader: TPanel;
    Image1: TImage;
    Label19: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActive(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CompInfo: TCompInfo;

implementation

uses dlgrpar1, RepCV, mainmenu, Test;

{$R *.DFM}






procedure TCompInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if Modalresult=mrOk then
       begin
            tCompany.post;
       end
    else
       tCompany.Cancel;
    tCompany.active := false;
end;

procedure TCompInfo.FormActive(Sender: TObject);
begin
     tCompany.active := true;
     tCompany.Edit;
end;

procedure TCompInfo.BitBtn1Click(Sender: TObject);
var PrnChk : system.text;
     cAmt, cWrdAmt, cWord1, cWord2 : string;
     nAmt : real;
     SearchOptions : tLocateOptions;
     nEnd : integer;
     nAdj : integer;

begin
     dlgReportParameter1.caption  := 'Enter Bank & Date Range:';
     dlgReportParameter1.sCheckNo.text := '180068421';
     dlgReportParameter1.eCheckNo.text := '180068421';
     dlgReportParameter1.ShowModal;
     if dlgReportParameter1.modalresult = mrok then
     begin
            CheckPreview := tCheckPreview.create(application);
            with CheckPreview do
            begin
              cvReport.tPaymenthd.active := true;
              cvReport.tcompany.open;
              try
              begin
                   nAdj := 0;
                   cvReport.qryCheck.close;
                   cvReport.qryCheck.parambyname('sCheckNo').asstring := dlgReportParameter1.sCheckNo.text;
                   cvReport.qryCheck.parambyname('eCheckno').asstring := dlgReportParameter1.eCheckNo.text;
                   cvReport.qryCheck.parambyname('cBankName').asstring:= dlgReportParameter1.cBoxBank.text;
                   cvReport.qryCheck.Open;

                   CheckPreview.Showmodal;
                   if checkpreview.modalresult=mrok then
                   begin

                   if mainform.PrintDialog1.execute then
                   begin
                      cvReport.tPaymenthd.active := true;
                      printer.orientation := poPortrait;
                      Assignprn(PrnChk);
                      Rewrite(PrnChk);
                      try
                      begin
                        nAdj := 0;
                        cvReport.qryCheck.first;
                        while not cvReport.qrycheck.eof do
                        begin
                            if (cvReport.qryCheck.fieldbyname('status').asBoolean = true) and
                                (cvReport.qryCheck.fieldbyname('cancel').asboolean = false) and
                                (cvReport.qryCheck.fieldbyname('Approved').asboolean = true) then
                            begin
                                  cAmt    := '';
                                  cWrdAmt := '';
                                  cWord1  := '';
                                  cWord2  := '';
                                  nEnd    := 82;
                                  nAmt := cvReport.qryCheck.fieldbyname('amount').asfloat;
                                  cAmt := Format('%n',[nAmt]);
                                  cAmt := '** ' + cAmt + ' **';
                                  cWrdAmt := '**' + cvReport.qryCheck.fieldbyname('checkword').asstring + '**';
                                  while (copy(cwrdamt,nEnd,1) <> ' ') and (length(cwrdamt)> 81) do
                                  begin
                                       nEnd := nEnd - 1;
                                  end;
                                  cWord1 := copy(cWrdAmt,1,nEnd-1);
                                  cWord2 := copy(cWrdAMt,nEnd,Length(cWrdAmt));

                                  printer.canvas.font.size := 6;
                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('CVNoCol').asinteger,cvReport.tCompany.fieldbyname('CVNoRow').asinteger,cvReport.qryCheck.fieldbyname('cvno').asstring);
                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('CheckNoCol').asinteger,cvReport.tCompany.fieldbyname('CheckNoRow').asinteger,cvReport.qryCheck.fieldbyname('checkno').asstring);
                                  printer.canvas.font.size := 10;
                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('CheckDateCol').asinteger,cvReport.tCompany.fieldbyname('CheckDateRow').asinteger,cvReport.qryCheck.fieldbyname('checkprinted').asstring);
                                  if (cvReport.qrycheck.fieldbyname('supplier').asboolean = true) then
                                       printer.canvas.textout(cvReport.tCompany.fieldbyname('SupplierCol').asinteger,cvReport.tCompany.fieldbyname('SupplierRow').asinteger,'**'+cvReport.qryCheck.fieldbyname('suppname').asstring+'**')
                                  else
                                        printer.canvas.textout(cvReport.tCompany.fieldbyname('SupplierCol').asinteger,cvReport.tCompany.fieldbyname('SupplierRow').asinteger,'**'+cvReport.qryCheck.fieldbyname('payeename').asstring+'**');
                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('CheckAmtCol').asinteger,cvReport.tCompany.fieldbyname('CheckAmtRow').asinteger,camt );
                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('CheckWord1Col').asinteger,cvReport.tCompany.fieldbyname('CheckWord1Row').asinteger,cWord1);
                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('CheckWord2Col').asinteger,cvReport.tCompany.fieldbyname('CheckWord2Row').asinteger,cWord2);
                                  printer.canvas.textout(cvReport.tCompany.fieldbyname('SignatoryCol').asinteger,cvReport.tCompany.fieldbyname('SignatoryRow').asinteger,cvReport.tCompany.fieldbyname('ChkSignatory').asstring);

                                  printer.newpage;
                                  nAdj := 25;
                                  cvReport.tPaymenthd.first;
                                  if cvReport.tPaymenthd.locate('checkno',cvReport.qrycheck.fieldbyname('checkno').asstring,SearchOptions) then
                                  begin
                                       cvReport.tPaymenthd.edit;
                                       cvReport.tPaymenthd.fieldbyname('status').asboolean := true;
                                       cvReport.tPaymenthd.post;
                                  end;
                            end
                            else
                                if cvReport.qrycheck.fieldbyname('status').asboolean = true then
                                    showmessage('Check No. : ' + cvReport.qryCheck.fieldbyname('checkno').asstring + ' already printed...')
                                else
                                  if cvReport.qrycheck.fieldbyname('cancel').asboolean = true then
                                       showmessage('CV No. : ' + cvReport.qrycheck.fieldbyname('cvno').asstring + ' already cancelled...')
                                  else
                                        if cvReport.qryCheck.fieldbyname('Approved').asboolean = false then
                                                showmessage('Check No. : ' + cvReport.qryCheck.fieldbyname('checkno').asstring + ' Check not yet approved for printing...');
                            cvReport.qryCheck.next;
                        end;
                      end;
                      finally
                        closefile(prnchk);
                        showmessage('Printing completed...');
                      end;
                   end;
                   cvReport.tPaymenthd.close;
                   cvReport.qryCheck.close;
                   end;
                   CheckPreview.free;

              end;
              finally
              begin
                   cvReport.tpaymenthd.close;
              end;
              cvReport.tPaymenthd.active := false;
              cvReport.tCompany.close;
            end;
     end;
end;
end;


end.
