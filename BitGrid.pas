unit BitGrid;

interface
uses
  classes;


procedure Compute_A;                       // does all the computing for set A

procedure Compute_B;                       // does all the computing for set B

function GetHex(var s : string):integer;   // gets a hex string, killing any leading spaces

procedure SaveTo(filename : string);       // saves the program to a file

function  GetCycleCount : LongInt;         // how many cycles have we comptued so far?

procedure DumpStateTo(o : TStrings);       // dump the current cells, inputs, outputs to a list

procedure LoadCellsFrom(o : TStrings);     // reload the program from a list

procedure SaveCellsTo(o : TStrings);        // save program cells to a string list

implementation

uses
  sysutils;

const
  wrap = 8;

type
  TBitGridCell = Class(TObject)
    Instruction : integer;
    Index       : integer;
    Result      : integer;
  End;

var
  cycles : longint;
  cells : array[0..wrap-1,0..wrap-1] of TBitGridCell;

procedure compute_a;
var
  x,y : integer;
  index   : integer;
begin
  for x := 0 to wrap-1 do
    for y := 0 to wrap-1 do
      if ((x+y) mod 2) = 0 then   // only do  phase 1 cells
      begin
        index := 0;
        index := index OR (cells[(x+Wrap-1) mod Wrap,y].Result shl 3);  // left of here * 8
        index := index OR (cells[x,(y+1) mod Wrap].Result shl 2);       // below here * 4
        index := index OR (cells[(x+1) mod Wrap,y].Result shl 1);       // right * 2
        index := index OR (cells[x,(y+Wrap-1) mod Wrap].Result);         // above here
        // figure out the input bits
        // this gets complicated... skip for right now....

        // output is the cell programming shr by the index
        cells[x,y].index := index;
        cells[x,y].result := (cells[x,y].Instruction shr index) AND $01;
      end;
  inc(cycles);

end;

procedure compute_b;
var
  x,y : integer;
  index   : integer;
begin
  for x := 0 to wrap-1 do
    for y := 0 to wrap-1 do
      if ((x+y) mod 2) <> 0 then   // only do  phase 2 cells
      begin
        index := 0;
        index := index OR (cells[(x+Wrap-1) mod Wrap,y].Result shl 3);  // left of here * 8
        index := index OR (cells[x,(y+1) mod Wrap].Result shl 2);       // below here * 4
        index := index OR (cells[(x+1) mod Wrap,y].Result shl 1);       // right * 2
        index := index OR (cells[x,(y+Wrap-1) mod Wrap].Result);         // above here
        // figure out the input bits
        // this gets complicated... skip for right now....

        // output is the cell programming shr by the index
        cells[x,y].index := index;
        cells[x,y].result := (cells[x,y].Instruction shr index) AND $01;
      end;
end;


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

procedure SaveTo(filename : string);
var
  f : text;
  s : string;
  x,y : integer;
begin
  assign(f,filename);
  rewrite(f);
  for y := 0 to wrap-1 do
  begin
    s := '';
    for x := 0 to wrap-1 do
      s := s + inttohex(cells[x,y].Instruction,4) + ' ';
    writeln(f,s);
  end; // for y
  close(f);
end;

function GetCycleCount : LongInt;
begin
  GetCycleCount := Cycles;
end;

procedure DumpStateTo(o : TStrings);
var
  x,y : integer;
  s   : string;
begin
  o.Clear;
  o.Append('Program State:');
  for y := 0 to wrap-1 do
  begin
    s := '';
    for x := 0 to wrap-1 do
      s := s + inttohex(cells[x,y].Instruction,4) + ' ';
    o.Append(s);
  end; // for y

  o.Append('Input State:');
  for y := 0 to wrap-1 do
  begin
    s := '';
    for x := 0 to wrap-1 do
      s := s + inttohex(cells[x,y].Index,4) + ' ';
    o.Append(s);
  end; // for y

  o.Append('Output State:');
  for y := 0 to wrap-1 do
  begin
    s := '';
    for x := 0 to wrap-1 do
      s := s + inttohex(cells[x,y].Result,4) + ' ';
    o.Append(s);
  end; // for y
end;

procedure LoadCellsFrom(o : TStrings);     // reload the program from a list
var
  x,y : integer;
  s   : string;
begin
  for y := 0 to wrap-1 do
  begin
    s := o.Strings[y];
    for x := 0 to wrap-1 do
      cells[x,y].Instruction := gethex(s);
  end; // for y
end;

procedure SaveCellsTo(o : TStrings);        // save program cells to a string list
var
  x,y : integer;
  s   : string;
begin
  o.Clear;
  for y := 0 to wrap-1 do
  begin
    s := '';
    for x := 0 to wrap-1 do
      s := s + ' ' + inttohex(cells[x,y].Instruction,4);
    o.Append(s);
  end; // for y
end;

//  $ff00  --- anything from the left
//  $f0f0  --- anything from below
//  $cccc  --- anything from the right
//  $aaaa  --- anything from the above

var
  x,y : integer;
initialization
  cycles := 0;
  for x := 0 to wrap-1 do
    for y := 0 to wrap-1 do
    begin
      cells[x,y] := TBitGridCell.Create;   // set up the cell
      {
        This isn't kosher, but works for now... we're directly stuffing
        values into the internal fields of an object, instead
        of letting it set itself up. This is transistion code that should go away
      }
      cells[x,y].Instruction := $ff00;     // default to just copy from the left
      cells[x,y].Index := 0;
      cells[x,y].Result := 0;
    end;
end.
