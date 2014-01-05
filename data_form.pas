unit data_form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, BitGrid;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Memo2Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function GetHex(var s : string):integer;
var
  x : integer;
begin
  x := 0;
  while (length(s) > 0) AND (s[1] = ' ') do delete(s,1,1);   // strip off leading spaces
  while (length(s) > 0) AND (s[1] in ['0'..'9','A'..'F','a'..'f']) do
  begin
    case s[1] of
      '0'..'9' : x := (x * 16)      + (ord(s[1])-ord('0'));
      'A'..'F' : x := (x * 16) + 10 + (ord(s[1])-ord('A'));
      'a'..'f' : x := (x * 16) + 10 + (ord(s[1])-ord('a'));
    end;
    delete(s,1,1);
  end;
  gethex := x;
end;

procedure dump_stuff;
var
  x,y : integer;
  s   : string;
begin
  form1.Memo1.Lines.Clear;
  form1.Memo1.Lines.Append('Program State:');
  for y := 0 to wrap-1 do
  begin
    s := '';
    for x := 0 to wrap-1 do
      s := s + inttohex(cells[x,y],4) + ' ';
    form1.Memo1.lines.Append(s);
  end; // for y

  form1.Memo1.Lines.Append('Input State:');
  for y := 0 to wrap-1 do
  begin
    s := '';
    for x := 0 to wrap-1 do
      s := s + inttohex(ins[x,y],4) + ' ';
    form1.Memo1.lines.Append(s);
  end; // for y

  form1.Memo1.Lines.Append('Output State:');
  for y := 0 to wrap-1 do
  begin
    s := '';
    for x := 0 to wrap-1 do
      s := s + inttohex(outs[x,y],4) + ' ';
    form1.Memo1.lines.Append(s);
  end; // for y
end; // dump_stuff

procedure TForm1.Button1Click(Sender: TObject);
begin
  compute_a;
  dump_stuff;
end;

procedure TForm1.Memo2Exit(Sender: TObject);
var
  x,y : integer;
  s   : string;
begin
  for y := 0 to wrap-1 do
  begin
    s := form1.Memo2.Lines.Strings[y];
    for x := 0 to wrap-1 do
      cells[x,y] := gethex(s);
  end; // for y
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  compute_b;
  dump_stuff;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  x,y : integer;
  s   : string;
begin
  form1.Memo2.Lines.Clear;
  for y := 0 to wrap-1 do
  begin
    s := '';
    for x := 0 to wrap-1 do
      s := s + ' ' + inttohex(cells[x,y],4);
    form1.Memo2.lines.Append(s);
  end; // for y
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  x,y : integer;
  s   : string;
begin
  for y := 0 to wrap-1 do
  begin
    s := form1.Memo2.Lines.Strings[y];
    for x := 0 to wrap-1 do
      cells[x,y] := gethex(s);
  end; // for y
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Button3.Click;
end;

end.
