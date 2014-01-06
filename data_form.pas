unit data_form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, BitGrid, Menus, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Button3: TButton;
    Button4: TButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    Help1: TMenuItem;
    AboutBitGrid1: TMenuItem;
    Timer1: TTimer;
    ools1: TMenuItem;
    Run1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Memo2Exit(Sender: TObject);
    procedure AboutBitGrid1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Run1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  VersionString : String = '0.03';
var
  Form1: TForm1;

implementation

{$R *.dfm}

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

  form1.statusbar1.panels[0].text := 'Cycles : '+IntToStr(cycles);
end; // dump_stuff

procedure TForm1.AboutBitGrid1Click(Sender: TObject);
begin
  ShowMessage('BitGrid Simulator - Version '+VersionString);
end;

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

procedure TForm1.Run1Click(Sender: TObject);
begin
 Run1.Checked := NOT Run1.Checked;
 Timer1.Enabled := Run1.Checked;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Compute_A;
  Compute_B;
  dump_stuff;
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

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Button3.Click;
end;

end.
