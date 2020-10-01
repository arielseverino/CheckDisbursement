unit Test;
interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Db, DBTables, Dialogs, ExtCtrls, Grids, DBGrids, jpeg, printers;

type
  TCheckPreview = class(TForm)
    MyCanvas: TPaintBox;
    BitBtn1: TBitBtn;
    PrintDialog1: TPrintDialog;
    Button1: TButton;
    procedure MyCanvasPaint(Sender: TObject);


  private
    { Private declarations }

  public
    { Public declarations }

  end;


var
  CheckPreview: TCheckPreview;
  nUserLevel : integer;
  MyList: TList;

implementation

uses Standard, dlgrpar1, RepCV, mainmenu;

{$R *.DFM}

procedure TCheckPreview.MyCanvasPaint(Sender: TObject);
var PrnChk : system.text;
     cAmt, cWrdAmt, cWord1, cWord2 : string;
     nAmt : real;
     SearchOptions : tLocateOptions;
     nEnd : integer;
     nAdj : integer;

begin
    {
    MyCanvas.Canvas.font.size := 6;
    MyCanvas.Canvas.textOut(555,1,'123456789');
    MyCanvas.canvas.textout(550,20,'1200010001');

    MyCanvas.canvas.font.size := 10;
    MyCanvas.canvas.textout(760,20,'09       04       2020');
    MyCanvas.canvas.textout(200,40,'**MANILA ELECTRIC COMPANY**');
    MyCanvas.canvas.textout(750,40,'1,192.12');
    MyCanvas.canvas.textout(120,71,'ONE THOUSAND ONE HUNDRED NINTETY TWO AND 12/100 ONLY');
    MyCanvas.canvas.textout(120,90,'Amount 2');
    MyCanvas.canvas.textout(750,120,'SUMIO TANGE');

    }


    cAmt    := '';
    cWrdAmt := '';
    cWord1  := '';
    cWord2  := '';
    nEnd    := 82;
    nAmt := cvReport.qryCheck.fieldbyname('amount').asfloat;
    {str(nAmt:10:2,cAmt);}
    cAmt := Format('%n',[nAmt]);
    cAmt := '** ' + cAmt + ' **';
    cWrdAmt := '**' + cvReport.qryCheck.fieldbyname('checkword').asstring + '**';
    while (copy(cwrdamt,nEnd,1) <> ' ') and (length(cwrdamt)> 81) do
    begin
      nEnd := nEnd - 1;
    end;
    cWord1 := copy(cWrdAmt,1,nEnd-1);
    cWord2 := copy(cWrdAMt,nEnd,Length(cWrdAmt));

    mycanvas.canvas.font.size := 6;
    mycanvas.canvas.textout(cvReport.tCompany.fieldbyname('CVNoCol').asinteger,cvReport.tCompany.fieldbyname('CVNoRow').asinteger,cvReport.qryCheck.fieldbyname('cvno').asstring);
    mycanvas.canvas.textout(cvReport.tCompany.fieldbyname('CheckNoCol').asinteger,cvReport.tCompany.fieldbyname('CheckNoRow').asinteger,cvReport.qryCheck.fieldbyname('checkno').asstring);
    mycanvas.canvas.font.size := 10;
    mycanvas.canvas.textout(cvReport.tCompany.fieldbyname('CheckDateCol').asinteger,cvReport.tCompany.fieldbyname('CheckDateRow').asinteger,cvReport.qryCheck.fieldbyname('checkprinted').asstring);
    if (cvReport.qrycheck.fieldbyname('supplier').asboolean = true) then
                                       mycanvas.canvas.textout(cvReport.tCompany.fieldbyname('SupplierCol').asinteger,cvReport.tCompany.fieldbyname('SupplierRow').asinteger,'**'+cvReport.qryCheck.fieldbyname('suppname').asstring+'**')
    else
                                       mycanvas.canvas.textout(cvReport.tCompany.fieldbyname('SupplierCol').asinteger,cvReport.tCompany.fieldbyname('SupplierRow').asinteger,'**'+cvReport.qryCheck.fieldbyname('payeename').asstring+'**');
    mycanvas.canvas.textout(cvReport.tCompany.fieldbyname('CheckAmtCol').asinteger,cvReport.tCompany.fieldbyname('CheckAmtRow').asinteger,camt );
    mycanvas.canvas.textout(cvReport.tCompany.fieldbyname('CheckWord1Col').asinteger,cvReport.tCompany.fieldbyname('CheckWord1Row').asinteger,cWord1);
    mycanvas.canvas.textout(cvReport.tCompany.fieldbyname('CheckWord2Col').asinteger,cvReport.tCompany.fieldbyname('CheckWord2Row').asinteger,cWord2);
    mycanvas.canvas.textout(cvReport.tCompany.fieldbyname('SignatoryCol').asinteger,cvReport.tCompany.fieldbyname('SignatoryRow').asinteger,cvReport.tCompany.fieldbyname('ChkSignatory').asstring);

end;

end.

