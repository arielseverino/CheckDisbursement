unit Dlgrpar5;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Db, DBTables, ComCtrls;

type
  TDlgReportParameter5 = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    sDATE: TDateTimePicker;
    eDate: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    cboxBank: TComboBox;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DlgReportParameter5: TDlgReportParameter5;

implementation

{$R *.DFM}


end.
