unit frmAboutBox;

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
  StdCtrls,
  ExtCtrls;

type
  TAboutForm = class(TForm)
    OkBtn: TButton;
    MainIconImage: TImage;
    lblTitle: TLabel;
    lblVersion: TLabel;
    lblCopyright: TLabel;
    lblDescription: TLabel;
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  NixUtils,
  uTextScrubberConsts,
  uTextScrubberUtils,
  uTextScrubberTypes;

procedure TAboutForm.FormCreate(Sender: TObject);
var
  VI: TVersionInfo;
begin
  VI.Create(cVersionLangCodePage);
  MainIconImage.Picture.Assign(Application.Icon);
  lblVersion.Caption := strVersion + Space + VI.FileVersion;
  lblCopyright.Caption := MakeCopyrightNotice(VI.CompanyName);
  lblDescription.Caption := VI.Comments;
end;

end.
