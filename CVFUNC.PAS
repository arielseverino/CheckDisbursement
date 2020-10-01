unit cvfunc;

interface

uses Dialogs, SysUtils, WinTypes, WinProcs, Classes, DBTables;

Function DelSP(sMOney:string):string;
Function ConvOne(sMoney:string):string;
Function ConvTen(sMoney:string):string;
Function ConvHundred(smoney:string):string;
Function ConvThousand(smoney:string):string;
Function ConvMillion(smoney:string):string;
Function Parse(smoney:string):string;
Function ConvAmt(smoney:string):string;
Function PadLZero(ncvno,nlen :integer):string;
Function PadChar(ctype:string;cString:string;cchar:string;nlen :integer):string;

implementation

{uses}

Function ConvAmt(sMoney:string):string;
var sCash : string;
    L     : integer;
    nMoney: real;
begin
    sMoney := delsp(smoney);
    L := length(smoney);
    nMoney := strtofloat(smoney);
    {million}
    if nMoney > 999999.99 then
         sCash := ConvMillion(copy(sMoney,1,L-9))  + ' ' +
                  ConvThousand(copy(sMoney,L-8,3)) + ' ' +
                  ConvHundred(copy(sMoney,L-5,3))  + ' PESOS'
    else
         if nMoney > 999.99 then
              sCash := ConvThousand(copy(sMoney,1,L-6)) + ' ' +
                       ConvHundred(copy(sMoney,L-5,3))  + ' PESOS'
         else
              sCash := ConvHundred(copy(sMoney,1,L-3)) + ' PESOS';
    result := sCash;
end;


Function ConvMillion(smoney:string):string;
begin
    result := parse(smoney) + ' MILLION';
end;

Function ConvThousand(smoney:string):string;
begin
    if strtoint(smoney) <> 0 then
         result := Parse(smoney)+ ' THOUSAND'
    else
         result := ''
end;

Function ConvHundred(smoney:string):string;
begin
    result := Parse(smoney);
end;

Function Parse(smoney:string):string;
var HundWrd,TenWrd,OneWrd : string;
    nMoney                : real;
begin
    nMoney := strtofloat(smoney);
    sMoney := floattostr(nMoney);
    if nMoney > 99 then
         begin
              HundWrd := ConvOne(copy(smoney,1,1)) + ' HUNDRED';
              if (copy(smoney,2,2) <> '00') then
                   if (copy(smoney,2,1) = '1') then
                        TenWrd := ConvTen(copy(smoney,2,2))
                   else
                        begin
                             TenWrd := ConvTen(Copy(smoney,2,2));
                             OneWrd := ConvOne(Copy(smoney,3,1));
                        end;
         end
    else
        if nMoney > 9 then
              if (copy(smoney,1,1) = '1') then
                   TenWrd := ConvTen(copy(smoney,1,2))
              else
                   begin
                        TenWrd := ConvTen(Copy(smoney,1,2));
                        OneWrd := ConvOne(Copy(smoney,2,1));
                   end
        else
              OneWrd := ConvOne(copy(smoney,length(smoney),1));
result := HundWrd + ' '+ TenWrd + ' '+ OneWrd;
end;


Function ConvTen(smoney:string):string;
begin
if (StrtoInt(sMoney) < 20) then
    case StrtoInt(sMoney) of
         10: result := 'TEN';
         11: result := 'ELEVEN';
         12: result := 'TWELVE';
         13: result := 'THIRTEEN';
         14: result := 'FOURTEEN';
         15: result := 'FIFTEEN';
         16: result := 'SIXTEEN';
         17: result := 'SEVENTEEN';
         18: result := 'EIGHTEEN';
         19: result := 'NINETEEN';
    else
         result := '';
    end
else
    case StrtoInt(copy(sMoney,1,1)) of
         2: result := 'TWENTY';
         3: result := 'THIRTY';
         4: result := 'FOURTY';
         5: result := 'FIFTY';
         6: result := 'SIXTY';
         7: result := 'SEVENTY';
         8: result := 'EIGHTY';
         9: result := 'NINETY';
    else
         result := ' ';
    end;
end;

Function ConvOne(sMoney:string):string;
begin
    case StrtoInt(sMoney) of
         1: result := 'ONE';
         2: result := 'TWO';
         3: result := 'THREE';
         4: result := 'FOUR';
         5: result := 'FIVE';
         6: result := 'SIX';
         7: result := 'SEVEN';
         8: result := 'EIGHT';
         9: result := 'NINE';
    else
         result := '';
    end;
end;

function Delsp(smoney:string):string;
var K : integer;
    newmoney : string;
begin
    for k:=1 to length(smoney) do
    begin
         if smoney[k] <> ' ' then
             newmoney := newmoney + copy(smoney,k,1)
    end;
    result := newmoney;
end;

Function padLzero(ncvno,nLen :integer):string;
var K : integer;
    ccvno : string;
begin
    for k := 1 to (nLen-length(inttostr(ncvno))) do
    begin
         ccvno := ccvno + '0';
    end;
    result := ccvno + inttostr(ncvno);
end;

Function PadChar(ctype:string;cString:string;cchar:string;nlen :integer):string;

var K : integer;
begin
    for k := 1 to (nLen-length(cstring)) do
    begin
       if cType = 'L' then
         cstring := cchar + cstring;
       if ctype = 'R' then
         cstring := cstring + cchar;
    end;
    result := cstring;
end;

end.
