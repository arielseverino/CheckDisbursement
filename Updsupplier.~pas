unit UpdSupplier;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DBCtrls, Db;

type
  TUpdSupp = class(TForm)
    dbeSuppCode: TDBEdit;
    dbeSuppName: TDBEdit;
    dbeSuppAdd: TDBEdit;
    dbeSupptel: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    dsSupplier: TDataSource;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dbeFaxno: TDBEdit;
    dbeEmail: TDBEdit;
    dbeContPerson: TDBEdit;
    dbePosition: TDBEdit;
    Label9: TLabel;
    dbeTin: TDBEdit;
    Remark: TLabel;
    DBEdit1: TDBEdit;
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
