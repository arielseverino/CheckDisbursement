unit UpdSupplier;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DBCtrls, Db, jpeg;

type
  TUpdSupp = class(TForm)
    dsSupplier: TDataSource;
    pnlHeader: TPanel;
    Image1: TImage;
    Label10: TLabel;
    pnlDetail: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Remark: TLabel;
    DBEdit1: TDBEdit;
    dbeTin: TDBEdit;
    dbePosition: TDBEdit;
    dbeContPerson: TDBEdit;
    dbeEmail: TDBEdit;
    dbeFaxno: TDBEdit;
    dbeSupptel: TDBEdit;
    dbeSuppAdd: TDBEdit;
    dbeSuppName: TDBEdit;
    dbeSuppCode: TDBEdit;
    pnlButton: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdSupp: TUpdSupp;

implementation

uses BrowSupplier;

{$R *.DFM}

procedure TUpdSupp.FormActivate(Sender: TObject);
begin
     dbeSuppCode.SetFocus;
end;

procedure TUpdSupp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if Modalresult=mrOk then
       begin
            BrowSupp.tSupplier.post;
       end
    else
       BrowSupp.tSupplier.Cancel;
end;

end.
