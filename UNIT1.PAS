unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,Printers;

type
  TForm1 = class(TForm)
    Button1: TButton;
    PrintDialog1: TPrintDialog;
    FontDialog1: TFontDialog;
    procedure proc(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.proc(Sender: TObject);
var
    PrnCheck  : TPrinter;
    Printtext : system.text;
    {Bitmap : tBitmap;}
begin
    PrnCheck := TPrinter.Create;
    {
    PrnCheck.Newpage;
    PrnCheck.begindoc;
    PrnCheck.Canvas.TextOut(1,1,'11111');
    prncheck.enddoc;
    PrnCheck.Destroy;      }
if printdialog1.execute then
begin
    printer.orientation:=poPortrait;
    AssignPrn(PrintText);
    Rewrite(PrintText);
    try
    begin
         {printer.canvas.penpos(10,5);}
         {printer.canvas.moveto(40,50);}
         printer.canvas.Font.size := 8;
         printer.canvas.TextOut(750,1,'000007');
         printer.canvas.TextOut(750,20,'104461');
         printer.canvas.Font.size := 12;
         printer.canvas.TextOut(900,70,'Jan. 05, 2001');
         printer.canvas.TextOut(120,150,'**HOME CREDIT MUTUAL BUILDING & LOAN ASSOCIATION**');
         printer.canvas.TextOut(1050,150,'**39,239.40**');
         printer.canvas.TextOut(120,200,'**EIGHT THOUSAND AND TWO HUNDRED NINETY PESOS**');
         {
         writeln(PrintText,'Ariel');
         printer.canvas.font.size := 8;
         writeln(PrintText,'SEVERIN0');}
    end
    finally
         Closefile(PrintText);
end;
end;
    {
    Canvas.TextOut(1,1,'11111');
    canvas.TextOut(3,1,'22222');
    canvas.TextOut(5,1,'33333');

    bitmap := tBitmap.create;
    try
         with Bitmap do
         begin
              loadfromfile('a:\factory.bmp');
              transparent := true;
              Transparentcolor := Bitmap.canvas.pixels[50,50];
              form1.canvas.Draw(0,0,bitmap);
              transparentmode:=tmAuto;
              Form1.canvas.draw(50,50,bitmap);
         end;
    finally
         bitmap.free;}
end;
end.
