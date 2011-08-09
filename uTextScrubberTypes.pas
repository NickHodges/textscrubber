unit uTextScrubberTypes;

interface

uses
  Classes, SysUtils;


type
  TClickChoice = (ccScrubClipboard, ccStraightenText);

type
  TRunType = (rtRunAlways, rtRemove);

type
  ETextScrubberException = class(Exception);

type
  TTextScrubberOptions = record
    ClickChoice: TClickChoice;
    ShouldTrim: Boolean;
    RunOnStartup: Boolean;
  end;

type
  TVersionInfo = record
    CompanyName: string;
    FileDescription: string;
    FileVersion: string;
    InternalName: string;
    LegalCopyright: string;
    LegalTrademarks: string;
    OriginalFilename: string;
    Productname: string;
    ProductVersion: string;
    Comments: string;
    Author: string;
    constructor Create(aVersionLangCodePage: string);
    function GetVersionInformation(aStringList: TStrings; aLangCodepage: string): Boolean;
  end;

type
  TClipboardRecord = record
    FFormat: integer;
    FHandle: THandle;
    constructor Create(aFormat: integer);
  end;

implementation

uses
  Windows,
  Clipbrd,
  uTextScrubberConsts;

{ TVersionInfo }

constructor TVersionInfo.Create(aVersionLangCodePage: string);
var
  SL: TStrings;
begin
  SL := TStringList.Create;
  try
    if not GetVersionInformation(SL, aVersionLangCodePage) then
    begin
      raise Exception.Create('Error Message');
    end;
    CompanyName      := SL.Values['CompanyName'];
    FileDescription  := SL.Values['FileDescription'];
    FileVersion      := SL.Values['FileVersion'];
    InternalName     := SL.Values['InternalName'];
    LegalCopyright   := SL.Values['LegalCopyright'];
    LegalTrademarks  := SL.Values['LegalTrademarks'];
    OriginalFilename := SL.Values['OriginalFilename'];
    Productname      := SL.Values['Productname'];
    ProductVersion   := SL.Values['ProductVersion'];
    Comments         := SL.Values['Comments'];
    Author           := SL.Values['Author'];
  finally
    SL.Free;
  end;
end;

function TVersionInfo.GetVersionInformation(aStringList: TStrings; aLangCodepage: string): Boolean;
const
  InfoNum = 11;
  VersionInfoStrings: array [1 .. InfoNum] of string = ('CompanyName', 'FileDescription', 'FileVersion', 'InternalName', 'LegalCopyright', 'LegalTradeMarks', 'OriginalFilename', 'ProductName', 'ProductVersion', 'Comments', 'Author');

var
  S: string;
  TempFileinfoSize, TempLength: DWORD;
  Counter: Integer;
  Buf: PChar;
  Value: PChar;
  TempStr: string;
begin
  Result := False;
  if aStringList = nil then
  begin
    Exit;
  end;
  aStringList.Clear;
  S := ParamStr(0);
  TempFileinfoSize := GetFileVersionInfoSize(PChar(S), TempFileinfoSize);
  if TempFileinfoSize > 0 then
  begin
    Buf := AllocMem(TempFileinfoSize);
    GetFileVersionInfo(PChar(S), 0, TempFileinfoSize, Buf);
    for Counter := 1 to InfoNum do
    begin
      TempStr := Format('StringFileInfo\%s\%s', [aLangCodepage, VersionInfoStrings[Counter]]);
      if VerQueryValue(Buf, PChar(TempStr), Pointer(Value), TempLength) then
      begin
        Value := PChar(Trim(Value));
        if Length(Value) > 0 then
        begin
          aStringList.Add(VersionInfoStrings[Counter] + '=' + Value);
        end;
      end;
    end;
    FreeMem(Buf, TempFileinfoSize);
  end;
  Result := aStringList.Count > 0;
end;

{ TClipboardRecord }

constructor TClipboardRecord.Create(aFormat: integer);
begin
  FFormat := aFormat;
  FHandle := Clipboard.GetAsHandle(FFormat);
end;

end.
