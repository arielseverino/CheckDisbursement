unit dlgrpar1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls;

type
  TdlgReportParameter1 = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    sCheckNo: TEdit;
    eCheckNo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox : TGroupBox;
    Label3: TLabel;
    cboxBank: TComboBox;
    procedure FromExit(Sender: TObject);
    procedure ToExit(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure formactivate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgReportParameter1: TdlgReportParameter1;

implementation

uses BrmFile, mainmenu;

{$R *.DFM}

procedure TdlgReportParameter1.btnOkClick(Sender: TObject);
var nSCheckNo,nError : integer;
begin
    val(sCheckNo.text,nSCheckNo,nError);
    if nError<>0 then
        showmessage('Invalid Start Check No. !!!')
    else
        begin
             val(eCheckNo.text,nSCheckNo,nError);
             if nError<>0 then
                Showmessage('Invalid End Check No. !!!');
        end;
end;
procedure TdlgReportParameter1.FromExit(Sender: TObject);
var nSCheckNo,nError : integer;

begin
    val(sCheckNo.text,nSCheckNo,nError);
    if nError<>0 then
        showmessage('numeric field only');
end;

procedure TdlgReportParameter1.ToExit(Sender: TObject);
var nSCheckNo,nError : integer;

begin
    val(eCheckNo.text,nSCheckNo,nError);
    if nError<>0 then
        showmessage('numeric field only');
end;


procedure TdlgReportParameter1.formactivate(Sender: TObject);
begin

  cboxBank.items.clear;

  mainForm.tReusable1.close;
  mainForm.tReusable1.databaseName := 'AccountData';
  mainForm.tReusable1.tableName := 'Bank.db';
  mainForm.tReusable1.open;
  mainForm.tReusable1.first;
  while not mainForm.tReusable1.eof do
  begin
    cboxBank.items.add( mainForm.tReusable1.fieldByName('BankName').asString );
    mainForm.tReusable1.next;
  end;
  mainForm.tReusable1.close;
  mainForm.tReusable1.databaseName := '';
  mainForm.tReusable1.tableName := '';
  mainForm.tReusable1.indexName := '';

  cboxBank.itemIndex := 0;

end;


end.
