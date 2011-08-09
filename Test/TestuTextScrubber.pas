unit TestuTextScrubber;
{

Delphi DUnit Test Case
----------------------
This unit contains a skeleton test case class generated by the Test Case Wizard.
Modify the generated code to correctly setup and call the methods from the unit
being tested.

}

interface

uses
  TestFramework,
  uTextScrubber,
  Clipbrd,
  NixUtils,
  uTextScrubberUtils,
  uTextScrubberTypes
  ;

type
  // Test methods for class TTextScrubber

  TestTTextScrubber = class(TTestCase)
  strict private
    FTextScrubber: TTextScrubber;

  public
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure TestScrubTextOnClipboard;
    procedure TestStraightenText;
    procedure TestDeleteLineBreaks;

    procedure TestRunOnStartup;

  end;

implementation

uses
  Windows,
  RichEdit,
  Registry,
  SysUtils;

const
  TextWithCRLF = 'This is line one'#13#10'This is line two';
  TextWithoutCRLF = 'This is line oneThis is line two';

  TextWithCRLFNeedsTrim = '  This is line one'#13#10'This is line two  ';
  TextWithoutCRLFNeedsTrim = '  This is line oneThis is line two  ';

  TextWithHTML = '<b>This has some formatting</b>';
  TextWithoutHTML = 'This has some formatting';

  TextWithRTF = '{\bTEST \b0}';
  TextWithoutRTF = 'TEST';

procedure TestTTextScrubber.SetUp;
begin
  FTextScrubber := TTextScrubber.Create(False);
end;

procedure TestTTextScrubber.TearDown;
begin
  FTextScrubber.Free;
  FTextScrubber := nil;
end;

procedure TestTTextScrubber.TestDeleteLineBreaks;
begin

end;

function GetRunValueInRegistry(sProgTitle: string): string;
var
  TempReg: TRegIniFile;
begin
  TempReg := TRegIniFile.Create;
  try
    TempReg.RootKey := HKEY_CURRENT_USER;
    Result := TempReg.ReadString( 'Software\Microsoft\Windows\CurrentVersion\Run', sProgTitle, 'BigFatError');
  finally
    TempReg.Free;
  end;
end;

function CheckRunValueInRegistryExists(sProgTitle: string): Boolean;
var
  TempReg: TRegIniFile;
  Temp: string;
const
  BFE = 'BigFatError';

begin
  TempReg := TRegIniFile.Create;
  try
    TempReg.RootKey := HKEY_CURRENT_USER;
    Temp := TempReg.ReadString( 'Software\Microsoft\Windows\CurrentVersion\Run', sProgTitle, BFE);
    Result :=  Temp <> BFE;
  finally
    TempReg.Free;
  end;
end;

procedure DeleteRunEntry(sProgTitle: string);
var
  TempReg: TRegIniFile;
begin
  TempReg := TRegIniFile.Create;
  try
    TempReg.RootKey := HKEY_CURRENT_USER;
    TempReg.DeleteKey( 'Software\Microsoft\Windows\CurrentVersion\Run', sProgTitle);
  finally
    TempReg.Free;
  end;
end;

procedure TestTTextScrubber.TestRunOnStartUp;
var
  TempResult: Boolean;
  ProgTitle: string;
  CmdStr: string;
  ResultStr: string;

begin
  ProgTitle := 'ProgTitle';
  CmdStr  := 'CmdStr';

  TempResult := ManageRunOnStartup(ProgTitle, CmdStr, rtRunAlways);

  CheckTrue(TempResult, 'Call to RunOnStartup returned false.  That shouldn''t happen!');

  // Check to see if setting is there
  CheckTrue(CheckRunValueInRegistryExists(ProgTitle), 'The ProgTitle entry is not found in the registry');

  //Check to see if it is correct
  ResultStr := GetRunValueInRegistry(ProgTitle);
  CheckEquals(ResultStr, CmdStr, 'The CmdStr value coming back out didn''t work');

  //Delete it
  ManageRunOnStartup(ProgTitle, '', rtRemove);

  // Now it shouldn't be there
  // Check to see if setting is there
  CheckFalse(CheckRunValueInRegistryExists(ProgTitle), 'The ProgTitle entry is not found in the registry');

end;

procedure TestTTextScrubber.TestScrubTextOnClipboard;
begin

end;

procedure TestTTextScrubber.TestStraightenText;
begin
  Clipboard.AsText := TextWithCRLFNeedsTrim;
  FTextScrubber.StraightenTextOnClipboard;
  CheckEqualsString(Clipboard.AsText, TextWithoutCRLFNeedsTrim);

  FTextScrubber.ShouldTrimText := True;
  Clipboard.AsText := TextWithCRLFNeedsTrim;
  FTextScrubber.StraightenTextOnClipboard;
  CheckEqualsString(Clipboard.AsText, TextWithoutCRLF);


end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTTextScrubber.Suite);

end.
