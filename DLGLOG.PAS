unit dlgLog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Db, DBTables, Dialogs, jpeg, ExtCtrls;

type
  TDlgLogOn = class(TForm)
    tUser: TTable;
    tCompany: TTable;
    Panel1: TPanel;
    Image1: TImage;
    OKBtn: TButton;
    CancelBtn: TButton;
    UserName: TEdit;
    Password: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DlgLogOn: TDlgLogOn;

implementation

uses Standard;

{$R *.DFM}

procedure TDlgLogOn.FormClose(Sender: TObject; var Action: TCloseAction);
var UserOk, AccessOk: Boolean;
begin
  if modalResult = mrCancel then tag := 1
  else
    begin
      UserOk := tUser.Findkey([UserName.Text]);
      AccessOk := (tUser.fieldByName('Password').Value = Encript(Password.Text));
      if (UserOk and AccessOk) then
      begin
          tCompany.active := true;
          tCompany.edit;
          tCompany.fieldbyname('userlevel').asInteger := tuser.fieldbyname('userlevel').asinteger;
          tCompany.post;
          tCompany.active := false; 
          tag := 0;
      end
      else
        begin
          hide;
          showMessage('Invalid User Name/Password');
          tag := 1;
        end;
    end;
end;

end.

