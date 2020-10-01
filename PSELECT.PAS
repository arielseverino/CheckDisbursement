unit pSelect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Mask, DBCtrls, ExtCtrls;

type
  TfSelect = class(TForm)
    Bevel1: TBevel;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    BtnOk: TButton;
    BtnCancel: TButton;
    Edit1: TEdit;
    Button1: TButton;
    procedure SearchKey(Sender: TObject);
    procedure DBGrid1dblClick(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSelect: TfSelect;

implementation

Uses Mainmenu, BrowSI;

{$R *.DFM}


procedure TfSelect.SearchKey(Sender: TObject);
begin
       if (Edit1.text <> '') then
        mainform.Table1.FindNearest([Edit1.text]);
end;

procedure TfSelect.DBGrid1dblClick(Sender: TObject);
begin
     btnOk.Click
end;

procedure TfSelect.FormClose(Sender: TObject);
begin
     fSelect.close; 
end;

procedure TfSelect.FormActivate(Sender: TObject);
begin
    Edit1.Text:='';
    if Edit1.Enabled then
         Edit1.SetFocus;
end;

end.
