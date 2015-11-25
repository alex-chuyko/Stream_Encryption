unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    btn5: TButton;
    btn7: TButton;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    procedure btn5Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure edt1KeyPress(Sender: TObject; var Key: Char);
    procedure edt1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  arrByte = array[1..40] of byte;
  myArr = array [0..100000] of byte;
  mArr = array[0..34] of byte;

var
  Form4: TForm4;
  flagText, flagKey : boolean;
  FileNameText, OutputFileName, OutputKeyFileName: string;
  arr : array[23..40] of arrByte = ((1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  //23
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  //24
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  //25
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  //26
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),  //27
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  //28
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0),  //29
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0),  //30
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0),  //31
                                    (1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0),  //32
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  //33
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0),  //34
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0),  //35
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  //36
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,1,0,0,0,0),  //37
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0),  //38
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0),  //39
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0)); //40

implementation

{$R *.dfm}


procedure TForm4.btn5Click(Sender: TObject);
var
  openDialog : TOpenDialog;
begin
  flagText:= True;
  openDialog := TOpenDialog.Create(openDialog);
  openDialog.Title:= 'Выберите файл для открытия';
  openDialog.InitialDir := GetCurrentDir;
  openDialog.Options := [ofFileMustExist];
  openDialog.Filter := 'Text file|*.*';
  openDialog.FilterIndex := 1;
  if openDialog.Execute then
  begin
    FileNameText:= openDialog.FileName;
  end
  else
    begin
      Application.MessageBox('Выбор файла для открытия остановлен!', 'Предупреждение!');
      flagText:=False;
    end;
  openDialog.Free;

  lbl7.Caption := FileNameText;
end;

/////////////////////////// GEFFE \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

function opr(n : integer): arrByte;
var
  i : integer;
begin
  for i:= 23 to 40 do
  begin
    if i = n then
      opr := arr[i];
  end;
end;

function IntToBin(a: byte): string;
var
  temp : byte;
  str : string;
  counter, i : integer;
begin
  str := '';
  counter := 0;
  while (a <> 0) do
  begin
    inc(counter);
    temp := a mod 2;
    str := IntToStr(temp) + str;
    a := a div 2;
  end;
  if counter < 8 then
    for i:=1 to (8 - counter) do
      str := '0' + str;
  IntToBin := str;
end;

function generKey(var arrKey: mArr; n : integer; arr1 : arrByte): byte;
var
  k, temp, temp2: byte;
  i, j: integer;
begin
    k:= 0;
    k := arrKey[0];
    temp := arrKey[n-1];
    temp2 := 0;
    for j := 1 to n do
      temp2 := temp2 xor (arr1[j] * arrKey[j-1]);
    arrKey[n-1] := temp2;
    for j := 0 to n-3 do
    begin
      arrKey[j] := arrKey[j+1];
    end;
    arrKey[n-2] := temp;
  generKey := k;
end;

procedure TForm4.btn7Click(Sender: TObject);
var
  key1, key2, key3 : string;
  k1, k2, k3, k : byte;
  n1, n2, n3, counterText, i, j : integer;
  arr1, arr2, arr3 : arrByte;
  text, c : myArr;
  arrKey1, arrKey2, arrKey3 : mArr;
  F_text : file of byte;
begin
  counterText := -1;
  key1 := edt1.Text;
  key2 := edt2.Text;
  key3 := edt3.Text;
  n1 := 27;
  n2 := 35;
  n3 := 25;
  
  if flagText then
  begin
    AssignFile(F_text, FileNameText);
    reset(F_text);
    while not Eof(F_text) do
    begin
      inc(counterText);
      read(F_text, text[counterText]);
    end;
    CloseFile(F_text);

    for i:= 1 to length(key1) do
    begin
      arrKey1[i-1] := StrToInt(key1[i]);
    end;
    for i:= 1 to length(key2) do
    begin
      arrKey2[i-1] := StrToInt(key2[i]);
    end;
    for i:= 1 to length(key3) do
    begin
      arrKey3[i-1] := StrToInt(key3[i]);
    end;

    arr1 := opr(n1);
    arr2 := opr(n2);
    arr3 := opr(n3);

    AssignFile(output, FileNameText + '.binInputText');
    rewrite(output);
    for i:= 0 to counterText do
      write(IntToBin(text[i]), ' ');
    CloseFile(output);

    OutputKeyFileName := FileNameText + '.keyGeffe';
    AssignFile(output, OutputKeyFileName);
    rewrite(output);
    AssignFile(input, 'LFSR1_3.bin');
    Rewrite(input);
    for i:= 0 to counterText do
    begin
      k := 0;
      for j:=1 to 8 do
      begin
        k1 := generKey(arrKey1, n1, arr1);
        write(input, k1, ' ');
        k2 := generKey(arrKey2, n2, arr2);
        write(input, k2, ' ');
        k3 := generKey(arrKey3, n3, arr3);
        writeln(input, k3);
        k := k shl 1 + ((k1 and k2) or (not k1 and k3));
      end;
      writeln(input);
      write(IntToBin(k), ' ');
      c[i] := text[i] xor k;
    end;
    CloseFile(input);
    CloseFile(output);

    OutputFileName := FileNameText + '.geffe';
    AssignFile(output, OutputFileName);
    rewrite(output);
    for i:= 0 to counterText do
      write(chr(c[i]));
    CloseFile(output);

    AssignFile(output, OutputFileName + '.geffeBinOutputText');
    rewrite(output);
    for i:= 0 to counterText do
      write(IntToBin(c[i]), ' ');
    CloseFile(output);
  end;
end;

/////////////////////////// GEFFE \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

procedure TForm4.edt1KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in ['0', '1'])) and (not (key = #8)) then
    key := chr(0);
end;

procedure TForm4.edt1Change(Sender: TObject);
begin
  if (length(edt1.Text) = edt1.MaxLength) and (length(edt2.Text) = edt2.MaxLength) and (length(edt3.Text) = edt3.MaxLength) then
    btn7.Enabled := true
  else
    btn7.Enabled := false;
end;

end.
