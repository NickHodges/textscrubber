unit frmStraightText;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  Menus,
  ActnList,
  StdActns,
  ImgList,
  Clipbrd,
  uTextScrubberTypes,
  frmTextScrubberOptions;

type
  TStraightTextMainForm = class(TForm)
    MainTrayIcon: TTrayIcon;
    IconImageList: TImageList;
    MainActionList: TActionList;
    MainPopupMenu: TPopupMenu;
    Exit1: TMenuItem;
    ExitAction: TAction;
    StraightenTextAction: TAction;
    StraightenTextAction1: TMenuItem;
    PureTextAction: TAction;
    PurifyText1: TMenuItem;
    N1: TMenuItem;
    OptionsAction: TAction;
    Options1: TMenuItem;
    AboutAction: TAction;
    About1: TMenuItem;
    RunAtStartupAction: TAction;
    procedure ExitActionExecute(Sender: TObject);
    procedure MainTrayIconClick(Sender: TObject);
    procedure PureTextActionExecute(Sender: TObject);
    procedure OptionsActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AboutActionExecute(Sender: TObject);
    procedure MainTrayIconAnimate(Sender: TObject);
    procedure RunAtStartupActionExecute(Sender: TObject);

  private
    { Private declarations }
    TextScrubberOptions: TTextScrubberOptions;
    // ShouldTrimText: Boolean;
    procedure InitializeMainFormInformation;
    procedure DoStraightenText;
    procedure DoPurifyText;
    procedure StoreIniFileInformation;

  public
    { Public declarations }
  end;

var
  StraightTextMainForm: TStraightTextMainForm;

implementation

uses
  uTextScrubber,
  NixUtils,
  IniFiles,
  uTextScrubberConsts,
  frmAboutBox, uTextScrubberUtils;

{$R *.dfm}

procedure TStraightTextMainForm.ExitActionExecute(Sender: TObject);
begin
  Close;
end;

procedure TStraightTextMainForm.FormCreate(Sender: TObject);
begin
  InitializeMainFormInformation;
end;

procedure TStraightTextMainForm.FormDestroy(Sender: TObject);
begin
  StoreIniFileInformation;
end;

procedure TStraightTextMainForm.InitializeMainFormInformation;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(IniFileName);
  try
    TextScrubberOptions.ClickChoice := TClickChoice(IniFile.ReadInteger(cOptions, cClickChoice, 0));
    TextScrubberOptions.ShouldTrim := IniFile.ReadBool(cOptions, cShouldTrimText, False);
    TextScrubberOptions.RunOnStartup := IniFile.ReadBool(cOptions, cRunOnStartup, False);
  finally
    IniFile.Free;
  end;
end;

procedure TStraightTextMainForm.DoStraightenText;
var
  TS: TTextScrubber;
begin
  TS := TTextScrubber.Create(TextScrubberOptions.ShouldTrim);
  try
    TS.StraightenTextOnClipboard;
  finally
    TS.Free;
  end;
end;

procedure TStraightTextMainForm.AboutActionExecute(Sender: TObject);
var
  AboutForm: TAboutForm;
begin
  AboutForm := TAboutForm.Create(Self);
  try
    AboutForm.ShowModal;
  finally
    AboutForm.Free;
  end;
end;

procedure TStraightTextMainForm.RunAtStartupActionExecute(Sender: TObject);
begin
  //  If checked, then add it into startup list

  // if not checked, then remove it

end;

procedure TStraightTextMainForm.DoPurifyText;
var
  TS: TTextScrubber;
begin
  TS := TTextScrubber.Create(TextScrubberOptions.ShouldTrim);
  try
    TS.ScrubTextOnClipboard;
  finally
    TS.Free;
  end;
end;

procedure TStraightTextMainForm.StoreIniFileInformation;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(IniFileName);
  try
    IniFile.WriteInteger(cOptions, cClickChoice, Ord(TextScrubberOptions.ClickChoice));
    IniFile.WriteBool(cOptions, cShouldTrimText, TextScrubberOptions.ShouldTrim);
    IniFile.WriteBool(cOptions, cRunOnStartup, TextScrubberOptions.RunOnStartup);
  finally
    IniFile.Free;
  end;
end;

procedure TStraightTextMainForm.MainTrayIconAnimate(Sender: TObject);
begin
  if MainTrayIcon.IconIndex >= IconImageList.Count - 1 then
  begin
    MainTrayIcon.Animate := False;
  end;
end;

procedure TStraightTextMainForm.MainTrayIconClick(Sender: TObject);
begin
  MainTrayIcon.Animate := True;
  case TextScrubberOptions.ClickChoice of
    ccStraightenText:
      begin
        DoStraightenText;
      end;
    ccScrubClipboard:
      begin
        DoPurifyText;
      end;
  end;
end;

procedure TStraightTextMainForm.OptionsActionExecute(Sender: TObject);
var
  OptionsForm: TTextScrubberOptionsForm;
begin
  OptionsForm := TTextScrubberOptionsForm.Create(Self);
  try
    OptionsForm.Initialize(TextScrubberOptions);
    if OptionsForm.ShowModal = mrOk then
    begin
      TextScrubberOptions.ClickChoice := TClickChoice(OptionsForm.ClickChoiceRadioGroup.ItemIndex);
      TextScrubberOptions.RunOnStartup := OptionsForm.cbRunOnStartup.Checked;
      if TextScrubberOptions.RunOnStartup then
      begin
        ManageRunOnStartup(cAppTitle, '"' + GetModuleFileNameStr + '"', rtRunAlways);
      end else
      begin
        ManageRunOnStartup(cAppTitle, '', rtRemove);
      end;
    end;
  finally
    OptionsForm.Free;
  end;
end;

procedure TStraightTextMainForm.PureTextActionExecute(Sender: TObject);
begin
  DoPurifyText;
end;

end.
