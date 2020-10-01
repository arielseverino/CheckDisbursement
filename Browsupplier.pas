unit BrowSupplier;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, StdCtrls, ExtCtrls, DBCtrls, Buttons, jpeg;

type
  TBrowSupp = class(TForm)
    DBGrid1: TDBGrid;
    dsSupplier: TDataSource;
    tSupplier: TTable;
    pnlDetail: TPanel;
    Panel2: TPanel;
    Bevel1: TBevel;
    DBNavigator1: TDBNavigator;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    pnlHeader: TPanel;
    Image1: TImage;
    Label1: TLabel;
    procedure AddSupplier(Sender: TObject);
    procedure EditSupplier(Sender: TObject);
    procedure DeleteSupplier(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BrowSupp: TBrowSupp;

implementation

uses UpdSupplier;

{$R *.DFM}

procedure TBrowSupp.AddSupplier(Sender: TObject);
begin
     UpdSupp := tUpdSupp.create(application);
     tSupplier.Insert;
     UpdSupp.Caption := 'Add Supplier';
     UpdSupp.ShowModal;
     UpdSupp.free;
end;

procedure TBrowSupp.EditSupplier(Sender: TObject);
begin
     if dsSupplier.dataset.RecordCount = 0 then
        ShowMessage('Operation not supported.')
     else
        begin
             tSupplier.Edit;
             UpdSupp := tUpdSupp.Create(application);
             UpdSupp.Caption := 'Edit Supplier';
             UpdSupp.dbeSuppCode.ReadOnly := true;
             UpdSupp.ShowModal;
             UpdSupp.dbeSuppCode.ReadOnly := false; 
        end;
end;

procedure TBrowSupp.DeleteSupplier(Sender: TObject);
begin
     if dsSupplier.dataset.recordcount = 0 then
        ShowMessage('Operation not supported.')
     else
        if MessageDlg('Delete current record ?',mtconfirmation,[mbYes,mbNo],0) = mrYes then
        begin
          tSupplier.Delete;
        end;
end;

procedure TBrowSupp.FormActivate(Sender: TObject);
begin
    tSupplier.Active := true;
end;

procedure TBrowSupp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    tSupplier.Active := false; 
end;

end.
