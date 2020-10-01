unit brow;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Grids, DBGrids, DB, DBTables, StdCtrls, ExtCtrls, DBCtrls;

type
  TBrowseForm = class(TForm)
    DataSource: TDataSource;
    tUser: TTable;
    Panel1: TPanel;
    DBGrid: TDBGrid;
    Panel2: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Panel3: TPanel;
    btnAdd: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    DBNavigator1: TDBNavigator;
    btnClose: TButton;
    tUserUserName: TStringField;
    tUserPassword: TStringField;
    tUserUserLevel: TSmallintField;
    procedure FormActivate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BrowseForm: TBrowseForm;

implementation

{$R *.DFM}
uses updusr, dlgLog;

procedure TBrowseForm.FormActivate(Sender: TObject);
begin
  DBGrid.SetFocus;
  Edit1.Text:='';
end;

procedure TBrowseForm.Edit1Change(Sender: TObject);
begin
  if (Edit1.Text <> '') then
    if DataSource.DataSet = tUser then tUser.FindNearest([Edit1.Text]);
end;

procedure TBrowseForm.btnAddClick(Sender: TObject);
begin
  if DataSource.DataSet = tUser then
    begin
    tUser.Insert;
    UpdUser.Caption := 'Add User';
    UpdUser.ShowModal;
    end;
end;

procedure TBrowseForm.btnEditClick(Sender: TObject);
begin
  if DataSource.DataSet = tUser then
  begin
    if (tUserUserName.Value = 'SUPERVISOR') then
      showMessage('Cannot edit this record')
    else
      begin
      tUser.Edit;
      UpdUser.Caption := 'Edit User';
      UpdUser.ShowModal;
      end;
  end;
end;

procedure TBrowseForm.btnDeleteClick(Sender: TObject);
begin
  if DataSource.DataSet = tUser then
  begin
    if (tUserUserName.Value = 'SUPERVISOR') or
    (tUserUserName.Value = dlgLogOn.tUser.fieldByName('UserName').asString) then
      showMessage('Cannot delete this record')
    else
      if MessageDlg('Delete record?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
        tUser.Delete;
  end;
end;

procedure TBrowseForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
