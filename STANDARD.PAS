unit Standard;

interface
uses  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, DBLookup, StdCtrls, DB, DBTables, Buttons, Spin, Grids,
  DBGrids,Printers;

{function AccessValid(Name:string;Level:integer):Boolean;}
function Encrypt(S,C:String):String;
function Encript(S:String):String;
function Decript(S:String):String;
// function SameValueFound(FieldsPhrase:String):Boolean;

implementation

uses MainMenu;

{
function AccessValid(Name:string;Level:integer):Boolean;
begin
  Result:=False;
  if UpdSecurity.tSecurity.FindKey([Level,Name]) then
    if UpdSecurity.tSecurity.FieldByName('Authorize').AsString = 'Y' then
      Result:=True;
  if Result=False then messageDlg('Unauthorized Access',mtError,[mbOk],0);
end;}

function Encrypt(S,C:String):String;

{Description: ENCRYPT searches in S a character between 0 and 9 and converts it
              into letters specified in C. }

var Encrypted: String;
    x: SmallInt;

begin
  Encrypted:='';
  C:=UpperCase(C);
  if length(C)< 10 then
     for x:=1 to 10-length(C) do
       C:=C+' ';
  for x := 1 to length(S) do
    begin
      if (S[x]>=chr(48)) and (S[x]<=chr(57)) then
          Encrypted:=Encrypted+C[strToInt(S[x])+1]
      else if S[x]=chr(46) then Encrypted := Encrypted+'-';
    end;
  Result:= Encrypted;
end;

function Encript(S:String):String;
var NewWord : String;
    ctr : Smallint;
begin
  NewWord := '' ;
  S := UpperCase(S);
  for ctr := 1 to length(S) do
     NewWord := NewWord + Chr(Ord(S[ctr])+ctr);
  Result := NewWord;
end;

function Decript(S:String):String;
var NewWord : String;
    ctr : Smallint;
begin
  NewWord := '' ;
  S := UpperCase(S);
  for ctr := 1 to length(S) do
     NewWord := NewWord + Chr(Ord(S[ctr])-ctr);
  Result := NewWord;
end;

{
function SameValueFound(FieldsPhrase:String):Boolean;
var CursorStd,CursorWait: HCursor;
begin
  CursorWait:=LoadCursor(0,IDC_ARROW);
  SetCursor(CursorWait);

  MainForm.qryReusable1.open;
  MainForm.qryReusable1.first;
  if MainForm.qryReusable1.Fields[0].isNull then
    result := false
  else
    begin
      messageDlg('Attempting to make double entry transaction.  Check out for fields ' +
      FieldsPhrase + '.', mtError,[mbOk],0);
      result := true;
    end;

  MainForm.qryReusable1.close;

  CursorStd:=LoadCursor(0,IDC_WAIT);
  SetCursor(CursorStd);
end;
}

end.
