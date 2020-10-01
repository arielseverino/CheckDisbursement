unit Updusr;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, Mask, DBCtrls, DB, DBTables, ExtCtrls;

type
  TUpdUser = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DataSource1: TDataSource;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Bevel1: TBevel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdUser: TUpdUser;

implementation

uses Brow,Standard;

{$R *.DFM}

procedure TUpdUser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then
    begin
      BrowseForm.tUser.FieldByName('Password').AsString :=
        Encript(BrowseForm.tUser.FieldByName('Password').AsString);
      BrowseForm.tUser.Post;
    end
  else
    BrowseForm.tUser.Cancel;
end;

procedure TUpdUser.FormActivate(Sender: TObject);
begin
  DBEdit1.Setfocus;
  if not (BrowseForm.tUser.State in [dsInsert]) then
    BrowseForm.tUser.FieldByName('Password').AsString :=
      Decript(BrowseForm.tUser.FieldByName('Password').AsString);
end;

end.
