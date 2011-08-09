program TextScrubber;

uses
  Forms,
  frmStraightText in 'frmStraightText.pas' {StraightTextMainForm},
  uTextScrubber in 'uTextScrubber.pas',
  frmTextScrubberOptions in 'frmTextScrubberOptions.pas' {TextScrubberOptionsForm},
  uTextScrubberTypes in 'uTextScrubberTypes.pas',
  uTextScrubberConsts in 'uTextScrubberConsts.pas',
  frmAboutBox in 'frmAboutBox.pas' {AboutForm},
  uTextScrubberUtils in 'uTextScrubberUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.ShowMainForm := False;
  Application.CreateForm(TStraightTextMainForm, StraightTextMainForm);
  Application.Run;
end.
