unit UpdCheck;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Mask, ExtCtrls, Db;

type
  TUpdChk = class(TForm)
    Button1: TButton;
    Button2: TButton;
    dsBank: TDataSource;
    Bevel1: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dbmRemark: TDBMemo;
    dbeOrNo: TDBEdit;
    dbeCheckNo: TDBEdit;
    DBText1: TDBText;
    dbeSuppCode: TDBEdit;
    dbeCVNo: TDBEdit;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    dbeDatePaid: TDBEdit;
    DBText2: TDBText;
    Label10: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdChk: TUpdChk;

implementation

{$R *.DFM}





end.
