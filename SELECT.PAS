unit Select;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Grids, DBGrids, DB, DBTables, StdCtrls, ExtCtrls, DBCtrls;

type
  TSelection = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Edit1: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    DBNavigator1: TDBNavigator;
    rgrpOrder: TRadioGroup;
    Bevel1: TBevel;
    Query1: TQuery;
    tPaysetup: TTable;
    tPaysetupKeyField: TIntegerField;
    tPaysetupPeriodFrom: TDateField;
    tPaysetupPeriodTo: TDateField;
    tPaysetupPayType: TStringField;
    tPaysetupDept: TStringField;
    tPaysetupEmpLevel: TStringField;
    tPaysetupPayTypeDesc: TStringField;
    tPaysetupEmpLevelDesc: TStringField;
    tPaysetupDeptDesc: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure rgrpOrderClick(Sender: TObject);
    procedure tPaysetupCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Selection: TSelection;

implementation

{uses Brmfile, Main;}

{$R *.DFM}

procedure TSelection.FormActivate(Sender: TObject);
begin
  Edit1.Text:='';
  if Edit1.Enabled then
    Edit1.SetFocus;
end;

procedure TSelection.Edit1Change(Sender: TObject);
begin
  if (Edit1.Text <> '') then
    if tPaysetup.active = true then
       tPaySetup.FindNearest([Edit1.Text])
    else
       Table1.FindNearest([Edit1.text]);
end;

procedure TSelection.DBGrid1DblClick(Sender: TObject);
begin
  btnOk.Click;
end;

procedure TSelection.rgrpOrderClick(Sender: TObject);
begin
  if table1.active = true then
     begin
          if rgrpOrder.itemIndex = 0 then
             Table1.IndexName := ''
          else if rgrpOrder.itemIndex = 1 then
               Table1.IndexName := 'ByName';
      end;
end;

procedure TSelection.tPaysetupCalcFields(DataSet: TDataSet);
begin
  if tPaysetupPaytype.asString = '0' then tPaysetupPaytypeDesc.value := 'Semi-monthly'
  else if tPaysetupPaytype.asString = '1' then tPaysetupPaytypeDesc.value := 'Incentive'
  else if tPaysetupPaytype.asString = '2' then tPaysetupPaytypeDesc.value := '13th Month Pay'
  else if tPaysetupPaytype.asString = '3' then tPaysetupPaytypeDesc.value := 'Weekly';
end;

end.
