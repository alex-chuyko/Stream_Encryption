unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    lbl3: TLabel;
    lbl5: TLabel;
    btn4: TButton;
    btn6: TButton;
    edt1: TEdit;
    procedure btn4Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure edt1KeyPress(Sender: TObject; var Key: Char);
    procedure edt1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  arrByte = array[1..40] of byte;
  myArr = array [0..255] of byte;

var
  Form3: TForm3;
  flagText, flagKey : boolean;
  FileNameText, FileNameKey, OutputFileName, OutputKeyFileName: string;
  arr : array[23..40] of arrByte = ((1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0),
                                    (1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,1,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0),
                                    (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0));

implementation

{$R *.dfm}

procedure TForm3.btn4Click(Sender: TObject);
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

  lbl3.Caption := FileNameText;
end;

/////////////////////////// LFSR1 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
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

procedure TForm3.btn6Click(Sender: TObject);
var
  key : string;
  k, temp, temp2 : byte;
  n, i, j, l, counterText : integer;
  arr1 : arrByte;
  text, c : array [0..100000] of byte;
  arrKey : array[0..26] of byte;
  F_text : file of byte;
begin
  key := edt1.Text;
  n := 27;
  counterText := -1;

  arr1 := opr(n);
  if (flagText) then
  begin

    AssignFile(F_text, FileNameText);
    reset(F_text);
    while not Eof(F_text) do
    begin
      inc(counterText);
      read(F_text, text[counterText]);
    end;
    CloseFile(F_text);

    for i:= 1 to length(key) do
    begin
      arrKey[i-1] := StrToInt(key[i]);
    end;

    AssignFile(output, FileNameText + '.binInputText');
    rewrite(output);
    for i:= 0 to counterText do
      write(IntToBin(text[i]), ' ');
    CloseFile(output);

///////////////////////// generation key
    OutputKeyFileName := FileNameText + '.keyBin';
    AssignFile(output, OutputKeyFileName);
    rewrite(output);
    for i:= 0 to counterText do
    begin
      k:= 0;
      for l:= 1 to 8 do
      begin
        k := k shl 1 + arrKey[0];
      //mmo2.Text := mmo2.Text + IntToStr(k);
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
       end;
       c[i] := text[i] xor k;
       write(IntToBin(k), ' ');
    end;
    CloseFile(output);
////////////////////////////////////////

    //mmo2.Text := mmo2.Text + #13#10;
    //for i:= 0 to counterText do
      //mmo1.Text := mmo1.Text + IntToBin(text[i]) + ' ';

    OutputFileName := FileNameText + '.lfsr1';
    AssignFile(output, OutputFileName);
    rewrite(output);
    for i:= 0 to counterText do
      write(chr(c[i]));
    CloseFile(output);
    AssignFile(output, OutputFileName + '.binOutputText');
    rewrite(output);
    for i:=0 to counterText do
      write(IntToBin(c[i]), ' ');
    CloseFile(output);
  end;
end;

/////////////////////////// LFSR1 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


procedure TForm3.edt1KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in ['0', '1'])) and (not (key = #8)) then
    key := chr(0);
end;

procedure TForm3.edt1Change(Sender: TObject);
begin
  if (length(edt1.Text) = edt1.MaxLength) then
    btn6.Enabled := true
  else
    btn6.Enabled := false;
end;

end.
