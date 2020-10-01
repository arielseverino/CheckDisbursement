unit BrmFIle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, ComCtrls, Buttons, ExtCtrls, DBCtrls,
  ToolWin, StdCtrls, jpeg;

type
  TBrowFormMFiles = class(TForm)
    ToolBar1: TToolBar;
    DBNavigator1: TDBNavigator;
    sBtnAdd: TSpeedButton;
    sBtnDelete: TSpeedButton;
    sBtnEdit: TSpeedButton;
    pagecontrol: TPageControl;
    dsReference: TDataSource;
    tAccount: TTable;
    tsAccount: TTabSheet;
    tsDepartment: TTabSheet;
    tsBank: TTabSheet;
    tsTerm: TTabSheet;
    tDepartment: TTable;
    tBank: TTable;
    tTerm: TTable;
    DBAccount: TDBGrid;
    dbDepartment: TDBGrid;
    dbBank: TDBGrid;
    DBterm: TDBGrid;
    tAccountAccountcode: TStringField;
    tAccountDeptCode: TStringField;
    tAccountType: TStringField;
    tAccountCode: TStringField;
    tAccountAccountName: TStringField;
    pnlHeader: TPanel;
    Image1: TImage;
    Label3: TLabel;
    procedure pagecontrolchange(Sender: TObject);
    procedure AddReference(Sender: TObject);
    procedure EditReference(Sender: TObject);
    procedure DeleteReference(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BrowFormMFiles: TBrowFormMFiles;

implementation

{$R *.DFM}

procedure TBrowFormMFiles.pagecontrolchange(Sender: TObject);
begin
  case PageControl.ActivePage.TabIndex of
    0: tAccount.active:= true;
    1: tDepartment.active:=true;
    2: tBank.active:=true;
    3: tTerm.active:=true;
  end;

  case PageControl.ActivePage.TabIndex of
    0: dsReference.DataSet := tAccount;
    1: dsReference.DataSet := tDepartment;
    2: dsReference.DataSet := tBank;
    3: dsReference.DataSet := tTerm;
  end;
  dsReference.dataSet.refresh;
end;

procedure TBrowFormMFiles.AddReference(Sender: TObject);
begin
    if dsReference.DataSet=tAccount then tAccount.Append
    else if dsReference.DataSet=tDepartment then tDepartment.Append
    else if dsReference.DataSet=tBank then tBank.Append
    else if dsReference.DataSet=tTerm then tTerm.Append;
end;

procedure TBrowFormMFiles.EditReference(Sender: TObject);
begin
    if dsReference.DataSet=tAccount then tAccount.Edit
    else if dsReference.DataSet=tDepartment then tDepartment.Edit
    else if dsReference.DataSet=tBank then tBank.Edit
    else if dsReference.DataSet=tTerm then tTerm.Edit;
end;

procedure TBrowFormMFiles.DeleteReference(Sender: TObject);
begin
    if (dsReference.dataset.recordcount=0) then
         showmessage('Operation not supported')
    else if messagedlg('Delete current record?',mtconfirmation,[mbYes,mbNo],0) = mrYes then
    begin
         if dsReference.DataSet=tAccount then tAccount.Delete
         else if dsReference.DataSet=tDepartment then tDepartment.Delete
         else if dsReference.DataSet=tBank then tBank.Delete
         else if dsReference.DataSet=tTerm then tTerm.Delete
    end;
end;


end.



