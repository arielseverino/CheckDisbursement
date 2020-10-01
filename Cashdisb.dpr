program CashDisb;

uses
  Forms,
  mainmenu in 'mainmenu.pas' {MainForm},
  BrowSupplier in 'BrowSupplier.pas' {BrowSupp},
  UpdSupplier in 'UpdSupplier.pas' {UpdSupp},
  BrowSI in 'BrowSI.pas' {BrowInvoice},
  UpdInvoice in 'UpdInvoice.pas' {UpdSI},
  tselect in 'tselect.pas' {rSelect},
  UpdInvDet in 'UpdInvDet.pas' {InvDet},
  UpdAcctDet in 'UpdAcctDet.pas' {AcctDet},
  UpdAccount in 'UpdAccount.pas' {UpdAcct},
  cvfunc in 'cvfunc.pas',
  BrmFIle in 'BrmFIle.pas' {BrowFormMFiles},
  BrowPayment in 'BrowPayment.pas' {BrowVoucher},
  UpdVoucher in 'UpdVoucher.pas' {UpdCV},
  RepCV in 'RepCV.pas' {cvReport},
  dlgrpar1 in 'Dlgrpar1.pas' {dlgReportParameter1},
  Standard in 'Standard.pas',
  Dlglog in 'Dlglog.pas' {DlgLogOn},
  Updusr in 'Updusr.pas' {UpdUser},
  Brow in 'Brow.pas' {BrowseForm},
  CompForm in 'CompForm.pas' {CompInfo},
  Dlgrpar5 in 'Dlgrpar5.pas' {DlgReportParameter5},
  browcheck in 'browcheck.pas' {BrowChk},
  checkform in 'checkform.pas' {chkform},
  SysUtils,
  Dialogs,
  Test in 'Test.pas' {CheckPreview};

{$R *.RES}

begin

dlgLogOn := TDlgLogOn.Create(application);
dlgLogOn.ShowModal;
if dlglogon.tag = 0 then
begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TCheckPreview, CheckPreview);
  Application.CreateForm(TBrowSupp, BrowSupp);
  Application.CreateForm(TUpdSupp, UpdSupp);
  Application.CreateForm(TBrowInvoice, BrowInvoice);
  Application.CreateForm(TUpdSI, UpdSI);
  Application.CreateForm(TrSelect, rSelect);
  Application.CreateForm(TInvDet, InvDet);
  Application.CreateForm(TAcctDet, AcctDet);
  Application.CreateForm(TUpdAcct, UpdAcct);
  Application.CreateForm(TBrowFormMFiles, BrowFormMFiles);
  Application.CreateForm(TBrowVoucher, BrowVoucher);
  Application.CreateForm(TUpdCV, UpdCV);
  Application.CreateForm(TcvReport, cvReport);
  Application.CreateForm(TdlgReportParameter1, dlgReportParameter1);
  Application.CreateForm(TDlgLogOn, DlgLogOn);
  Application.CreateForm(TUpdUser, UpdUser);
  Application.CreateForm(TBrowseForm, BrowseForm);
  Application.CreateForm(TCompInfo, CompInfo);
  Application.CreateForm(TDlgReportParameter5, DlgReportParameter5);
  Application.CreateForm(TBrowChk, BrowChk);
  Application.CreateForm(Tchkform, chkform);
  Application.Run;
end
else
  Application.terminate;
end.
