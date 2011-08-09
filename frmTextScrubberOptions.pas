unit frmTextScrubberOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls, uTextScrubberTypes;



type
  TTextScrubberOptionsForm = class(TForm)
    OkBtn: TButton;
    CancelBtn: TButton;
    ClickChoiceRadioGroup: TRadioGroup;
    GroupBox1: TGroupBox;
    cbShouldTrim: TCheckBox;
    cbRunOnStartup: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Initialize(aOptions: TTextScrubberOptions);
  end;

var
  TextScrubberOptionsForm: TTextScrubberOptionsForm;

implementation

uses
      uTextScrubberConsts
     ;

{$R *.dfm}

{ TTextScrubberOptionsForm }

procedure TTextScrubberOptionsForm.FormCreate(Sender: TObject);
begin
  cbRunOnStartup.Caption := Format(cbRunOnStartup.Caption, [cAppTitle]);
end;

procedure TTextScrubberOptionsForm.Initialize(aOptions: TTextScrubberOptions);
begin
  ClickChoiceRadioGroup.ItemIndex := Ord(aOptions.ClickChoice);
  cbShouldTrim.Checked := aOptions.ShouldTrim;
  cbRunOnStartup.Checked := aOptions.RunOnStartup;

end;

end.
