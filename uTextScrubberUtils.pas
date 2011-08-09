unit uTextScrubberUtils;

interface

uses
       uTextScrubberTypes
     , uTextScrubberConsts
     ;

function DeleteLineBreaks(const S: string): string; overload;
procedure DeleteLineBreaks(aPChar: PChar); overload;
function ManageRunOnStartup(aProgTitle, aCmdLine : string; aRunOnce: TRunType ): Boolean;

implementation

uses
  StrUtils,
  SysUtils,
  Registry,
  Windows
;

function DeleteLineBreaks(const S: string): string;
begin
  Result := ReplaceText(S, #13, '');
  Result := ReplaceText(Result, #10, '');
end;

procedure DeleteLineBreaks(aPChar: PChar); overload;
var
  TempStr: string;
begin
  TempStr := string(aPChar);
  TempStr := DeleteLineBreaks(TempStr);
  aPChar := StrAlloc(Length(TempStr));
  StrPCopy(aPChar, TempStr);
end;

function ManageRunOnStartup(aProgTitle, aCmdLine : string; aRunOnce: TRunType ): Boolean;
var
  sKey: string;
  R: TRegistry;
  AlreadyExists: Boolean;
begin
  sKey := 'Software\Microsoft\Windows\CurrentVersion\Run';
  R := TRegistry.Create;
  R.RootKey := HKEY_CURRENT_USER;
  AlreadyExists := R.OpenKey(sKey, True) and R.ValueExists(aProgTitle);
  if AlreadyExists and (aRunOnce = rtRunAlways) then
  begin
    Exit;
  end;

  try
    case aRunOnce of
      rtRunAlways: begin
                     R.WriteString(aProgTitle, aCmdLine);
                     Result := True;
                   end;
      rtRemove:    begin
                     Result := R.DeleteValue(aProgTitle);
                   end;
    end;
  finally
    R.CloseKey;
    R.Free;
  end;
end;


end.
