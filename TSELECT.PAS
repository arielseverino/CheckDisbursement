unit tselect;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Grids, DBGrids, DBCtrls;

type
  TrSelect = class(TForm)
    BtnOk: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    procedure Searchkey(Sender: TObject);
    procedure dbGrid1dblclick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rSelect: TrSelect;

implementation

uses mainmenu;

{$R *.DFM}


procedure TrSelect.Searchkey(Sender: TObject);
begin
    if (Edit1.text <> '') then
         mainform.tReusable1.FindNearest([Edit1.text]);
end;

procedure TrSelect.dbGrid1dblclick(Sender: TObject);
begin
    btnOk.Click
end;

procedure TrSelect.FormActivate(Sender: TObject);
begin
    Edit1.Text:='';
    if Edit1.Enabled then
         Edit1.SetFocus;
end;

end.
