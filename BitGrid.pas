unit BitGrid;

interface

const
  wrap : integer = 8;

var
  cells : array[0..7,0..7] of integer;
  outs  : array[0..7,0..7] of integer;
  ins   : array[0..7,0..7] of integer;

procedure Compute_A;

procedure Compute_B;

implementation


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
        index := index OR (outs[(x+Wrap-1) mod Wrap,y] shl 3);  // left of here * 8
        index := index OR (outs[x,(y+1) mod Wrap] shl 2);       // below here * 4
        index := index OR (outs[(x+1) mod Wrap,y] shl 1);       // right * 2
        index := index OR (outs[x,(y+Wrap-1) mod Wrap]);         // above here
        // figure out the input bits
        // this gets complicated... skip for right now....

        // output is the cell programming shr by the index
        ins[x,y] := index;
        outs[x,y] := (cells[x,y] shr index) AND $01;
      end;
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
        index := index OR (outs[(x+Wrap-1) mod Wrap,y] shl 3);  // left of here * 8
        index := index OR (outs[x,(y+1) mod Wrap] shl 2);       // below here * 4
        index := index OR (outs[(x+1) mod Wrap,y] shl 1);       // right * 2
        index := index OR (outs[x,(y+Wrap-1) mod Wrap]);         // above here
        // figure out the input bits
        // this gets complicated... skip for right now....

        // output is the cell programming shr by the index
        ins[x,y] := index;
        outs[x,y] := (cells[x,y] shr index) AND $01;
      end;
end;

//  $ff00  --- anything from the left
//  $f0f0  --- anything from below
//  $cccc  --- anything from the right
//  $aaaa  --- anything from the above

var
  x,y : integer;
initialization
  for x := 0 to wrap-1 do
    for y := 0 to wrap-1 do
    begin
      ins[x,y] := 0;
      outs[x,y] := 0;
      cells[x,y] := $ff00;
    end;
end.
