unit uTextScrubber;

interface

type
  /// <summary>
  ///  TTextScrubber will clear out formatting and/or CRLF's within a string
  /// </summary>
  /// <remarks>
  ///    <para>This class is useful for clearing out formatting of text that is copied from the browser, word documents, etc.
  ///    Frequently, you'll want to paste only the text itself, and not the formatting.</para>
  ///    <para>In addition, sometimes you don't want the line breaks included when you paste (like say with a URL that is really long and
  ///    was wrapped when you copied it -- say in an email).</para>
  /// </remarks>
  TTextScrubber = class
  private
    FShouldTrimText: Boolean;
  public
    /// <summary>
    ///   Create is the constructor for TTextScrubber.  It instantiates an instance of TTextScrubber
    /// </summary>
    // Turned the below <param> tag into a comment because of http://qc.embarcadero.com/wc/qcmain.aspx?d=56829
    // <param name="aShouldTrimText">
    //   A boolean parameter that determines if the string should be "trimmed" when processed.  "Trim" means that spaces are removed
    //  from the front and the back of the string.
    // </param>
    constructor Create(const aShouldTrimText: Boolean);
    /// <summary>
    ///   StraightenString will remove all CR and LF chars from a string (#13 and #10)
    /// </summary>
    /// <param name="aString">
    ///   The string that is to be "straightened"
    /// </param>
    function StraightenString(aString: string): string; virtual;
    /// <summary>
    ///   ScrubTextOnClipboard will remove all formatting from text on the Clipboard
    /// </summary>
    /// <remarks>
    ///   It does this simply by setting Clipboard.Text -- when you do that, only the text makes it through.
    /// </remarks>
    procedure ScrubTextOnClipboard; virtual;
    /// <summary>
    ///   Takes the text on the clipboard and 'straightens' it. That is, it removes all the linebreaks from the text on
    ///   the Clipboard
    /// </summary>
    procedure StraightenTextOnClipboard; virtual;
    /// <summary>
    ///   Boolean property that determines if the process of straightening and scrubbing
    ///   the strings should also trim the spaces off of the string's ends.
    /// </summary>
    property ShouldTrimText: Boolean read FShouldTrimText write FShouldTrimText;
  end;

implementation

uses
        SysUtils
      , Clipbrd
      , Windows
      , uTextScrubberUtils
      ;

{ TTextScrubber }

procedure TTextScrubber.ScrubTextOnClipboard;
begin
  Clipboard.AsText := Clipboard.AsText;
end;

constructor TTextScrubber.Create(const aShouldTrimText: Boolean);
begin
  inherited Create;
  FShouldTrimText := aShouldTrimText;
end;

function TTextScrubber.StraightenString(aString: string): string;
begin
  Result := DeleteLineBreaks(aString);
  if FShouldTrimText then
  begin
    Result := Trim(Result);
  end;
end;

procedure TTextScrubber.StraightenTextOnClipboard;
begin
  Clipboard.AsText := StraightenString(Clipboard.AsText);
end;

end.
