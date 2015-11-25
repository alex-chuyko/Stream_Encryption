unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  arrByte = array[1..40] of byte;
  myArr = array [0..255] of byte;

var
  Form2: TForm2;
  flagText, flagKey : Boolean;
  FileNameText, FileNameKey, OutputFileName, OutputKeyFileName: string;

implementation

{$R *.dfm}


///////////////////////////// RC4 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
procedure TForm2.btn1Click(Sender: TObject);
var
  openDialog : TOpenDialog;
begin
  flagText:= True;
  openDialog := TOpenDialog.Create(openDialog);
  openDialog.Title:= '�������� ���� ��� ��������';
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
      Application.MessageBox('����� ����� ��� �������� ����������!', '��������������!');
      flagText:=False;
    end;
  openDialog.Free;

  lbl1.Caption := FileNameText;
end;

procedure TForm2.btn2Click(Sender: TObject);
var
  openDialog: TOpenDialog;
begin
  flagKey:= True;
  openDialog := TOpenDialog.Create(openDialog);
  openDialog.Title:= '�������� ���� ��� ��������';
  openDialog.InitialDir := GetCurrentDir;
  openDialog.Options := [ofFileMustExist];
  openDialog.Filter := 'Text file|*.txt';
  openDialog.FilterIndex := 1;
  if openDialog.Execute then
  begin
    FileNameKey:= openDialog.FileName;
  end
  else
    begin
      Application.MessageBox('����� ����� ��� �������� ����������!', '��������������!');
      flagKey:=False;
    end;
  openDialog.Free;

  lbl2.Caption := FileNameKey;
end;

procedure TForm2.btn3Click(Sender: TObject);
var
  key, text, k: array[0..100000] of byte;
  s : array[0..255] of byte;
  F_text : file of byte;
  temp : byte;
  i, j, l, counter, counterText : integer;
begin
  counter := -1;
  temp := 0;
  counterText := -1;
  if (flagText) and (flagKey) then
  begin
    AssignFile(input, FileNameKey);
    Reset(input);
    while not Eof(input) do
    begin
      inc(counter);
      read(input, key[counter]);
    end;
    CloseFile(input);

    AssignFile(F_text, FileNameText);
    reset(F_text);
    while not Eof(F_text) do
    begin
      inc(counterText);
      read(F_text, text[counterText]);
    end;
    CloseFile(F_text);

    inc(counter);

    if counter <> 0 then
    begin
      for i:= 0 to 255 do
        s[i] := i;

      j := 0;
      for i:= 0 to 255 do
      begin
        j := (j + s[i] + key[i mod counter]) mod 256;
        temp := s[i];
        s[i] := s[j];
        s[j] := temp;
      end;

      i := 0;
      j := 0;
      temp := 0;
      OutputKeyFileName := FileNameText + '.keyRC4';
      AssignFile(output, OutputKeyFileName);
      rewrite(output);
      for l:= 0 to counterText do
      begin
        i := (i + 1) mod 256;
        j := (j + s[i]) mod 256;
        temp := s[i];
        s[i] := s[j];
        s[j] := temp;
        k[l] := s[(s[i] + s[j]) mod 256];
        write(k[l], ' ');
      end;
      CloseFile(output);;

      OutputFileName := FileNameText + '.RC4';
      AssignFile(output, OutputFileName);
      rewrite(output);
      for i:= 0 to counterText do
      begin
        write(chr(k[i] xor text[i]));
      end;
      CloseFile(output);
    end
    else
      ShowMessage('���� � ������ ����!');
  end;
end;
///////////////////////////// RC4 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

end.
