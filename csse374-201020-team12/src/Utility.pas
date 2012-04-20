unit Utility;
interface
Uses Windows, SysUtils, ComCtrls, Graphics, Classes, DB, WinSock, DBGrids, WinSvcNew,
     ClipBrd, Forms, Math, StdCtrls, Checklst, Messages, ShlObj, ActiveX, ComObj,
     Registry,Dialogs, Grids, printers, controls, ShellAPI,psapi;

{ functions SocketCanWrite, SocketReadln, SocketReadlnEcho, SocketWrite, SocketWriteln
  moved to Util50 1/17/03 - jrn.  Those will only compile properly under Delphi 5}

Const
   ltInfo        = 0;
   ltWarning     = 1;
   ltCritical    = 2;
   ltAudit       = 3;
   ltTrace       = 4;
   ltPerf        = 5;
   ltTitle       = 6;
   ltMail        = 7;
   ltLogin       = 8;
   ltDebug       = 99;

   CR = #13;
   LF = #10;
   CRLF          = #13 + #10;

   STX= chr(2);
   ETX= chr(3);
   EOT = Chr(4);
   ENQ = Chr(5);
   ACK = chr(6);
   FS = chr(28);
   TableSep = chr(27);

   SO = chr(14);
   SI = Chr(15);

   SUB = chr(26);



   NAK = chr(21);
   EOTc = chr(4);



Type
   TEventLogEvent = procedure(Severity : Integer; EventName : String; Info: String) of object;
   TEventLogExtEvent = procedure(EventID : Integer; Severity : Integer; EventName : String; Info: String) of object;


procedure RemoveDirAndContents(Dir :string);
function EnumWndProc(h : THandle; lParam : integer) : boolean; stdcall;
function GetWindowsDir: String;
function GetSystemDir: String;
Function GetDesktopDir : String;
function IsHomeEdition : Boolean;
Function    IsWin9X :Boolean;
Function    IsWin95A :Boolean;
Function    IsWin95B :Boolean;
Function    IsWin98FE :Boolean;
Function    IsWin98SE :Boolean;
Function    IsWinME :Boolean;
Function    IsWinNT :Boolean;
Function    IsWinNT4 :Boolean;
Function    IsWin2K :Boolean;
Function    IsWinXP :Boolean;
function    WindowsVersion :string;
Function    STRComplex     (X:Comp; Places : Integer):String;
Function    STRI           (X:LongInt; Places : Integer):String;
Function    STRIReal       (X:Real   ; Places : Integer):String;
Function    VALU           (S:String):LongInt;
Function    VALUReal       (S:String):Real;
Function    DelLstSpcs     (S : String; Max : Byte) : String;
Function    QuoteShortYear (Year : Integer) : String;
Procedure   ReplaceString  (VAR MainString : String;
                            SubStr1    : String;
                            SubStr2    : String);
Procedure   SReplaceString(VAR MainString : String;
                             SubStr1    : String;
                             SubStr2    : String);
Function    FillMask      (AMask : String; ANumber : LongInt) : String;
Function    DSPCS          (S : String) : String;
Function    UpCaseString   (InStr : String):String;
Procedure   ShareTime;
Procedure   KillTime;
Procedure   DeleteFiles    (FileName : String);
Procedure   CopyFilesWC    (Source : string; DestPath : String);
Procedure   MoveFilesWC    (Source : string; DestPath : String);
Procedure   AppendFilesWC  (Source : string; DestPath : String);

FUNCTION    PathOnly       (Path     : String) : String;
FUNCTION    FileOnly       (Path     : String) : String;
FUNCTION    ExtensionOnly  (PathName : String) : String;
FUNCTION    NamePartOnly   (PathName : String) : String;
Function    AppendFile     (FromFile, ToFile : String) : Boolean;
Procedure   AppendFileStr  (FN : String; AppString : String);
Procedure   AppendFileBin  (FN : String; AppString : String);   //Binary version, no crlf


Function    GetURL         (Text : String) : String;
Function    GetTitle       (Text : String) : String;
Function    StripTabs      (Text : String) : String;

Function    StrCmp         (StrA, StrB : String) : Integer;

Procedure   SaveListViewToFile(TView : TListView; FName : String);
Procedure   LoadListViewFromFile(TView : TListView; FName : String);
Function    ParseToChar    (VAR AString : String; AChar : Char) : String;

Function    CurrentDrive : String;

Procedure   ReplaceCharWithChar(VAR Text : String; ReplaceC : Char; WithC : Char);
Procedure   CopyFile(FromFile, ToFile : String);

Function    LetterOfDayOfWeek(ADate : TDateTime) : String;
Function    LastDayOfWeek(ADOW : Integer; ADate : TDateTime) : TDateTime;

Function    GoodDiv(Numerator, Denominator : Real) : Real;
Function    Lesser(Val1, Val2 : Integer) : Integer; //Returns the Lesser of the 2 vals
Function    Greater(Val1, Val2 : Integer) : Integer; //Returns the Greater of the 2 vals

Function    LongMoney(AVal : Real) : String;


Procedure   CWriteln(Canvas : TCanvas; var X : LongInt; var Y : LongInt; Astring : String);
Procedure   CWrite(Canvas : TCanvas; var X : LongInt; var Y : LongInt; Astring : String);
Procedure   CCentWriteln(Canvas : TCanvas; var X : LongInt; var Y : LongInt;
                         Width : Longint; Astring : String);
Procedure   CRightWriteLn(Canvas : TCanvas; var X : LongInt; var Y : LongInt;
                          Width : Longint; Astring : String);

Procedure   CWWWriteLn(Canvas : TCanvas; var X : LongInt; var Y : LongInt;
                       Width : Longint; Astring : String);
Function    GetWord(VAR AString: String) : String;

Function    DateTimeToSString(ADate : TDateTime) : String;          //TDateTime to YYMMDD String
Function    SStringToDateTime(ADate : String) : TDateTime;          //YYMMDD String To TDateTime
Function    DateTimeToLString(ADate : TDateTime) : String;          //TDateTime to YYYYMMDD String
Function    LStringToDateTime(ADate : String) : TDateTime;          //YYYYMMDD String To TDateTime
Function    NumericOnly(AString : String): String;                  //Returns String w/ only 0-9 chars
Function    DateCharsOnly(AString : String) : String;               //Returns string with only 0-9 and /
Function    IsValidDateString(ADateStr : String) : Boolean;         //Returns True if valid date
Function    IsNumeric(AString : String) : Boolean;                  //True if a string is numeric only
Function    AlphaOnly(AString : String): String;                    //Returns String w/ only A-Z and a-z chars
Function    AlphaNumericOnly(AString : String): String;                    //Returns String w/ only A-Z and a-z chars
Function    GUIDOnly(AString : String): String;
Function    IntToTime(ATime : Integer) : TDateTime;                 //takes an int of 1259 and returns a datetime of 12:59
Function    MMDDYYYYToDateTime(AStr : String): TDateTime;
Function    MMDDYYToDateTime(AStr : String): TDateTime;


Function    IsNum(ANumber : String) : Boolean;
Function    IsAlphaChar(AChar : Char) : Boolean;
Function    AlphasOnly(AString : String) : String;
Function    IsOnlyNumbers(ANumber : String) : Boolean;
Function    IsFloat(ANumber : String) : Boolean;
Function    LeftStr(AString :String; Position :Integer) :String;
Function    RightStr(AString :String; Position :Integer) :String;
Function    MidStr(AString :String; Position :Integer; Length  :Integer) :String;

Procedure ExpandTreeNode(ANode : TTreeNode);
Procedure CollapseTreeNode(ANode : TTreeNode);
Procedure ExpandUnitsOnly(ANode : TTreeNode);

Procedure ObjectClear(AStringList : TStringList);
Procedure PointerClear(AStringList : TStringList);

Function  ScopeEOF(VAR AFile : TextFile) : Boolean;

Function  EOLCrypt(InStr : String) : String;
Function  XORCrypt(InStr : String) : String;
Function  DigitsOnly(InStr : String) : String;
Procedure StripTrailingComma(VAR AString : String);
Procedure StripTrailingCloseParen(VAR AString : String);
Function  StripTrailingAND(AString : String) : String;
Function  StripTrailingOR(AString : String) : String;
Function  SpectrumDate(ADate : String) : TDateTime;
Function  EscapeDoubleQuotes(InStr : String) : String;
Function  EscapeDoubleWithSingleQuotes(InStr : String) : String;
Function  EscapeSingleQuotes(InStr : String) : String;

Function  SQLString (AValue : String) : String;
Function  SQLInteger(AValue : Integer) : String;
Function  SQLFloat  (AValue : Double; Places : Integer) : String;
Function  SQLDate   (AValue : TDateTime) : String;
Function  UploadDate(AValue : TDateTime) : String;
Function  SQLValue  (AField : TField): String;

Procedure FindAndShowWindow(WindowCaption : String; ShowCmd : Integer);
Function FindWindowContaining(WindowCaption : String) : Integer;

Function PadLeft(AString : String; StrLength : Integer) : String;
Function ZeroPadLeft(AString : String; StrLength : Integer) : String;

Function PadRight(AString : String; StrLength : Integer) : String;
Function RightChars(AString : String;NumChars : INteger) : String;

{Function SocketCanWrite(ASocket: TCustomWinSocket; TimeOut: Longint) : Boolean;}
Procedure CopyGridToClipboard(AGrid : TDBGrid);
Procedure CopyGridToClipboardPB(AGrid : TDBGrid;APB : TProgressBar);
Procedure CopyRowToClipboard(AGrid : TDBGrid);
Procedure CopyGridStringToClipboard(AGrid : TDBGrid;AMessage : String);

Function RTKMoney(InStr : String): String;
Function FloatToRTK(InFloat : Real): String;
Function RTKDate(InStr : String): String;
Function MakeTempRTKCode(TitleCode: Integer): String;

Function GetParenContents(InStr : String) : String;

Function StripHTMLTag(var Instr :String) : String;
Function StripAllHTMLTags(var Instr :String) : String;
Function ReplaceAllHTMLTags(var Instr :String; RString : String) : String;
Function ReplaceHTMLTag(var Instr :String;RString : String) : String;

Function GetVolumeSerialNum(DriveLetter : String) : DWord;
Function GetVolumeName(DriveLetter : String) : String;
Function GetVolumeFileSystem(DriveLetter : String) : String;

Function ConvertFileTime(ATime : TFileTime) : TDateTime;
Function PostNetCheck(AZIP : String) : Char;

Function YearOnly(ADate : TDateTime): Integer;

Function StripSpaces(AString : String) : String;
Function StripCRLF(AString : String) : String;

Function ComputeAge(DOB : TDateTime) : Integer;
Function HasBogusChars(AString : String) : Boolean;

Function PadIntVal(IntVal : Integer; Places : Integer) : String;
Function StripDollar(AStr : String) : String;
Procedure SaveDataSetToTabs(ADataSet : TDataSet; AFile : String); overload;
Function DataSetRowToTabs(ADataSet : TDataSet) : String;
Procedure CopyDataSetToStringList(ADataSet : TDataSet; ASL : TStringList);
Procedure CopyDataSetToStringListWMemo(ADataSet : TDataSet; ASL : TStringList);
Procedure SaveDataSetToTabsWHeader(ADataSet : TDataSet; AFile : String);
Function  LoadToDataSet(AFile : String; ADS : TDataSet) : Integer;
Function BTRAField(ADataSet: TDataSet; AFieldName : String; Offset : Integer) : TField; //Gets an array definition field  no error checks

Procedure ConvertFieldToField(FromField : TField; ToField : TField);
Function DateWindow(ADate : TDateTime) : TDateTime;
function EANString(ACode : String) : String;
Function UPCString(ACode : String) : String;
Function IsUPC(ABarCode : String): Boolean;
procedure NestedDelete(var S: string; Index, Count:Integer);
Function ParseEMailRealName(FullAddress : String): String;
Function ParseEMailAddress(FullAddress : String): String;
Function DateAsString(AField : TField) : String;
Procedure TabStrToStringList(AString : String; ASL : TStringList);
Function SecondsToDateTime(Secs : Integer) : TDateTime;
function BytesToHexString(var AValue; Length : Integer) : String;
Function CharToHex(AChar : Char) : String;
Function HexStringToBytes(Instr : String): String;
Procedure SetOddBitDESParity(VAR InByte : Byte);
Function  StrToUnicodeStr(AString : String) : String;
Function  CheckFileExclusive(AFileName : String): Boolean;
Function  DiskFreeEx(Path : String) : Comp;
Function  DiskSize(Path : String) : Comp;
function  FileByNameSize(FileName : String) :integer;
Procedure AddTableToListBox(ADS : TDataSet; ALB : TCheckListBox);
Procedure AddTableToStringList(ADS : TDataSet; SL : TStrings);
Procedure AddTableSelectionToListBox(ADS : TDataSet; ALB : TCheckListbox);
Procedure AddTableExclusionToListBox(ADS : TDataSet; ALB : TCheckListBox);
Procedure CheckListBoxClearSelection(ALB : TCheckListBox);

Function  TextBetween(AString : String; StartText : String; EndText : String) : String;

Function  FileEndsInCRLF(AFileName : String) : Boolean;
function AddBackslash (APath :string) :string;
function RemoveBackslash (APath :string) :string;
function UpdateConfigSysFiles :Boolean;

function RandomString(NumChars :integer) :string;
function RandomStringKey(NumChars :integer) :string;

procedure StartVNC(IPAddress :string);
procedure StartPCA(IPAddress :string);
procedure StartXPTS(IPAddress, UserName :string);
procedure StartTelnet(IPAddress :string);

Procedure AddFieldsToGrid(FieldList : String; AGrid :TDBGrid);

Function StripParens(AStr : String) : String;
Function StripAllParens(AStr : String) : String;
procedure SendEmail(Address :string; Subject :string; Body :string);
function CurrentUserName :string;


Function GetSQLQueryText(AVariable : String; ACheckList : TCheckListBox) : String;
Function GetSQLQueryTextNoTrim(AVariable : String; ACheckList : TCheckListBox) : String;

Function GetTimeZoneBias : Integer;
Procedure AddDataSetFieldToListBox(ADS : TDataSet; AFieldName : String; ALB : TCheckListBox);
Function CheckListSelCount(ACheckList : TCheckListBox) : Integer;

Function GetWinComputerName : String;

Function StartSystemService(EventHandler : TEventLogEvent; ServiceName : String; ServiceDescription : String) : Boolean;
Function StopSystemService(EventHandler : TEventLogEvent; ServiceName : String; ServiceDescription : String) : Boolean;
Function ServiceStateText(State :DWord): String;
Function ControlServiceErrorText(LastError : DWord ) : String;

Procedure FloatFieldToCurrencyDisplayDS(ADS : TDataSet; Format : String);
Procedure TrimStringsDS(ADS : TDataSet);
Procedure UpdateFloatDisplayOnForm(AFrm : TComponent;Find : String; Replace : String);


Function QueryFindField(ADS : TDataSet; FieldName : String) : TField;

Function StripHighAscii(InStr : String) : String;

function CtrlDown : Boolean;
function ShiftDown : Boolean;
function AltDown : Boolean;
Function GetCardNumFromSwipe(Swipe : String) : String;
Function ComputeCardCheckDigit(AStr : String) : String;



Function IsValidCardNum(AStr : String) : Boolean;

Function GetEnvVar(AVar : String) :String;


Function IsValidDate(ADateStr : String) : Boolean;
procedure PrintBitmap( R: TRect; BM: TBitmap );

Function ArrayParamStr(I : Integer) : String;

Function UpTimeStr(UpTime : TDateTime) : String;

Function LoadFileToStr(FromFile : String) :String;
Procedure SaveStringAsFile(FN : String; SaveString : String);

Procedure FTPRemoteToAddrPort(RemoteData :String; var RemoteAddr : String; var RemotePort :Word);

Function GetXMLTag(XMLData : TStrings; Tag : String) : String;
Function GetXMLTagStr(XMLData : String; Tag : String) : String;
Function GetNXMLTagStr(XMLData : String; Tag : String; TagNum : Integer) : String;
Function GetNXMLTag(XMLData : String; Tag : String; TagNum : integer) : String;
Function XMLtoDS(XMLData : String;DS : TDataSet; RowTag : String) : Integer;
Procedure StripXMLTag(Var RawXML: String; TagName : String);

Function PosN(SubStr : String; FindStr : String; Nth : Integer) : Integer;

function GetLocalhostIP(var HostName, IPaddr, WSAErr: string): Boolean;
function GetIPOfHost(var HostName, IPaddr, WSAErr: string): Boolean;
Function GetSubnetBroadcastAddress(LocalIP : String) : String;

Procedure SaveGridToFile(AGrid : TDBGrid; FN : String; PB : TProgressBar);
Function MoneyFormat : String;
Function MoneyDecimal : String;
function ForceForegroundWindow(hwnd: THandle): Boolean;
Function BoolToStr(ABool : Boolean) : String;

Function OnlyAlpha(AStr : String) : String;

Function GenerateBarcode(Num : integer; Mask : String) : String;

Function AppFindComponent(ComponentName : String) : TComponent;

Function ExtractBuildNumberFromVersion(VersionStr : String): Integer;

Function StringListAdd(AddFrom : TStringList; AddTo : TStringList) : Integer;

function Base64Decode(const S: String): String;
function Base64Encode(const S: String): String;

Function Base64CharsOnly(S : String) : String;

Function CutWords(Var InStr : String; MaxChars : Integer) : String;

function getsys32folder : String;
function ExecAndWait(const ExecuteFile, ParamString : string): boolean;
Function RegisterOCX(FileName : String) : Boolean;

Function StringEndsWith(TestStr : String; TestEnding : String) : Boolean;
Function EXEFolder : String;

Function EMailUserPart(Email : String) : String;
Function EMailDomainPart(Email : String) : String;
Function TrimCRLF(AStr : String): String;

procedure DisableProcessWindowsGhosting;

Function GetNthTabPosition(AStr : String;APos : Integer) : String;

Function FileToInclude(SourceFile : String) : integer;
function FindVolumeSerial(const Drive : String) : string;
Function NormalizeWebInput(Astr : String) : String;
Function WebParamEncode(Astr : String) : String;
Function ToUTF(InStr : String): String;
Function FromUTF(InStr : String): String;
Function CorpWWWStyle : String;
Function HTMLStateSelected(State : String) : String;

Function ZTimeToLocalTime(ZTime : String) : TDateTime;
Function GetTimeZoneBiasDT : TdateTime;
Function DTToGMTStr(ADT : TDateTime) : String;

Function LocalTimeToZoneTime(LocalTime : TDateTime; ZoneAbbr : String) : TDateTime;
Function GMTToLocalTime(GMTTime : TDateTime) : TDateTime;
Function LocalTimeToGMT(LocalTime : TDateTime) : TDateTime;
Function GetTimeZoneBiasByName(ZoneAbbr : String) : TDateTime;

Function ValidateStateAbbr(State : String) : Boolean;

Function IsValidUploadStr(Astr : String) : Boolean;
Function CleanUploadStr(Astr : String) : String;
Function StripNulls(Astr : String) : String;

Function GenerateGUID : String;

function CurrentMemoryUsage: Cardinal;

Function DSToHTMLTable(ADS : TDataSet) : String;

CONST
   TAB = CHR(9);
VAR
   GlobalCopyGridFieldNames : Boolean;
   UtilityPB : TProgressBar;
   UtilityAbort : Boolean;

   UtilityLastError : String;
   UtilityReg : TRegIniFile;

implementation



function CurrentUserName :string;
var
  UserName :PChar;
  Characters :array[0..255] of char;
  Size :DWord;
begin
  UserName := @Characters[1];
  Size := 255;
  GetUserName(UserName, Size);
  CurrentUserName := StrPas(UserName);
end;
procedure SendEmail(Address :string; Subject :string; Body :string);
var
  TempStr :string;
  MyReg     : TRegIniFile;
  Directory :string;
begin
  MyReg := TRegIniFile.Create('Software\Microsoft\Windows\CurrentVersion\Explorer');
  MyReg.RootKey := HKEY_CLASSES_ROOT;
  MyReg.OpenKey('msgfile\shell\open',false);
  Directory := MyReg.ReadString('command','','');
  TempStr := ParseToChar(Directory,'"');
  TempStr := ParseToChar(Directory,'"') + ' -c IPM.Note /m "' + Address;
  if Subject <> '' then TempStr := TempStr + '&subject=' + Subject;
  if Body <> '' then TempStr := TempStr + '&body='+ Body;
  TempStr := TempStr + '"';
//  MessageDlg(TempStr, mtInformation,[mbOk, mbCancel], 0);
  WinExec(@TempStr[1], SW_MAXIMIZE);
  MyReg.Free;
end;

function AddBackslash (APath :string) :string;
begin
  if APath[Length(APath)] <> '\' then
    AddBackSlash := APath + '\'
  else
    AddBackSlash := APath;
end;

function RemoveBackslash (APath :string) :string;
var TempStr :string;
begin
  TempStr := trim(APath);
  if TempStr[Length(TempStr)] = '\' then
    RemoveBackSlash := LeftStr(TempStr,length(TempStr)-1)
  else
    RemoveBackSlash := TempStr;
end;

function GetWindowsDir: String;
{returns the windows directory with a backslash}
var
    WinDir:   PChar;
begin
     WinDir := StrAlloc (256);
     GetWindowsDirectory (WinDir, 256);
     Result := AddBackSlash(StrPas (WinDir));
     StrDispose (WinDir);
end;  { GetWindowsDir }
function GetSystemDir: String;
{returns the windows directory with a backslash}
var
    WinDir:   PChar;
begin
     WinDir := StrAlloc (256);
     GetSystemDirectory (WinDir, 256);
     Result := AddBackSlash(StrPas (WinDir));
     StrDispose (WinDir);
end;  { GetWindowsDir }

Function GetDesktopDir : String;
var
   PIDL : PItemIDList;
   InFolder : array[0..MAX_PATH] of Char;

begin
   SHGetSpecialFolderLocation(0, CSIDL_DESKTOPDIRECTORY, PIDL) ;
   SHGetPathFromIDList(PIDL, InFolder) ;
   Result := StrPas(InFolder);
end;
  {************************************************************************
Function STRComp(X:Comp; Places : Integer):String;

Places replaces that number of spaces w/ zeroes
Function form of STR procedure in std pascal
Prints out the header to Upload File
*************************************************************************}
Function STRComplex(X:Comp; Places : Integer):String;
Var
  TempStr, S: String;
  i :integer;
Begin
  S := '';
  while X > 0 do
    begin
      i := round(frac(X / 10) * 10);
      Str(i, TempStr);
      S := TempStr + S;
      X := trunc(X / 10);
    end;

   for I := length(S) to Places - 1 do
     S := '0' + S;
   Result := S;
End;
{************************************************************************
Function STRI(X:LongInt; Places : Integer):String;

Places replaces that number of spaces w/ zeroes
Function form of STR procedure in std pascal
Prints out the header to Upload File
*************************************************************************}
Function STRI(X:LongInt; Places : Integer):String;
Var
  S:String;
  I: Integer;
Begin
   If Places <0 then
      Str(X, S)
   else
      STR(X:Places,S);
   For I := 1 to Places do if S[I] = ' ' then S[I] := '0';
   STRI:=S;
End;

Function    STRIReal     (X:Real   ; Places : Integer):String;
Var
  S:String;
Begin
   STR(X:20:ABS(Places),S);
   If Places < 0 then S := DelLstSpcs(S, 20);
   STRIReal:=S;
End;

{**********************************************************************
Function VALU - Returns the integer value of a string that is passed
to it
***********************************************************************}
Function VALU(S:String):LongInt;
Var
  I:LongInt;
  Code: Integer;
  SS:String;
Begin
  SS:='';
  If Length(S)>0 then
    For I:=1 to Length(s) do
         if S[I] in ['-', '1','2','3','4','5','6','7','8','9','0'] then SS:=SS+S[I];

  VAL(SS,I,Code);
//  VALU:=Trunc(I);
  VALU:=I;
End;

{**********************************************************************
Function VALU - Returns the Real value of a string that is passed
to it
***********************************************************************}
Function VALUReal(S:String):Real;
Var
  I:Real;
  II : Integer;
  Code: Integer;
  SS:String;
Begin
  SS:='';
  If Length(S)>0 then
    For II:=1 to Length(s) do
         if S[II] in ['1','2','3','4','5','6','7','8','9','0','.','-'] then SS:=SS+S[II];

  VAL(SS,I,Code);
  VALUReal :=I;
End;

{***************************************************************************
Function DelLstSpcs Deletes extra White Space at the ends of a string
****************************************************************************}
FUNCTION DelLstSpcs(S :String; Max : Byte) : String;
  Var
    I : integer;
    WS : String;
  Begin
    WS:=S;
    I:=1;
    If length(WS) <> 0 Then
    Begin
      While (I < Max) AND (I < 255) AND ((WS[i]=#0) or (WS[i]=' ') or (WS[i]=^I)) do I:=I+1;
      Ws:=copy(WS,i,Max);
      While (Length(WS)>0) and ((WS[Ord(length(WS))]=#0) or (WS[Ord(Length(WS))]=' ') or (WS[Ord(Length(WS))]=^I)) do
        SetLength(WS, Pred(Length(WS)));
    End;
    DelLstSpcs:=Copy(WS,1,Max);
  end; { TrimTrail }

{***********************************************************************************
Quick DelLstSpcs
************************************************************************************}
Function    DSPCS          (S : String) : String;
Begin
   DSPCS := DelLstSpcs(S, 255);

end;

{***********************************************************************************
QuoteShortYear

When Given a date in INTEGER format, it returns a string in 'YY format.
IE, 1994 is returned '94
************************************************************************************}
Function    QuoteShortYear (Year : Integer) : String;
VAR
   OutStr : String[10];
Begin
   OutStr := Stri(Year, 0);
   OutStr := '''' + Copy(Outstr, 3, 2);
   QuoteShortYear := OutStr;
end;

{************************************************************************
Procdure ReplaceString
Relaces String a substring in a string w/ a new substring
*************************************************************************}
Procedure ReplaceString(VAR MainString : String;
                            SubStr1    : String;
                            SubStr2    : String);
Var
   ReplaceLoc  : Integer;
begin
   If SubStr1 = SubStr2 then exit;
   While Pos(SubStr1, MainString) > 0 do begin
        ReplaceLoc := Pos(SubStr1, MainString);
        Delete(MainString, Pos(SubStr1, MainString), Length(SubStr1));
        Insert(SubStr2, MainString, ReplaceLoc);
   end;
end;
{************************************************************************
Procdure SReplaceString     Single Version
Relaces String a substring in a string w/ a new substring
*************************************************************************}
Procedure SReplaceString(VAR MainString : String;
                             SubStr1    : String;
                             SubStr2    : String);
Var
   ReplaceLoc  : Integer;
begin
   If SubStr1 = SubStr2 then exit;
   ReplaceLoc := Pos(SubStr1, MainString);
   Delete(MainString, Pos(SubStr1, MainString), Length(SubStr1));
   Insert(SubStr2, MainString, ReplaceLoc);
end;

{********************************************************************************}
Function    FillMask      (AMask : String; ANumber : LongInt) : String;
VAR
   I : LongInt;
   NumPound : Integer;
   NumStr   : String;
   PoundCnt : Integer;
   OutStr   : String;
begin
   NumPound := 0;
   For I := 1 to Length(AMask) do
      If AMask[I] = '#' then Inc(NumPound);
   NumStr := Stri(ANumber, NumPound);

   OutStr := '';
   PoundCnt := 1;
   For I := 1 to Length(AMask) do
      If AMask[I] = '#' then begin
         OutStr := OutStr + NumStr[PoundCnt];
         Inc(PoundCnt);
      end else
         OutStr := OutStr + AMask[I];

   FillMask := OutStr;
end;

{**********************************************************
Send a string with a # value in AString
AToken contains a delimit like 'A'
getvalue will look for #A#xxx# and return xxx
it will replace AToken with #A#xxx#
***********************************************************}

Function GetValue(AString : String; VAR AToken :String) : String;
VAR
   TPos : Integer;
   Len  : Integer;
Begin
   GetValue := '';
   Len := Length(AToken) + 2;
   TPos := POS('#' + AToken + '#', AString);
   While Len <= (Length(AString) - TPos) do Begin
      if AString[TPos + Len] = '#' then Break;
      Len := Len + 1;
   end;
   AToken := Copy(AString, TPos, Len);
end;

{*************************************************************************
  FUNCTION UpCaseString -
  This procedure converts the given string to a string w/ the same values,
  simply UPPERCASE
**************************************************************************}
Function UpCaseString(InStr : String):String;
var
   I      : Integer;     { Counter for loop }
   OutStr : String;      { Output String    }
begin                    { Begin Procedure  }

   OutStr := '';                                     {Initialize}
   For I := 1 to Length(InStr) do                    {Capitalize}
      OutStr := OutStr + UpCase(InStr[I]);

   UpCaseString := OutStr;
end;                     { End Procedure }

{********************************************************************************}
Procedure ShareTime;
VAR
   Msg : TMsg;
Begin
   if PeekMessage(Msg, 0, 0, 0, pm_Remove) then begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
   end;
end;
{********************************************************************************}
Procedure KillTime;
{VAR
   Msg : TMsg;}
Begin
   Application.ProcessMessages;
{   While PeekMessage(Msg, 0, 0, 0, pm_Remove) do
      begin
         TranslateMessage(Msg);
         DispatchMessage(Msg);
      end;}
end;


{************************************************************************
Deletes the specified files / file
*************************************************************************}
Procedure   DeleteFiles    (FileName : String);
var
   DirInfo  : TSearchRec;
   DelFile  : String;
   Result   : Integer;
begin

   Result := FindFirst(FileName, faAnyFile, DirInfo);
   While Result = 0 do begin
      DelFile := PathOnly(FileName) + DirInfo.Name;
      deletefile(DelFile);
      Result := FindNext(DirInfo);
   end;
   FindClose(DirInfo);
end;

{************************************************************************
Copy files from source wildcard to destination folder
*************************************************************************}
Procedure   CopyFilesWC    (Source : string; DestPath : String);
var
   DirInfo  : TSearchRec;
   CopyFile  : String;
   Result   : Integer;
   Destination : String;
   FreeSearch : Boolean;
begin

   Result := FindFirst(Source, faAnyFile - faDirectory, DirInfo);
   FreeSearch := Result = 0;
   While Result = 0 do begin
      CopyFile := PathOnly(Source) + DirInfo.Name;
      Destination := AddBackSlash(DestPath) + DirInfo.Name;
      Windows.Copyfile(@CopyFile[1], @Destination[1], False);
      Result := FindNext(DirInfo);
   end;
   If FreeSearch then FindClose(DirInfo);
end;

{************************************************************************
Move files from source wildcard to destination folder
*************************************************************************}
Procedure   MoveFilesWC    (Source : string; DestPath : String);
var
   DirInfo  : TSearchRec;
   CopyFile  : String;
   Result   : Integer;
   Destination : String;
   FreeSearch : Boolean;
begin

   Result := FindFirst(Source, faAnyFile - faDirectory, DirInfo);
   FreeSearch := Result = 0;
   While Result = 0 do begin
      CopyFile := PathOnly(Source) + DirInfo.Name;
      Destination := AddBackSlash(DestPath) + DirInfo.Name;
      Windows.Movefile(@CopyFile[1], @Destination[1]);
      Result := FindNext(DirInfo);
   end;
   If FreeSearch then FindClose(DirInfo);
end;

{************************************************************************
Append files from source wildcard to destination folder
*************************************************************************}
Procedure   AppendFilesWC  (Source : string; DestPath : String);
var
   DirInfo  : TSearchRec;
   CopyFile  : String;
   Result   : Integer;
   Destination : String;
   FreeSearch : Boolean;
begin

   Result := FindFirst(Source, faAnyFile - faDirectory, DirInfo);
   FreeSearch := Result = 0;
   While Result = 0 do begin
      CopyFile := PathOnly(Source) + DirInfo.Name;
      Destination := AddBackSlash(DestPath) + DirInfo.Name;
      AppendFile(CopyFile, Destination);
      Result := FindNext(DirInfo);
   end;
   If FreeSearch then FindClose(DirInfo);
end;


{********************************************************************************}
{************************************************************************
*************************************************************************}
FUNCTION PathOnly (Path : String) : String;
VAR I : INTEGER;
BEGIN
   I := LENGTH (Path);
   WHILE (I > 0) AND
         (Path[I] <> ':') AND
         (Path[I] <> '\') DO
      Dec (I);
   PathOnly := COPY (Path, 1, I);
END;

{************************************************************************
*************************************************************************}
FUNCTION FileOnly (Path : String) : String;
VAR I : INTEGER;
BEGIN
   I := LENGTH (Path);
   WHILE (I > 0) AND (Path[I] <> ':') AND (Path[I] <> '\') DO
      DEC (I);
   FileOnly := COPY (Path, I+1, 65);
END;

{************************************************************************
Return just the extension of a file name.
*************************************************************************}
FUNCTION ExtensionOnly (PathName : String) : String;
Var I : Integer;
BEGIN
  I := Pos('.',PathName);
  If I = 0 Then
    ExtensionOnly := ''
  Else
    ExtensionOnly := Copy(PathName,I+1,3);
END;
{************************************************************************
Return just the name out of a complete pathname.
*************************************************************************}
FUNCTION NamePartOnly (PathName : String) : String;
Var I : Integer;
BEGIN
  PathName := FileOnly(PathName);
  For I := Length(PathName) downto 0 do begin
     If I = 0 then break;
     If PathName[I] = '.' then break;
  end;


  If I = 0 Then
    NamePartOnly := PathName
  Else
    NamePartOnly := Copy(PathName,1,I-1);
END;



{*************************************************************************}
Function    AppendFile    (FromFile, ToFile : String) : Boolean;
VAR
   InFile  : File;
   OutFile : File;
   I       : LongInt;
   B       : Byte;
   Buffer  : Array[1..1000] of Byte;
Begin
   Result := False;
   {$I-}
   If NOT FileExists(FromFile) Then Exit;
{   Writeln('Copying ',FromFIle);}
   AssignFile(InFile, FromFile);
   AssignFile(OutFile, ToFile);
   Reset(InFile, 1);
   If IOResult <> 0 then begin
      CloseFile(InFile); //cleanup
      UtilityLastError := 'IOResult = ' + Stri(IOResult,-1) + ' Opening ' + FromFile;
      exit;
   end;

   If FileExists(ToFile) then Begin
      Reset(OutFile, 1);
      If IOResult <> 0 then begin
         CloseFile(InFile); //cleanup
         CloseFile(OutFile);
         UtilityLastError := 'IOResult = ' + Stri(IOResult,-1) + ' Resetting ' + ToFile;
         exit;
      end;
      Seek(OutFile, FileSize(OutFile));
   end else
      ReWrite(OutFile, 1);
      If IOResult <> 0 then Begin
         CloseFile(InFile); //cleanup
         CloseFile(OutFile);
         UtilityLastError := 'IOResult = ' + Stri(IOResult,-1) + ' Rewriting ' + ToFile;
         exit;
      end;
   For I := 1 to FileSize(InFile) div 1000 do begin
      BlockRead(InFile, Buffer, 1000);
      BlockWrite(OutFile, Buffer, 1000);
   end;

   For I := 1 to (FileSize(InFile) - (FileSize(InFile) div 1000) * 1000) do Begin
      BlockRead(InFile, B, 1);
      BlockWrite(OutFile, B, 1);
   end;
   CloseFile(InFile);
   CloseFile(OutFile);
   Result := True;

end;

{*************************************************************}
Function    GetURL         (Text : String) : String;
var
   Index : integer;
   outstring : String;
Begin
   OutString := '';
   GetURL := '';
   Index     := pos('HREF', UpCaseString(Text));
   if Index = 0 then Exit;
   while (Index < length(Text)) and (Text[Index] <> '"') do
      Index := Index + 1;
   Index := Index + 1;
   while (Index < length(Text)) and (Text[Index] <> '"') do begin
      Outstring := OutString + Text[Index];
      Index := Index + 1;
   end;
   GetURL := OutString;
end;
{*************************************************************}
Function    GetTitle         (Text : String) : String;
var
   Index : integer;
   outstring : String;
Begin
   OutString := '';
   GetTitle := '';
   Index     := pos('<TITLE>', UpCaseString(Text));
   if Index = 0 then Exit;
   while (Index < length(Text)) and (Text[Index] <> '>') do
      Index := Index + 1;
   Index := Index + 1;
   while (Index < length(Text)) and (Text[Index] <> '<') do begin
      Outstring := OutString + Text[Index];
      Index := Index + 1;
   end;
   GetTitle := OutString;
end;

Function    StripTabs      (Text : String) : String;
var
  Index : Integer;
  nTabs : Integer;
Begin
   Index := 1;
   nTabs := 0;
   While (Index <= Length(Text)) and (Text[Index] = #9) do begin
      NTabs := NTabs + 1;
      Index := Index + 1;
   end;
   Delete(Text, 1, NTabs);
   StripTabs := Text;
end;

Procedure AppendFileStr(FN : String; AppString : String);
VAR
   AppFile : TextFile;
Begin
   AssignFile(AppFile, FN);
   If FileExists(FN) then
      Append(AppFile)
   else
      Rewrite(AppFile);

   Writeln(AppFile, AppString);
   CloseFile(AppFile);
end;

Procedure AppendFileBin(FN : String; AppString : String);
VAR
   AppFile : TextFile;
Begin
   AssignFile(AppFile, FN);
   If FileExists(FN) then
      Append(AppFile)
   else
      Rewrite(AppFile);

   Write(AppFile, AppString);
   CloseFile(AppFile);
end;

Function    StrCmp         (StrA, StrB : String) : Integer;
var
   I : Integer;
Begin
   For I := 1 to length(StrA) do begin
      StrCmp := I;
      If Length(StrB) < I then Exit;
      If StrA[I] <> StrB[I] then Exit;
   end;
   if Length(StrA) = Length(StrB) then begin
      StrCmp := 0;
      Exit;
   end;
   StrCmp := length(StrA) + 1;
end;


Procedure   SaveListViewToFile(TView : TListView; FName : String);
var
   Item : TListItem;
   I : Integer;
   J : Integer;
   OutFile : Text;
Begin
   Assign(OutFile, FName);
   try
      ReWrite(OutFile);
   except
      On Exception do exit;
   end;

   For I := 0 to TView.Items.Count -1 do begin
      Item := TView.Items[I];
      Write(OutFile, Item.Caption);
      If Item.SubItems.Count <> 0 then Write(OutFile, Chr(9));
      For J := 0 to Item.SubItems.Count - 1 do begin
         Write(OutFile, Item.SubItems[J]);
         If J < (Item.SubItems.Count - 1) then
            Write(OutFile, Chr(9));
      end;
      Writeln(OutFile);
   end;
   CloseFile(OutFile);
end;


Procedure   LoadListViewFromFile(TView : TListView; FName : String);
var
   InStr    : String;
   ItmCapt  : String;
   ParseStr : String;
   InFile   : Text;
   NewItem  : TListItem;
Begin
   If Not FileExists(FName) then exit;
   Assign(InFile, FName);
   Try
      Reset(InFile);
   except on Exception do exit; end;

   TView.Items.Clear;

   While not eof (InFile) do begin
      ReadLn(InFile, InStr);
      ItmCapt := ParseToChar(InStr, chr(9));
      if ItmCapt <> '' then begin
         NewItem := TView.Items.Add;
         ParseStr := ParseToChar(InStr, Chr(9));
         While ParseStr <> '' do begin
            NewItem.SubItems.Add(ParseStr);
            ParseStr := ParseToChar(InStr, Chr(9));
         end;
         NewItem.Caption := ItmCapt;
      end;
   end;
   CloseFile(InFile);

end;

Function    ParseToChar    (VAR AString : String; AChar : Char) : String;
var
   I        : Integer;
Begin
   I := POS(AChar, AString);

   // If there is no match, then return the whole string
   If I = 0 then begin
      ParseToChar := AString;
      AString := '';
      exit;
   end;

   ParseToChar := copy(AString, 1, I - 1);
   Delete(AString, 1, I);
end;


Function CurrentDrive : String;
var
   CurrentDriveStr : String;
Begin
   CurrentDriveStr := GetCurrentDir;
   SetLength(CurrentDriveStr, 2);
   CurrentDrive := CurrentDriveStr;
end;

Procedure   ReplaceCharWithChar(VAR Text : String; ReplaceC : Char; WithC : Char);
VAR
   I : Integer;
Begin
   For I := 1 to length(Text) do
      if (Text[I] = ReplaceC) then Text[I] := WithC;
end;


{*************************************************************************}


Procedure   CopyFile(FromFile, ToFile : String);
VAR
   InFile  : File;
   OutFile : File;
   I       : LongInt;
   B       : Byte;
   Buffer  : Array[1..1000] of Byte;
Begin

   {$I-}
   If NOT FileExists(FromFile) Then Exit;
   AssignFile(InFile, FromFile);
   AssignFile(OutFile, ToFile);
   Reset(InFile, 1);
   ReWrite(OutFile, 1);
   For I := 1 to FileSize(InFile) div 1000 do begin
      BlockRead(InFile, Buffer, 1000);
      BlockWrite(OutFile, Buffer, 1000);
   end;

   For I := 1 to (FileSize(InFile) - (FileSize(InFile) div 1000) * 1000) do Begin
      BlockRead(InFile, B, 1);
      BlockWrite(OutFile, B, 1);
   end;
   CloseFile(InFile);
   CloseFile(OutFile);

end;

{*************************************************************************}

Function    LetterOfDayOfWeek(ADate : TDateTime) : String;
var
   DOW : Integer;
Begin
   DOW := DayOfWeek(ADate);
   Case DOW of
      1: LetterOfDayOfWeek := 'Su';
      2: LetterOfDayOfWeek := 'Mo';
      3: LetterOfDayOfWeek := 'Tu';
      4: LetterOfDayOfWeek := 'We';
      5: LetterOfDayOfWeek := 'Th';
      6: LetterOfDayOfWeek := 'Fr';
      7: LetterOfDayOfWeek := 'Sa';
   end;
end;

Function LastDayOfWeek(ADOW : Integer; ADate : TDateTime) : TDateTime;
Begin
   While DayOfWeek(ADate) <> ADOW do
      ADate := ADate - 1;
   Result := ADate;
end;

{*************************************************************************}
Function    GoodDiv(Numerator, Denominator : Real) : Real;
Begin
   If Denominator = 0 then begin
      GoodDiv := 0;
      exit;
   end;
   GoodDiv := Numerator / Denominator;
end;
{*************************************************************************}
Function    Lesser(Val1, Val2 : Integer) : Integer; //Returns the Lesser of the 2 vals
Begin
   If Val1 < Val2 then Lesser := Val1
   else Lesser := Val2;
end;
{*************************************************************************}
Function    Greater(Val1, Val2 : Integer) : Integer; //Returns the Greater of the 2 vals
Begin
   If Val1 > Val2 then Greater := Val1
   else Greater := Val2;
end;

{*************************************************************************}
Function    LongMoney(AVal : Real) : String;
VAR
   MStr : String;
   //***********************************************
   Function OneLenCaseStr(AString : String) : String;
   Begin
      Case Valu(AString) of
         1  : OneLenCaseStr := 'One';
         2  : OneLenCaseStr := 'Two';
         3  : OneLenCaseStr := 'Three';
         4  : OneLenCaseStr := 'Four';
         5  : OneLenCaseStr := 'Five';
         6  : OneLenCaseStr := 'Six';
         7  : OneLenCaseStr := 'Seven';
         8  : OneLenCaseStr := 'Eight';
         9  : OneLenCaseStr := 'Nine';
         10 : OneLenCaseStr := 'Ten';
         11 : OneLenCaseStr := 'Eleven';
         12 : OneLenCaseStr := 'Twelve';
         13 : OneLenCaseStr := 'Thirteen';
         14 : OneLenCaseStr := 'Fourteen';
         15 : OneLenCaseStr := 'Fifteen';
         16 : OneLenCaseStr := 'Sixteen';
         17 : OneLenCaseStr := 'Seventeen';
         18 : OneLenCaseStr := 'Eighteen';
         19 : OneLenCaseStr := 'Nineteen';
      end;
   End;
   //***********************************************
   Function TwoLenCaseStr(AString : String) : String;
   VAR
      LastOne : String;
      OutStr  : String;
   Begin
      LastOne := OneLenCaseStr(AString[2]);
      If Valu(AString) in [1..19] then begin
         TwoLenCaseStr := OneLenCaseStr(AString)
      end else begin
         Case AString[1] of
            '2' : OutStr := 'Twenty';
            '3' : OutStr := 'Thirty';
            '4' : OutStr := 'Forty';
            '5' : OutStr := 'Fifty';
            '6' : OutStr := 'Sixty';
            '7' : OutStr := 'Seventy';
            '8' : OutStr := 'Eighty';
            '9' : OutStr := 'Ninety';
         end;
         If LastOne = '' then
            TwoLenCaseStr := OutStr
         else
            TwoLenCaseStr := OutStr + '-' + LastOne;
      end;
   end;
   //***********************************************
   Function ThreeLenCaseStr(AString : String) : String;
   Begin
      If AString[1] <> ' ' then
         ThreeLenCaseStr := OneLenCaseStr(AString[1]) + ' Hundred ' + TwoLenCaseStr(Copy(AString, 2,2))
      else
         ThreeLenCaseStr := TwoLenCaseStr(Copy(AString, 2,2));
   End;
   //***********************************************
   Function SixLenCaseStr(AString : String) : String;
   Begin
      If Copy(AString,1,3) <> '   ' then
         SixLenCaseStr := ThreeLenCaseStr(Copy(AString,1,3)) + ' Thousand ' + ThreeLenCaseStr(Copy(AString, 4,3))
      else
         SixLenCaseStr := ThreeLenCaseStr(Copy(AString, 4,3));
   End;

Begin
   MStr := Stri(Trunc(AVal), -1);

   if MStr = '' then begin
      LongMoney := '';
      exit;
   end;
   While Length(MStr) < 6 do
      MStr := ' ' + MStr;

   LongMoney := SixLenCaseStr(MStr) + ' and ' + Stri(Round((AVal - Trunc(AVal)) * 100), 2) + '/100';


end;
{*************************************************************************}
Procedure   CWriteln(Canvas : TCanvas; var X : LongInt; var Y : LongInt; Astring : String);
Begin
   Canvas.TextOut(X,Y,AString);
   Y := Y - Canvas.Font.Height;
end;
{*************************************************************************}
Procedure   CWrite(Canvas : TCanvas; var X : LongInt; var Y : LongInt; Astring : String);
Begin
   Canvas.TextOut(X,Y,AString);
   X := X + Canvas.TextWidth(AString);
end;
{*************************************************************************}
Procedure   CCentWriteln(Canvas : TCanvas; var X : LongInt; var Y : LongInt;
                         Width : Longint; Astring : String);
Var
   OrigX : Integer;
Begin
   OrigX := X;
   X := X + (Width Div 2) - (Canvas.TextWidth(AString) Div 2);
   Canvas.TextOut(X, Y, AString);
   Y := Y - Canvas.Font.Height;
   X := OrigX;
end;
{*************************************************************************}
Procedure   CRightWriteLn(Canvas : TCanvas; var X : LongInt; var Y : LongInt;
                        Width : Longint; Astring : String);
Var
   OrigX : Integer;
Begin
   OrigX := X;
   X := X + Width - Canvas.TextWidth(AString);
   Canvas.TextOut(X, Y, AString);
   Y := Y - Canvas.Font.Height;
   X := OrigX;
end;
{*************************************************************************}
Function GetWord(VAR AString: String) : String;
var
   I : Integer;
Begin
   GetWord := '';
   I := pos(' ', AString);
   If I = 0 then begin
     If AString = '' then exit;
      GetWord := AString;
      AString := '';
      Exit;
   end;
   GetWord := Copy(AString,1, I);
  Delete(AString, 1, I);
end;
{*************************************************************************}
Procedure   CWWWriteLn(Canvas : TCanvas; var X : LongInt; var Y : LongInt;
                       Width : Longint; Astring : String);
Var
   XOrig :LongInt;
   AWord : String;

Begin
   XOrig := X;
   AWord := GetWord(AString);
   While AWord <> '' do begin
      if (X + Canvas.TextWidth(AWord)) > (XOrig + Width) then begin
         X := XOrig;
         Y := Y - Canvas.Font.Height;
      end;
      CWrite(Canvas, X,Y,AWord);
      AWord := GetWord(AString);
   end;
   X := XOrig;
   Y := Y - Canvas.Font.Height;

end;
{*************************************************************************}
Function    DateTimeToSString(ADate : TDateTime) : String;
Begin
   Result := FormatDateTime('YYMMDD', ADate);
end;
{*************************************************************************}
Function    DateTimeToLString(ADate : TDateTime) : String;
Begin
   Result := FormatDateTime('YYYYMMDDHHMMSS', ADate);
end;
{*************************************************************************}
Function    SStringToDateTime(ADate : String) : TDateTime;
var
   DateStr : String;
begin
   Result := 0;
   If Length(ADate) <> 6 then exit;
   DateStr := copy(ADate, 3,2) + '/' + Copy(ADate, 5,2) + '/' + Copy(ADate, 1,2);
   Try
      Result := StrToDate(DateStr);
   Except
      On E:Exception do
         Result := 0;
   end;
end;
{*************************************************************************}
Function    LStringToDateTime(ADate : String) : TDateTime;
var
   DateStr : String;
begin
   Result := 0;
   If Length(ADate) <> 8 then exit;
   DateStr := copy(ADate, 5,2) + '/' + Copy(ADate, 7,2) + '/' + Copy(ADate, 1,4);
   Try
      Result := StrToDate(DateStr);
   Except
      On E:Exception do
         Result := 0;
   end;
end;
{*************************************************************************}
Function NumericOnly(AString : String): String;
var
   I : integer;
Begin
   Result := '';
   For I := 1 to length(AString) do
      If AString[I] in ['0'..'9'] then
      Result := Result + AString[I];
end;
Function IsNumeric(AString : String) : Boolean;
Begin
   Result := NumericOnly(AString) = AString;
end;

Function    DateCharsOnly(AString : String) : String;               //Returns string with only 0-9 and /
var
   I : integer;
Begin
   Result := '';
   For I := 1 to length(AString) do
      If AString[I] in ['0'..'9','/'] then
      Result := Result + AString[I];
end;

Function    IsValidDateString(ADateStr : String) : Boolean;         //Returns True if valid date
var
   WS : String;
   M,D,Y : Word;
begin
   ADateStr := DateCharsOnly(ADateStr);
   M := Valu(ParseToChar(ADateStr,'/'));
   D := Valu(ParseToChar(ADateStr,'/'));
   Y := Valu(ParseToChar(ADateStr,'/'));

   Try
      EncodeDate(Y,M,D);
      Result := True;
   except
      on E:Exception do begin
         Result := False;
      end;
   end;
end;

{*************************************************************************}
Function AlphaOnly(AString : String): String;
var
   I : integer;
Begin
   Result := '';
   For I := 1 to length(AString) do
      If (AString[I] in ['A'..'Z']) or (AString[I] in ['a'..'z']) then
      Result := Result + AString[I];
end;

{*************************************************************************}
Function AlphaNumericOnly(AString : String): String;
var
   I : integer;
Begin
   Result := '';
   For I := 1 to length(AString) do
      If (AString[I] in ['A'..'Z']) or (AString[I] in ['a'..'z']) or (AString[I] in ['0'..'9'])then
      Result := Result + AString[I];
end;
{*************************************************************************}
Function GUIDOnly(AString : String): String;
var
   I : integer;
Begin
   Result := '';
   For I := 1 to length(AString) do
      If (AString[I] in ['A'..'F','0'..'9','-' ])then
      Result := Result + AString[I];
end;

{*************************************************************************}
Function IntToTime(ATime : Integer) : TDateTime;
Begin
   Result := 0;
   Try
     Result := EncodeTime(ATime div 100, ATime mod 100, 0,0);
   except
      On E:Exception do begin
         //If there's an exception the result will be 0
      end;
   end;
end;

Function    MMDDYYYYToDateTime(AStr : String): TDateTime;
Begin
   Result := 0;
   AStr := Trim(AStr);
   If Trim(AStr) = '' then exit;
   Try
      Result := EncodeDate(Valu(Copy(AStr,5,4)),
                           Valu(Copy(AStr,1,2)),
                           Valu(Copy(AStr,3,2)));
   except
      on E:Exception do begin
      end;
   end;
end;

Function    MMDDYYToDateTime(AStr : String): TDateTime;
var
  Y : Integer;
Begin
   Result := 0;
   AStr := Trim(AStr);
   If Trim(AStr) = '' then exit;
   Y := Valu(Copy(AStr,5,4));
   If Y <20 then
      Y := Y + 2000
   else
      Y := Y + 1900;
   Try
      Result := EncodeDate(y,
                           Valu(Copy(AStr,1,2)),
                           Valu(Copy(AStr,3,2)));
   except
      on E:Exception do begin
      end;
   end;
end;
{*************************************************************************}

Function ComputeLevel(VAR AString : String) : Integer;
VAR
   Level : Integer;
Begin
   Level := 0;
   While (Length(AString) > 0) AND (AString[1] = chr(9)) do begin
      inc(Level);
      AString := copy(AString, 2, length(AString) - 1);
   end;
   ComputeLevel := Level;
end;
{*************************************************************************}
Function    IsNum(ANumber : String) : Boolean;
var
  I : Integer;
Begin
   IsNum := False;
   For I := 1 to length(ANumber) do
      if not (ANumber[I] in [' ','.', '0'..'9']) then exit;

   If Valu(ANumber) > 0 then Begin
      IsNum := True;
      Exit;
   end;
   IsNum := True;
   For I := 1 to length(ANumber) do
      if Not (ANumber[I] in [' ', '0']) then IsNum := False;
end;

Function    IsAlphaChar(AChar : Char) : Boolean;
Begin
   Result := ((AChar >= 'a') and (AChar <= 'z')) or
             ((AChar >= 'A') and (AChar <= 'Z'));
end;

Function    AlphasOnly(AString : String) : String;
Var
  I : Integer;
Begin
   Result := '';
   For I := 1 to length(AString) do begin
      If IsAlphaChar(AString[I]) then
         Result := Result + AString[I];
   end;
end;

{*************************************************************************}
Function    IsOnlyNumbers(ANumber : String) : Boolean;
var
  I : Integer;
Begin
   Result := False;
   For I := 1 to length(ANumber) do
      if not (ANumber[I] in [' ', '0'..'9']) then exit;
   Result := True;

end;

Function    IsFloat(ANumber : String) : Boolean;
var
  I : Integer;
Begin
   IsFloat := False;
   ANumber := DelLstSpcs(ANumber, 100);
   For I := 1 to length(ANumber) do
      if not (ANumber[I] in ['-','.', '0'..'9']) then exit;
   IsFloat := True;
end;

Procedure ExpandTreeNode(ANode : TTreeNode);
var
   TravNode : TTreeNode;
Begin
   ANode.Expanded := True;
   TravNode := ANode.GetFirstChild;
   While TravNode <> NIL do begin
      ExpandTreeNode(TravNode);
      TravNode := ANode.GetNextChild(TravNode);
   end;
end;
Procedure CollapseTreeNode(ANode : TTreeNode);
var
   TravNode : TTreeNode;
Begin
   ANode.Expanded := False;
   TravNode := ANode.GetFirstChild;
   While TravNode <> NIL do begin
      CollapseTreeNode(TravNode);
      TravNode := ANode.GetNextChild(TravNode);
   end;
end;


Procedure ExpandUnitsOnly(ANode : TTreeNode);
var
   TravNode : TTreeNode;
   HasKids  : Boolean;
Begin
   HasKids := False;
   TravNode := ANode.GetFirstChild;
   While TravNode <> NIL do begin
      If Not IsNum(TravNode.Text) then begin
         ExpandUnitsOnly(TravNode);
         HasKids := True;
      end;
      TravNode := ANode.GetNextChild(TravNode);
   end;

   ANode.Expanded := HasKids;
end;



Procedure ObjectClear(AStringList : TStringList);
var
   I : integer;
Begin
   If AStringList.Count = 0 then exit;
   
   For I := 0 to AStringList.Count - 1 do
      If AStringList.Objects[I] <> NIL then
         AStringList.Objects[I].free;

   AStringList.Clear;

end;
Procedure PointerClear(AStringList : TStringList);
var
   I : integer;
Begin
   If AStringList.Count = 0 then exit;

   For I := 0 to AStringList.Count - 1 do
      If AStringList.Objects[I] <> NIL then
         StrDispose(Pointer(AStringList.Objects[I]));
   AStringList.Clear;
end;


Function  ScopeEOF(VAR AFile : TextFile) : Boolean;
Begin
   Result := EOF(AFile);
end;


Function EOLCrypt(InStr : String) : String;
Var
   I : integer;
   Count : Byte;
begin
   Result := '';
   For I := 1 to Length(InStr) do begin
      Count := ord(Instr[I]);
      If I <> 1 then
         Count := Count + Ord(Result[I-1]);
      Count := (241 XOR Count);
      If Count = 27 then
         Result := Result + Chr(27) + Chr(27)
      else if count = 10 then
         Result := Result + Chr(27) + Chr(0)
      else if count = 13 then
         Result := Result + Chr(27) + Chr(1)
      else
         Result := Result + Chr(Count);
   end;
end;
Function XORCrypt(InStr : String) : String;
Var
   I : integer;
begin
   Result := '';
   For I := 1 to Length(InStr) do begin
      Result := Result + Chr(ord(Instr[I]) Xor 255);
   end;
end;


Function DigitsOnly(InStr : String) : String;
var
   I : Integer;
Begin
   Result := '';
   For I := 1 to length(InStr) do
      If InStr[I] in ['0'..'9'] then Result := Result + InStr[I]; 
end;


Procedure StripTrailingComma(VAR AString : String);
var
   I : Integer;
Begin
   I := Length(AString);
   While (I > 0) AND (AString[I] in [' ', ',']) do begin
      SetLength(AString, I - 1);
      Dec(I);
   end;

end;
Procedure StripTrailingCloseParen(VAR AString : String);
var
   I : Integer;
   Found : Boolean;
Begin
   I := Length(AString);

   Found := False;
   While (I > 0) AND (NOT FOUND) AND (AString[I] in [' ', ')']) do begin
      Found := AString[I] = ')';
      SetLength(AString, I - 1);
      Dec(I);
   end;

end;

Function StripTrailingAND(AString : String) : String;
Var
   WorkStr : String;
Begin
   WorkStr := Trim(AString);
   Result := AString;
   If Length(AString) < 3 then exit;
   If POS('AND', UpCaseString(AString)) = 0 then Exit;
   If Copy(UpCaseString(WorkStr), Length(WorkStr) - 2,3) = 'AND' then
      SetLength(WorkStr, Length(WorkStr) - 3);
   Result := WorkStr;
end;

Function  StripTrailingOR(AString : String) : String;
Var
   WorkStr : String;
Begin
   WorkStr := Trim(AString);
   Result := AString;
   If Length(AString) < 2 then exit;
   If POS('OR', UpCaseString(AString)) = 0 then Exit;
   If Copy(UpCaseString(WorkStr), Length(WorkStr) - 1,2) = 'OR' then
      SetLength(WorkStr, Length(WorkStr) - 2);
   Result := WorkStr;
end;

Function SpectrumDate(ADate : String) : TDateTime;
var
   Year, Month, Day : Word;
Begin
   Result := 0;
   If NOT (Length(ADate) in [6,8]) then exit;
   If Length(ADate) = 6 then begin
      Year := Valu(Copy(ADate, 1, 2));
      If Year < 10 then Year := Year + 2000 else Year := Year + 1900;
      Month := Valu(Copy(ADate, 3, 2));
      Day := Valu(Copy(ADate, 5, 2));
   end else begin
      Year := Valu(Copy(ADate, 1, 4));
      Month := Valu(Copy(ADate, 5, 2));
      Day := Valu(Copy(ADate, 7, 2));
   end;
   Try
      REsult := EncodeDate(Year, Month, Day);
   Except
      On E:Exception do
         Result := 0;
   end;
End;


Function EscapeDoubleQuotes(InStr : String) : String;
var
   I : integer;
Begin
   Result := '';
   For I := 1 to Length(InStr) do
      If InStr[I] = '"' then
         Result := Result + '""'
      else
         Result := Result + InStr[I];

end;
Function EscapeDoubleWithSingleQuotes(InStr : String) : String;
var
   I : integer;
Begin
   Result := '';
   For I := 1 to Length(InStr) do
      If InStr[I] = '"' then
         Result := Result + '''"'
      else
         Result := Result + InStr[I];

end;

Function EscapeSingleQuotes(InStr : String) : String;
var
   I : integer;
Begin
   Result := '';
   For I := 1 to Length(InStr) do
      if InStr[I] = '''' then
         Result := Result + ''''''
      else
         Result := REsult + InStr[I];

end;

Function SQLString(AValue : String) : String;
Begin
   AValue := EscapeDoubleQuotes(AValue);
   AValue := EscapeSingleQuotes(AValue);
   If Trim(AValue) = '' then Result := 'NULL' else
      If IsNum(AValue) then
         Result := AValue
      else
         Result := '''' + AValue + '''';
end;

Function SQLInteger(AValue : Integer) : String;
Begin
   If AValue = 0 then
      Result := 'NULL'
   else
      Result := stri(AValue, -1);
end;

Function SQLFloat(AValue : Double; Places : Integer) : String;
Begin
   If AValue = 0 then
      Result := 'NULL'
   else
      Result := DelLstSpcs(StriReal(AValue, Places), 100);
end;

Function SQLDate   (AValue : TDateTime) : String;
Begin
   If AValue = 0 then
      Result := 'NULL'
   else begin
      AValue := DateWindow(AValue);
      If AValue = Trunc(AValue) then
         Result := '''' + FormatDateTime('mm/dd/yyyy', AValue) + ''''
      else
         Result := '''' + FormatDateTime('mm/dd/yyyy hh:mm:ss', AValue) + ''''

   end;
end;
Function UploadDate   (AValue : TDateTime) : String;
Begin
   If AValue = 0 then
      Result := ''
   else begin
      AValue := DateWindow(AValue);
      If AValue = Trunc(AValue) then
         Result := FormatDateTime('mm/dd/yyyy', AValue)
      else
         Result := FormatDateTime('mm/dd/yyyy hh:mm:ss', AValue);

   end;
end;


Function  SQLValue(AField : TField): String;
var
   TempVal : String;
Begin
   Result := '';
   If AField = NIL then begin
      exit;
   end;

   If AField.DataType = ftMemo then begin
      Result := '''';
      exit;
   end;
   
   TempVal := AField.AsString;

   ReplaceString(TempVal, '''''', '''');
   TempVal := EscapeSingleQuotes(TempVal);
   If TempVal = '' then Result := 'NULL' Else
      IF AField.DataType in [ftString, ftDate, FTDateTime] then
         Result := '''' + TempVal +''''
      else if AField.DataType = ftBoolean then begin
         If AField.AsBoolean then
            Result := '1'
         else
            Result := '0';
      end else
         Result := TempVal;
end;

Type
   PEnumWindowsRec = ^TEnumWindowsRec;
   TEnumWindowsRec = Record
      WindowCaption : String;
      WindowCmd     : Integer;
   end;

   function EnumWndProc1(h : THandle; lParam : integer) : boolean; stdcall;
   var
      zWndName   : array[0..101] of char;
      hParent    : THandle;
      P          : PEnumWindowsRec;
   begin
      P := PEnumWindowsRec(LParam);
      result := true;
      while true do begin
         hParent := GetWindow(h,GW_Owner);
         if hParent = 0 then
            break;
         h := hParent;
      end;
      fillchar(zWndName,sizeof(zWndName),0);
      GetWindowText(h,zWndName,100);
      If POS(UpCaseString(P^.WindowCaption), UpCaseString(StrPas(zWndName))) > 0 then
         ShowWindow(h, P^.WindowCmd);
   end;

Procedure FindAndShowWindow(WindowCaption : String; ShowCmd : Integer);
Var
   FindSpecs : TEnumWindowsRec;
begin
   FindSpecs.WindowCaption := WindowCaption;
   FindSpecs.WindowCmd := ShowCmd;
   try
      // check every running task and fill it into slWindowText
      EnumWindows(@enumWndProc1,Integer(@FindSpecs));
   finally
   end;
end;
//**************************************************************
Function FindWindowContaining(WindowCaption : String) : Integer;
Var
   FindSpecs : TEnumWindowsRec;
   function EnumWndProc1(h : THandle; lParam : integer) : boolean; stdcall;
   var
      zWndName   : array[0..101] of char;
      hParent    : THandle;
      P          : PEnumWindowsRec;
   begin
      P := PEnumWindowsRec(LParam);
      result := true;
      while true do begin
         hParent := GetWindow(h,GW_Owner);
         if hParent = 0 then
            break;
         h := hParent;
      end;
      fillchar(zWndName,sizeof(zWndName),0);
      GetWindowText(h,zWndName,100);
      If (H<> 0) and (POS(UpCaseString(P^.WindowCaption), UpCaseString(StrPas(zWndName))) > 0) then
         P^.WindowCmd := H;
   end;
begin
   FindSpecs.WindowCaption := WindowCaption;
   FindSpecs.WindowCmd := 0;
   try
      // check every running task and fill it into slWindowText
      EnumWindows(@enumWndProc1,Integer(@FindSpecs));
   finally
   end;
   Result := FindSpecs.WindowCmd;
end;
//**************************************************************
Function PadLeft(AString : String; StrLength : Integer) : String;
Begin
    While Length(AString) < StrLength do
       AString := ' ' + AString;

    Result := AString;
end;

Function ZeroPadLeft(AString : String; StrLength : Integer) : String;
Begin
    While Length(AString) < StrLength do
       AString := '0' + AString;

    Result := AString;
end;

Function PadRight(AString : String; StrLength : Integer) : String;
Begin
    While Length(AString) < StrLength do
       AString := AString + ' ';

    Result := AString;
end;

Procedure CopyRowToClipboard(AGrid : TDBGrid);
Var
   ASL : TStringList;
   I : Integer;
   DS : TDataSet;
   AStr : String;
Begin
   ASL := TStringList.Create;
   AStr := '';

   For I := 0 to AGrid.Columns.Count -1 do begin
      AStr := AStr + AGrid.Columns[I].Title.Caption + #9;
   end;
   Asl.Add(Astr);

   DS := AGrid.DataSource.DataSet;
   DS.DisableControls;
   AStr := '';
   For I := 0 to AGrid.Columns.Count - 1 do begin
      AStr := AStr + DS.FieldByName(AGrid.Columns[I].FieldName).AsString + Chr(9);
   End;
   ASL.Add(AStr);
   Application.ProcessMessages;
   AStr := ASL.Text;
   ClipBoard.SetTextBuf(@AStr[1]);
   DS.EnableControls;
   ASL.Free;
   MessageBeep(0);
end;
Procedure CopyGridToClipboard(AGrid : TDBGrid);
begin
   CopyGridToClipboardPB(AGrid,Nil);
end;

Procedure CopyGridToClipboardPB(AGrid : TDBGrid;APB : TProgressBar);
Var
   ASL : TStringList;
   I : Integer;
   DS : TDataSet;
   AStr : String;
   X : Integer;
Begin
   ASL := TStringList.Create;

   X := 0;
   AStr := '';
   If GlobalCopyGridFieldNames then begin
      For I := 0 to AGrid.Columns.Count -1 do begin
         AStr := AStr + AGrid.Columns[I].Title.Caption + #9;
      end;
      Asl.Add(Astr);
   end;

   DS := AGrid.DataSource.DataSet;
   DS.DisableControls;
   DS.First;
   While NOT DS.EOF do begin
      Inc(X);
      AStr := '';
      For I := 0 to AGrid.Columns.Count - 1 do begin
         AStr := AStr + DS.FieldByName(AGrid.Columns[I].FieldName).AsString + Chr(9);
      End;
      ASL.Add(AStr);
      DS.Next;
      If assigned(APB) then
         APB.Position := X Mod 100;
      Application.ProcessMessages;
   end;
   AStr := ASL.Text;
   ClipBoard.SetTextBuf(@AStr[1]);
   DS.First;
   DS.EnableControls;
   ASL.Free;
   MessageBeep(0);
end;

Procedure CopyGridStringToClipboard(AGrid : TDBGrid;AMessage : String);
Var
   ASL : TStringList;
   I : Integer;
   DS : TDataSet;
   AStr : String;
Begin
   ASL := TStringList.Create;
   ASL.Add(AMessage);
   DS := AGrid.DataSource.DataSet;
   DS.DisableControls;
   DS.First;
   While NOT DS.EOF do begin
      AStr := '';
      For I := 0 to AGrid.Columns.Count - 1 do begin
         AStr := AStr + DS.FieldByName(AGrid.Columns[I].FieldName).AsString + Chr(9);
      End;
      ASL.Add(AStr);
      DS.Next;
   end;
   AStr := ASL.Text;
   ClipBoard.SetTextBuf(@AStr[1]);
   DS.First;
   DS.EnableControls;
   ASL.Free;
   MessageBeep(0);
end;

  //********************************************
  Function RTKMoney(InStr : String): String;
  Begin
     RTKMoney := '';
     DelLstSpcs(InStr, 100);
     if Length(InStr) <= 2 then exit;
     RTKMoney := copy(InStr, 1, Length(InStr)-2) + '.' + copy(InStr,Length(InStr)- 1, 2);
  end;


  Function FloatToRTK(InFloat : Real): String;
  Begin
     If InFloat = 0 then
        Result := '0'
     else
        Result := DelLstSpcs(StriReal(InFloat, 2), 100);
        
     ReplaceString(Result, '.', '');
  end;

  //********************************************
  Function RTKDate(InStr : String): String;
  Begin
     RTKDate := '';
     DelLstSpcs(InStr, 100);
     If length (InStr) < 6 then exit;
     RTKDate := copy(InStr, 3, 2) + '/' + copy(InStr, 5, 2) + '/' + copy(InStr, 1, 2);
  end;
  //********************************************
   Function MakeTempRTKCode(TitleCode: Integer): String;
   VAR
      RCode : String;
   Begin
      RCode := STRI(TitleCode, -1);
      While Length(RCode) < 7 do
         RCode := '0' + RCode;
      Result := 'T_' + RCode;
   end;
   //******************************************************



Function GetParenContents(InStr : String) : String;
var
   ParenStr : String;
Begin
   Result := '';
   If Pos('(', InStr) = 0 then exit;
   ParenStr := ParseToChar(InStr,'(');
   Result := ParseToChar(InStr, ')');
end;

Function StripAllHTMLTags(var Instr :String) : String;
var
   WorkStr : String;
begin
   WorkStr := InStr;
   While WorkStr <> StripHTMLTag(InStr) do
      WorkStr := InStr;
   Result := InStr;
end;

Function StripHTMLTag(var Instr :String) : String;
Var
   StartPos : Integer;
   EndPos : integer;
Begin
   Result := InStr;
   StartPos := Pos('<', InStr);
   EndPos := Pos('>', InStr);
   If StartPos = 0 then exit;   
   If (EndPos < StartPos) And (EndPos <> 0) then begin
      InStr[EndPos] := ' ';
      EndPos := Pos('>', InStr);
   end;
   If EndPos = 0 then begin
      Result := Copy(InStr, StartPos + 1, Length(InStr) - StartPos);
      EndPos := Length(InStr);
   end else
      Result := Copy(InStr, StartPos + 1, EndPos - StartPos - 1);

   Delete(InStr, StartPos,EndPos - StartPos + 1);
end;

Function ReplaceAllHTMLTags(var Instr :String; RString : String) : String;
var
   WorkStr : String;
begin
   WorkStr := InStr;
   While WorkStr <> ReplaceHTMLTag(InStr, RString) do
      WorkStr := InStr;
   Result := InStr;
end;

Function ReplaceHTMLTag(var Instr :String;RString : String) : String;
Var
   StartPos : Integer;
   EndPos : integer;
Begin
   Result := InStr;
   StartPos := Pos('<', InStr);
   EndPos := Pos('>', InStr);
   If StartPos = 0 then exit;
   If (EndPos < StartPos) And (EndPos <> 0) then begin
      InStr[EndPos] := ' ';
      EndPos := Pos('>', InStr);
   end;
   If EndPos = 0 then begin
      Result := Copy(InStr, StartPos + 1, Length(InStr) - StartPos);
      EndPos := Length(InStr);
   end else
      Result := Copy(InStr, StartPos + 1, EndPos - StartPos - 1);

   Delete(InStr, StartPos,EndPos - StartPos + 1);
   Insert(RString, InStr, StartPos);
end;

Function GetVolumeFileSystem(DriveLetter : String) : String;
var
   VolumeSerial :DWord;
   FileSysName : Array[0..255] of char;
   FileSysFlags: DWord;
   MaxCompLen  : DWord;
   VolumeName  : Array[0..255] of char;
Begin
   IF NOT GetVolumeInformation(@DriveLetter[1], @VolumeName, 255, @VolumeSerial, MaxCompLen, FileSysFlags,@FileSysName, 255)
      then Result := ''
   else
      Result := StrPas(FileSysName);
end;

Function GetVolumeName(DriveLetter : String) : String;
var
   VolumeSerial :DWord;
   FileSysName : Array[0..255] of char;
   FileSysFlags: DWord;
   MaxCompLen  : DWord;
   VolumeName  : Array[0..255] of char;
Begin
   IF NOT GetVolumeInformation(@DriveLetter[1], @VolumeName, 255, @VolumeSerial, MaxCompLen, FileSysFlags,@FileSysName, 255)
      then Result := ''
   else
      Result := StrPas(VolumeName);
end;

Function GetVolumeSerialNum(DriveLetter : String) : DWord;
var
   VolumeSerial :DWord;
   FileSysName : Array[0..255] of char;
   FileSysFlags: DWord;
   MaxCompLen  : DWord;
   VolumeName  : Array[0..255] of char;
Begin
   IF NOT GetVolumeInformation(@DriveLetter[1], @VolumeName, 255, @VolumeSerial, MaxCompLen, FileSysFlags,@FileSysName, 255)
      then Result := 0
   else
      Result := VolumeSerial;
end;

{Type
   TSystemTime = Record
      Year : Word;
      Month: Word;
      DOW  : Word;
      Day  : Word;
      Hour : Word;
      Min  : Word;
      Sec  : Word;
      MS   : Word;
   end;
 }

Function ConvertFileTime(ATime : TFileTime) : TDateTime;
VAR
   ST           : TSystemTime;
   FileTime     : TDateTime;
Begin
   Result := 0;
   IF NOT FileTimeToSystemTime(ATime, ST) then exit;

   FileTime := EncodeDate(ST.wYear, ST.wMonth, ST.wDay);
   FileTime := FileTime + EncodeTime(ST.wHour, ST.wMinute, ST.wSecond, ST.wMilliseconds);

   Result := FileTime;
end;


Function PostNetCheck(AZIP : String) : Char;
VAR
   I : Integer;
   CheckSum : Integer;
Begin
   CheckSum := 0;
   For I := 1 to Length(AZIP) do
      If AZIP[I] in ['0'..'9'] then
         CheckSum := CheckSum + Valu(AZIP[I]);

   If CheckSum Mod 10 = 0 then
      Result := '0'
   else
      Result := Char(10 - (CheckSum mod 10) + 48);

end;

Function YearOnly(ADate : TDateTime): Integer;
var
   Year, Month, Day : Word;
Begin
   DecodeDate(ADate, Year, Month, Day);
   Result := Year;
end;

Function StripSpaces(AString : String) : String;
var
   I : Integer;
Begin
   Result := '';
   For I := 1 to length(AString) do
      If AString[I] <> ' ' then Result := Result + AString[I];

end;
Function StripCRLF(AString : String) : String;
var
   I : Integer;
Begin
   Result := '';
   For I := 1 to length(AString) do
      If Not (AString[I] in [Chr(10), Chr(13)])  then Result := Result + AString[I];

end;

Function ComputeAge(DOB : TDateTime) : Integer;
var
   Days : Integer;
   DOBDay, DOBMonth, DOBYear : Word;
   NOWDay, NOWMonth, NOWYear : Word;
   Age  : Integer;
Begin
   Result := 0;
   IF DOB <= 0 then exit;
   Days := Round(Date - DOB);
   If Days < 0 then Exit;
   DecodeDate(DOB, DOBYear, DOBMonth, DOBDay);
   DecodeDate(Date, NOWYear, NOWMonth, NOWDay);
   Age := NowYear - DOBYear;
   If NOWMonth < DOBMonth then Dec(Age)
   else if NOWDay < DOBDay then Dec(Age);

   Result := Age;
end;

Function HasBogusChars(AString : String) : Boolean;
var
   I : Integer;
Begin
   Result := False;
   For I := 1 to Length(AString) do
      If Ord(AString[I]) > 126 then begin
         Result := True;
         Exit;
      end;
end;

Function    IsWin9X :Boolean;
var
  temp :tOSVERSIONINFO;

begin
     temp.dwOSVersionInfoSize := sizeof(tOSVERSIONINFO);
     GetVersionEx(temp);
     Result := (temp.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS);
end;

Function    IsWin95A :Boolean;
var
  temp :tOSVERSIONINFO;

begin
     temp.dwOSVersionInfoSize := sizeof(tOSVERSIONINFO);
     GetVersionEx(temp);
     Result := (temp.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS) and
               (temp.dwMajorVersion = 4) and
               (temp.dwMinorVersion = 0) and
               (temp.dwBuildNumber = 950);
end;

function    IsWin95B :Boolean;
var
  temp :tOSVERSIONINFO;

begin
     temp.dwOSVersionInfoSize := sizeof(tOSVERSIONINFO);
     GetVersionEx(temp);
     Result := (temp.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS) and
               (temp.dwMajorVersion = 4) and
               (temp.dwMinorVersion = 0) and
               (temp.dwBuildNumber <> 950);
end;

function    IsWin98FE :Boolean;
var
  temp :tOSVERSIONINFO;

begin
     temp.dwOSVersionInfoSize := sizeof(tOSVERSIONINFO);
     GetVersionEx(temp);
     Result := (temp.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS) and
               (temp.dwMajorVersion = 4) and
               (temp.dwMinorVersion = 10) and
               (temp.dwBuildNumber = 1998);
end;

function    IsWin98SE :Boolean;
var
  temp :tOSVERSIONINFO;

begin
     temp.dwOSVersionInfoSize := sizeof(tOSVERSIONINFO);
     GetVersionEx(temp);
     Result := (temp.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS) and
               (temp.dwMajorVersion = 4) and
               (temp.dwMinorVersion = 10) and
               (temp.dwBuildNumber <> 1998);
end;

function IsWinME :Boolean;
var
  temp :tOSVERSIONINFO;
begin
     temp.dwOSVersionInfoSize := sizeof(tOSVERSIONINFO);
     GetVersionEx(temp);
     Result := (temp.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS) and
               (temp.dwMajorVersion = 4) and
               (temp.dwMinorVersion = 90);
end;

Function    IsWinNT :Boolean; {whole platform}
var
  temp :tOSVERSIONINFO;

begin
     temp.dwOSVersionInfoSize := sizeof(tOSVERSIONINFO);
     GetVersionEx(temp);
     Result := (temp.dwPlatformId = VER_PLATFORM_WIN32_NT);
end;

Function    IsWinNT4 :Boolean;
var
  temp :tOSVERSIONINFO;

begin
     temp.dwOSVersionInfoSize := sizeof(tOSVERSIONINFO);
     GetVersionEx(temp);
     Result := (temp.dwPlatformId = VER_PLATFORM_WIN32_NT) and
               (temp.dwMajorVersion = 4) and
               (temp.dwMinorVersion = 0);
end;

Function    IsWin2K :Boolean;
var
  temp :tOSVERSIONINFO;

begin
     temp.dwOSVersionInfoSize := sizeof(tOSVERSIONINFO);
     GetVersionEx(temp);
     Result := (temp.dwPlatformId = VER_PLATFORM_WIN32_NT) and
               (temp.dwMajorVersion = 5) and
               (temp.dwMinorVersion = 0);
end;

Function    IsWinXP :Boolean;
var
  temp :tOSVERSIONINFO;

begin
     temp.dwOSVersionInfoSize := sizeof(tOSVERSIONINFO);
     GetVersionEx(temp);
     Result := (temp.dwPlatformId = VER_PLATFORM_WIN32_NT) and
               (temp.dwMajorVersion = 5) and
               (temp.dwMinorVersion = 1);
end;

function  WindowsVersion :string;
var
  temp :tOSVERSIONINFO;
  ResultStr :string;

begin
     temp.dwOSVersionInfoSize := sizeof(tOSVERSIONINFO);
     GetVersionEx(temp);
     if temp.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS then
       ResultStr := '95.'
     else
       ResultStr := '';
     ResultStr := ResultStr +
                  trim(STRI(temp.dwMajorVersion, -1)) + '.' +
                  trim(STRI(temp.dwMinorVersion, -1)) + '.' +
                  trim(STRI(temp.dwBuildNumber, -1));
     WindowsVersion := ResultStr;
end;

function PadIntVal(IntVal : Integer; Places : Integer) :String;
var
   Negative :Boolean;
begin
   Negative := IntVal < 0;
   IntVal := Abs(IntVal);
   Result := Stri(IntVal, -1);
   if Negative then Places := Places - 1;
   while Length(Result) < Places do
      Result := '0' + Result;
   if Negative then Result := '-' + Result;
end;

Function StripDollar(AStr : String) : String;
begin
   ReplaceString(AStr, '$', '');
end;

Procedure SaveDataSetToTabs(ADataSet : TDataSet; AFile : String);
var
   OutFile : TextFile;
   I       : integer;
Begin
   Assign(OutFile, AFile);
   ReWrite(OutFile);
   Adataset.First;
   While NOT ADataSet.EOF do begin
      For I := 0 to ADataSet.FieldCount - 1 do
         Write(OutFile, ADataSet.Fields[I].AsString, Chr(9));
      WriteLn(OutFile);
      ADataSet.Next;
   end;
   CloseFile(OutFile);
end;
Function DataSetRowToTabs(ADataSet : TDataSet) : String;
var
   I : Integer;
Begin
   Result := '';
   For I := 0 to ADataSet.FieldCount -1 do begin
      If not(ADataSet.Fields[i].DataType in [ftBlob,ftMemo,ftGraphic]) then
         Result := Result + Trim(ADataSet.Fields[I].AsString) + #9;
   end;
end;
Function DataSetRowToTabsWMemo(ADataSet : TDataSet) : String;
var
   I : Integer;
Begin
   Result := '';
   For I := 0 to ADataSet.FieldCount -1 do begin
      If not(ADataSet.Fields[i].DataType in [ftBlob,ftGraphic]) then
         Result := Result + Trim(ADataSet.Fields[I].AsString) + #9;
   end;
end;

Procedure CopyDataSetToStringList(ADataSet : TDataSet; ASL : TStringList);
var
   ALine : String;
Begin
   While NOT ADataSet.EOF do begin
      ASL.Add(DataSetRowToTabs(ADataSet));
      ADataSet.Next;
   end;
end;
Procedure CopyDataSetToStringListWMemo(ADataSet : TDataSet; ASL : TStringList);
var
   ALine : String;
Begin
   While NOT ADataSet.EOF do begin
      ASL.Add(DataSetRowToTabsWmemo(ADataSet));
      ADataSet.Next;
   end;
end;


Function  LoadToDataSet(AFile : String; ADS : TDataSet) : Integer;
Var
   ASL : TStringList;
   I : Integer;
   WS : String;
   CurrentField : Integer;
begin
   Result := 0;
   ASL := TStringList.Create;
   ASL.LoadFromFile(AFile);
   For I := 0 to ASL.Count -1 do begin
      ADS.Insert;
      WS := ASL[I];
      CurrentField := 0;
      While WS <> '' do begin
         Try
            ADS.Fields[CurrentField].AsString := ParseToChar(WS,#9);
         except
            On E:Exception do begin
            end;
         end;
         Inc(CurrentField);
      end;

      Try
         ADS.Post;
         Inc(Result);
      except
         On E:Exception do begin
         end;
      end;
   end;


   ASL.Free;
end;

Procedure SaveDataSetToTabsWHeader(ADataSet : TDataSet; AFile : String);
var
   OutFile : TextFile;
   I       : integer;
   RecCnt : Integer;
   X : integer;
Begin
   UtilityAbort := False;

   Assign(OutFile, AFile);
   ReWrite(OutFile);
   For I := 0 to ADataSet.FieldCount - 1 do
      Write(OutFile, ADataSet.Fields[I].FieldName+#9);
   WriteLn(OutFile);
   Adataset.First;
   RecCnt := AdataSet.RecordCount;
   X := 0;
   While NOT ADataSet.EOF do begin
      Inc(X);
      For I := 0 to ADataSet.FieldCount - 1 do
         Write(OutFile, ADataSet.Fields[I].AsString, #9);
      WriteLn(OutFile);
      ADataSet.Next;
      Application.ProcessMessages;
      If UtilityAbort then Break;
      If Assigned(UtilityPB) then UtilityPB.Position := Round(X/RecCnt*100);
   end;
   CloseFile(OutFile);
end;


Function BTRAField(ADataSet: TDataSet; AFieldName : String; Offset : Integer) : TField;
var
   OffStr : String;
Begin
   OffStr := Trim(Stri(Offset, -1));
   If Length(OffStr) = 1 then OffStr := '0' + OffStr;
   OffStr := '_A' + OffStr;
   Result := ADataSet.FieldByName(AFieldName + OffStr);
end;


procedure ConvertFieldToField(FromField : TField; ToField : TField);
begin
   if ((FromField.DataType in [ftFloat, ftInteger]) AND
       (ToField.DataType in [ftFloat, ftInteger])) then
      ToField.AsVariant := FromField.AsVariant
   else if ((FromField.DataType in [ftDateTime, ftDate, ftTime]) AND
            (ToField.DataType in [ftDateTime, ftDate, ftTime])) then
      ToField.AsDateTime := FromField.AsDateTime
   else
      ToField.AsString := FromField.AsString;

end;

function LeftStr(AString :String; Position :Integer) :String;
begin
     Result := Copy(AString, 1, Position);
end;

function RightStr(AString :String; Position :Integer) :String;
begin
     Result := Copy(AString, Length(AString) - Position + 1, Position);
end;

function MidStr(AString :String; Position :Integer; Length :Integer) :String;
begin
     Result := Copy(AString, Position, Length);
end;

function DateWindow(ADate : TDateTime) : TDateTime;
var
   Y,M,D : Word;
Begin
   DecodeDate(ADate, Y,M,D);
   Y := Y Mod 100;
   If Y < 20 then
      Y := Y + 2000
   else
      Y := Y + 1900;
   If (Y = 0) or (M = 0) or (D = 0) then
      Result := 0
   else
      Result := EncodeDate(Y,M,D) + Frac(ADate);
end;

function EANString(ACode : String) : String;
Begin
   ACode := Trim(NumericOnly(ACode));
   If Length(ACode) > 12 then Acode := Copy(ACode, 1, 12);
   While Length(ACode) < 12 do ACode := '0' + ACode;
   Result := ACode;
end;

function UPCString(ACode : String) : String;
var
   CSum : Integer;
   I    : Integer;
Begin
   ACode := Trim(NumericOnly(ACode));
   if Length(ACode) = 13 then begin {European EAN}
      SetLength(ACode, 12);
      Result := ACode;
      exit;
   end;

   If Length(ACode) > 11 then SetLength(ACode, 11);
   While Length(ACode) < 11 do ACode := '0' + ACode;

   CSum := 0; I := 1;
   while (I <= 11) do begin
      CSum := CSum + Valu(ACode[I]);
      I := I + 2;
   end;

   CSum:=CSum * 3; I := 2;
   while (i <= 10) do begin
      CSum := CSum + Valu(ACode[I]);
      I := I + 2;
   end;

   CSum := CSum mod 10; CSum := 10 - CSum;
   if CSum=10 then CSum:=0;
   Result := ACode + Stri(CSum, -1);
end;
//***********************************************
Function IsUPC(ABarCode : String): Boolean;
Begin
   Result := (Trim(ABarCode) = UPCString(ABarcode));
end;
//***********************************************
procedure NestedDelete(var S: string; Index, Count:Integer);
Begin
   Delete(S,Index, Count);
end;

Function ParseEMailRealName(FullAddress : String): String;
Begin
   Result := '';
   Result := ParseToChar(FullAddress, '<');
end;

Function ParseEMailAddress(FullAddress : String): String;
Begin
   Result := '';
   ParseToChar(FullAddress, '<');
   Result := ParseToChar(FullAddress, '>');
end;

Function DateAsString(AField : TField) : String;
Begin
   If AField.IsNull then begin
      Result := '';
      Exit;
   End;
   If AField.DataType in [ftDate] then begin
      Result := FormatDateTime('MM/DD/YYYY', DateWindow(AField.AsDateTime));
   end else
   If AField.DataType in [ftDateTime] then begin
      If Frac(AField.AsDateTime) = 0 then
         Result := FormatDateTime('MM/DD/YYYY', DateWindow(AField.AsDateTime))
      else
         Result := FormatDateTime('MM/DD/YYYY HH:MM:SS', DateWindow(AField.AsDateTime));
   end else begin
      Result := AField.AsString;
   end;

end;



Procedure TabStrToStringList(AString : String; ASL : TStringList);
Var
  WorkStr : String;
Begin
   While AString <> '' do begin
      WorkStr := ParsetoChar(AString, chr(9));
      ASL.Add(WorkStr);
   end;
end;
Function SecondsToDateTime(Secs : Integer) : TDateTime;
Var
   Days      : Integer;
   Hours     : Integer;
   Mins      : Integer;
   Seconds   : Integer;
Begin
   Days  := Secs Div 86400;
   Hours := (Secs Mod 86400) div 3660;
   Mins := (Secs Mod 3660) div 60;
   Seconds := (Secs Mod 60);
   Result := Days + EncodeTime(Hours, Mins, Seconds, 0);
end;

function BytesToHexString(var AValue; Length : Integer) : String;
{
  Pre: Technically, none. However, the digest is meaningless until Complete
       has been called on the instance, and thus this function will return
       a blank string unless it has been completed.
  Post: A string of 2 * FDigestSize bytes representing the hex value of the
        message digest. The left-most two characters of the resulting string
        represent the first byte of the message digest, and the right-most
        two characters of the resulting string represent the last byte of the
        message digest.
}
const
  DigitToHex: array [0..$0F] of Char = (
   '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
   'a', 'b', 'c', 'd', 'e', 'f'
  );
var
  I: Integer;
  PD: ^Byte;
  PR: ^Char;
begin
  SetLength(Result, 2 * Length);
  PD := @AValue;
  PR := Addr(Result[1]);
  for I := 1 to Length do begin
    PR^ := DigitToHex[PD^ shr 4];
    Inc(PR);
    PR^ := DigitToHex[PD^ and $0F];
    Inc(PR);
    Inc(PD);
  end;
  Result := UpCaseString(Result);
end;

Function CharToHex(AChar : Char) : String;
Begin
   result := BytesToHexString(AChar,1);
end;
Function HexStringToBytes(Instr : String): String;
var
   WS : String;
   HexWord : String;
   I : Integer;
Begin
   Result := '';
   For I := 0 to (Length(InStr) div 2) -1 do begin
      HexWord := Copy(InStr,I*2 + 1, 2);
      Result := Result + Chr(StrToInt('$' + HexWord));
   end;
End;

Procedure SetOddBitDESParity(VAR InByte : Byte);
var
   BitCount : Integer;
   I        : integer;
Begin
   BitCount := 0;
   For I := 0 to 6 do begin
      If InByte AND (128 Div  Trunc(power(2, I))) > 0 then
         Inc(BitCount);
   end;
   If BitCount Mod 2 = 0 then
      InByte := InByte or 1  //Set Flag if even
   else
      InByte := InByte and 254;
end;


Function  StrToUnicodeStr(AString : String) : String;
var
   I : Integer;
Begin
   Result := '';
   For I := 1 to length(AString) do 
      Result := Result + AString[I] + Chr(0);

end;


Function  CheckFileExclusive(AFileName : String): Boolean;
Var
  HFile    : Integer;
Begin
   Result := False;
   If Length(AFileName) = 0 then exit;

   AFileName := AFileName + Chr(0);
   HFile := CreateFile(@AFileName[1],  Generic_Read, 0, NIL, Open_Existing, 0,0);
   if HFile = HFILE_ERROR then
      Result := False
   else begin
      Result := True;
      try
         CloseHandle(HFile);
      except
         On E:Exception do begin
         end;
      end;
   end;
End;


type
  PComp = ^comp; //64bit real integer type.
  PInt  = ^integer; //32-bit integer;


function GetDiskFreeSpace(lpDirectoryName: PChar;  lpFreeBytesAvailableToCaller, lpTotalNumberOfBytes,
  lpTotalNumberOfFreeBytes: PInt) : BOOL; stdcall; external kernel32 name 'GetDiskFreeSpaceA';

function GetDiskFreeSpaceEx(lpDirectoryName: PChar;  lpFreeBytesAvailableToCaller, lpTotalNumberOfBytes,
  lpTotalNumberOfFreeBytes: PComp) : BOOL; stdcall; external kernel32 name 'GetDiskFreeSpaceExA';

function  DiskFreeEx(Path : String) : Comp;
var
  Available, TotalSize : comp;
  iAvailable, iTotalSize : integer;

begin
  if IsWin95A then
    begin
      if GetDiskFreeSpace(@Path[1],@iAvailable,@iTotalSize,nil) then
         Result := iAvailable
      else
         Result := 0;
    end
  else
    begin
      if GetDiskFreeSpaceEx(@Path[1],@Available,@TotalSize,nil) then
         Result := Available
      else
         Result := 0;
    end

end;

Function  DiskSize(Path : String) : Comp;
var
  Available, TotalSize : comp;
  iAvailable, iTotalSize : integer;

begin
  if IsWin95A then
    begin
      if GetDiskFreeSpaceEx(@Path[1],@iAvailable,@iTotalSize,nil) then
        Result := iTotalSize
      else
        Result := 0;
    end
  else
    begin
      if GetDiskFreeSpaceEx(@Path[1],@Available,@TotalSize,nil) then
        Result := TotalSize
      else
        Result := 0;
    end

end;

{************************************************************************
Returns the specified file size
*************************************************************************}
function FileByNameSize(FileName : String) :integer;
var
   DirInfo  : TSearchRec;
   Res :integer;
begin
   Res := FindFirst(FileName, faAnyFile, DirInfo);
   if Res = 0 then
     FileByNameSize := DirInfo.Size
   else
     FileByNameSize := -1;
   FindClose(DirInfo);
end;

Procedure AddTableToListBox(ADS : TDataSet; ALB : TCheckListBox);
VAR
  I : Integer;
Begin
   For I := 1 to 60 do begin   //Load all of the existing entries in
      If Trim(ADS.FieldByName('Description_A' + PadIntVal(I, 2)).AsString) <> '' then
      ALB.Items.Add(Trim(ADS.FieldByName('Description_A' + PadIntVal(I, 2)).AsString));
   end;

end;

Procedure AddTableToStringList(ADS : TDataSet; SL : TStrings);
VAR
  I : Integer;
Begin
   For I := 1 to 60 do begin   //Load all of the existing entries in
      If Trim(ADS.FieldByName('Description_A' + PadIntVal(I, 2)).AsString) <> '' then
      SL.Add(Trim(ADS.FieldByName('Description_A' + PadIntVal(I, 2)).AsString));
   end;
end;
Procedure AddTableSelectionToListBox(ADS : TDataSet; ALB : TCheckListBox);
VAR
  I : Integer;
  X : Integer;
Begin
   For I := 1 to 60 do begin   //Load all of the existing entries in
      If (Trim(ADS.FieldByName('Description_A' + PadIntVal(I, 2)).AsString) <> '') AND
         (ADS.FieldByName('Selected_A' + PadIntVal(I, 2)).AsBoolean) then begin
         X := ALB.Items.IndexOf(Trim(ADS.FieldByName('Description_A' + PadIntVal(I, 2)).AsString));
         If X >= 0 then ALB.Checked[X] := False;
      end;
      If (Trim(ADS.FieldByName('Description_A' + PadIntVal(I, 2)).AsString) <> '') AND
         (NOT ADS.FieldByName('Selected_A' + PadIntVal(I, 2)).AsBoolean) then begin
         X := ALB.Items.IndexOf(Trim(ADS.FieldByName('Description_A' + PadIntVal(I, 2)).AsString));
         If X >= 0 then ALB.Checked[X] := True;
      end;
   end;
end;
Procedure AddTableExclusionToListBox(ADS : TDataSet; ALB : TCheckListBox);
VAR
  I : Integer;
  X : Integer;
Begin
   For I := 1 to 60 do begin   //Load all of the existing entries in
      If (Trim(ADS.FieldByName('Description_A' + PadIntVal(I, 2)).AsString) <> '') AND
         (NOT ADS.FieldByName('Selected_A' + PadIntVal(I, 2)).AsBoolean) then begin
         X := ALB.Items.IndexOf(Trim(ADS.FieldByName('Description_A' + PadIntVal(I, 2)).AsString));
         If X >= 0 then ALB.Checked[X] := True;
      end;
   end;
end;


Function  FileEndsInCRLF(AFileName : String) : Boolean;
VAR
   InFile  : File of Byte;
   CR,LF   : Char;
Begin
   Result := False;
   {$I-}
   If NOT FileExists(AFileName) Then Exit;
   AssignFile(InFile, AFileName);
   Reset(InFile);
   If FileSize(InFile) = 0 then begin
      Result := True;
      CloseFile(InFile);
      Exit;
   end;
   If FileSize(InFile) < 2 then Exit;

   Seek(InFile, FileSize(InFile) - 2);
   Read(InFile, Byte(CR));
   Read(InFile, Byte(LF));
   If (CR = Chr(13)) and
      (LF = chr(10)) then
      Result := True;

   CloseFile(InFile);

end;

Function  TextBetween(AString : String; StartText : String; EndText : String) : String;
Var
  SPos : Integer;
  EPos : Integer;
Begin
   Result := '';
   SPos := Pos(StartText, AString);
   EPos := Pos(EndText, Copy(AString, SPos + Length(StartText), Length(AString))) + SPos + Length(StartText) - 1;
   SPos := SPos + Length(StartText);
   If Spos = 0 then exit;
   If EPos = 0 then begin
      EPos := Length(AString) + 1;
   end;
   Result := Copy(AString, SPOS, EPos - SPos );
end;

function EnumWndProc(h : THandle; lParam : integer) : boolean; stdcall;

// Checks to see if handle passed in is for a running copy of SPECTRUM
// If so, returns false, indicating to quit looking, and Enum API call is TRUE
const
   TaskNT   = 'SPECTRUM';
   Task95    = 'SPECTRUM - ';

   lengthNT = 9;
   length95 = 11;

var
   WndNameNT   : array[0..lengthNT] of char;
   WndName95   : array[0..length95] of char;

begin
   GetWindowText(h,@WndNameNT[0],lengthNT+1);
   GetWindowText(h,@WndName95[0],length95+1);
   if (WndNameNT <> TaskNT) and (Pos(Task95, WndName95) = 0) then
      result := true
   else
       begin
            result := false;
            SetForegroundWindow(h);
            SendMessage(h, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
       end;
end;

Function RightChars(AString : String;NumChars : INteger) : String;
Begin
   If length(AString) <= NumChars then begin
      Result := AString;
      Exit;
   end;
   Result := Copy(AString, Length(AString) - NumChars + 1, NumChars);

end;

function UpdateConfigVar(TextFile :TStringList; Variable :string; Value :string) :Boolean;
var i :integer;
    TempString1 :string;
    Found, Changed :Boolean;
begin
  Found := false;
  Changed := false;
  i := 0;
  while (i < TextFile.Count) and (not Found) do
    begin
      TempString1 := UpperCase(TextFile[i]);
      if Pos(Variable, TempString1) = 1 then
        begin
          Found := true;
          ParseToChar(TempString1,'=');
          if trim(TempString1) <> Variable then
            begin
              TextFile[i] := Variable + '=' + Value;
              Changed := true;
            end;
        end;
      i := i + 1;
    end;
  if not Found then
    begin
      TextFile.Add(Variable + '=' + Value);
      Changed := true;
    end;
  UpdateConfigVar := Changed;
end;

function UpdateConfigFile(FileName :string) :Boolean;
var
  ConfigFile :TStringList;
  Changed :Boolean;
begin
  ConfigFile := TStringList.Create;
  ConfigFile.Clear;
  ConfigFile.LoadFromFile(FileName);
  Changed := UpdateConfigVar(ConfigFile, 'FILES', '100');
  Changed := UpdateConfigVar(ConfigFile, 'BUFFERS', '40') or Changed;
  Changed := UpdateConfigVar(ConfigFile, 'FCBS', '32,32') or Changed;
  if IsWin9x then Changed := UpdateConfigVar(ConfigFile, 'DOS', 'HIGH') or Changed;
  if Changed then ConfigFile.SaveToFile(FileName);
  UpdateConfigFile := Changed;
end;

function UpdateConfigSysFiles :Boolean;
{Returns true if CONFIG.SYS or CONFIG.NT updated, false if OK}
begin
  if IsWinNT then
    UpdateConfigSysFiles := UpdateConfigFile(GetWindowsDir + 'SYSTEM32\CONFIG.NT')
  else
    UpdateConfigSysFiles := UpdateConfigFile('C:\CONFIG.SYS');
end;

function RandomString(NumChars :integer) :string;
var
  TempString :string;
  i :integer;
begin
  TempString := '';
  System.Randomize;
  for i := 1 to NumChars do
    begin
      TempString := TempString + Chr(65 + Random(26));
    end;
  RandomString := TempString;
end;

function RandomStringKey(NumChars :integer) :string;
var
  TempString :string;
  i :integer;
begin
  TempString := '';
  System.Randomize;
  for i := 1 to NumChars do
    begin
      TempString := TempString + Chr(33 + Random(89));
    end;
  Result := TempString;
end;

function GetAdapterName(UniqueID :string) :string;
var
  MyReg      : TRegistry;
  BaseKey, AdapterName    :string;
  i :integer;
  Interfaces :TStringList;

begin
     AdapterName := '';
     MyReg := TRegIniFile.Create('');
     MyReg.RootKey := HKEY_LOCAL_MACHINE;
     BaseKey := '\SYSTEM\CurrentControlSet\Control\Network\';
     if not MyReg.OpenKey(BaseKey,false) then exit;
     Interfaces := TStringList.Create;
     MyReg.GetKeyNames(Interfaces);
     i := 0;
     while (i < Interfaces.Count) and (AdapterName = '') do
       begin
         i := i + 1;
         MyReg.OpenKey(BaseKey + Interfaces.Strings[i-1], false);
         if (MyReg.ReadString('') = 'Network Adapters') and
            (MyReg.OpenKey(BaseKey + Interfaces.Strings[i-1] + '\' + UniqueID + '\Connection\', false)) then
           AdapterName := MyReg.ReadString('Name');
       end;
     GetAdapterName := AdapterName;
end;

procedure TurnOff8021x;
{Returns number of changes}
var
  MyReg      : TRegistry;
  Interfaces :TStringList;
  BaseKey    :string;
  i, TempVal :integer;
  ByteArray  :array[1..104] of byte;
begin
     MyReg := TRegIniFile.Create('');
     MyReg.RootKey := HKEY_LOCAL_MACHINE;
     BaseKey := '\SOFTWARE\Microsoft\EAPOL\Parameters\Interfaces\';
     if not MyReg.OpenKey(BaseKey,false) then Application.Terminate;
     Interfaces := TStringList.Create;
     MyReg.GetKeyNames(Interfaces);
     for i := 1 to Interfaces.Count do
       begin
         if not MyReg.OpenKey(BaseKey + Interfaces.Strings[i-1],false) then Application.Terminate;
         TempVal := MyReg.ReadBinaryData('1', ByteArray, 104);
         if TempVal <> 104 then Application.Terminate;
         if ByteArray[12] = 192 then
           begin
             ByteArray[12] := 64;
             MyReg.WriteBinaryData('1', ByteArray, 104);
           end;
       end;
end;

type
  TOsVersionInfoExA = packed record
    old : TOsVersionInfoA;
    wServicePackMajor : Word;
    wServicePackMinor : Word;
    wSuiteMask : Word;
    wProductType : Byte;
    wReserved  : Byte;
  end;
{wProductType
Indicates additional information about the system. This member can be one of
the following values. Value Meaning
VER_NT_WORKSTATION The system is running Windows NT 4.0 Workstation, Windows
2000 Professional, Windows XP Home Edition, or Windows XP Professional.
VER_NT_DOMAIN_CONTROLLER The system is a domain controller.
VER_NT_SERVER The system is a server.
}

const VER_NT_WORKSTATION = 1;
      VER_NT_DOMAIN_CONTROLLER = 2;
      VER_NT_SERVER = 3;
      VER_SUITE_DATACENTER = 128;
      VER_SUITE_ENTERPRISE = 2;
      VER_SUITE_PERSONAL = 512;

function IsHomeEdition : Boolean;
var
  VerInfo : TOsVersionInfoExA;
begin
  FillChar(VerInfo, sizeof(VerInfo), 0);
  VerInfo.old.dwOSVersionInfoSize := sizeof(VerInfo);
  if NOT GetVersionExA(VerInfo.old) then
    RaiseLastWin32Error();
  IsHomeEdition := VerInfo.wSuiteMask = VER_SUITE_PERSONAL;
end;

procedure StartVNC(IPAddress :string);
Var
  WorkStr : String;
begin
  WorkStr := 'c:\vncviewer.exe /8bit /quality 0 /compresslevel 9 ' + IPAddress + Chr(0);
  WinExec(@Workstr[1], sw_normal)
end;

procedure StartPCA(IPAddress :string);
Var
  WorkStr : String;
begin
      ChDir('C:\Documents and Settings\All Users\Application Data\Symantec\pcAnywhere\');
      WorkStr := 'C:\Program Files\Symantec\pcAnywhere\awrem32.exe template.chf /C' + IPAddress + Chr(0);
      WinExec(@Workstr[1], sw_normal)
end;

procedure StartXPTS(IPAddress, UserName :string);
Var
  WorkStr : String;
  i, j :integer;
  InFile, OutFile :textfile;
  TempChar, TempChar2 :char;
  TempString :string;
  TempStringList :TStringList;
begin
     if UserName = '' then UserName := 'Administrator';
     TempStringList := TStringList.Create;
     AssignFile(InFile, 'c:\template.rdp');
     reset(InFile);
     if not EOF(InFile) then Read(InFile, TempChar);
     if not EOF(InFile) then Read(InFile, TempChar);
     TempString := '';
     while not EOF(InFile) do
       begin
         read(InFile, TempChar);
         read(InFile, TempChar2);
         if (TempChar = #13) or (TempChar = #10) then
           begin
             TempStringList.Add(TempString);
             read(InFile, TempChar);
             read(InFile, TempChar2);
             TempString := '';
           end
         else
           TempString := TempString + TempChar;
       end;
     CloseFile(InFile);
     for i := 1 to TempStringList.Count do
       begin
         if Pos('full address:s:', TempStringList.Strings[i-1]) = 1 then
           TempStringList.Strings[i-1] := 'full address:s:' + IPAddress;
         if Pos('username:s:', TempStringList.Strings[i-1]) = 1 then
           TempStringList.Strings[i-1] := 'username:s:' + UserName;
       end;
     AssignFile(OutFile, 'c:\template.rdp');
     Rewrite(OutFile);
     write(OutFile, #255 + #254);
     for i := 1 to TempStringList.Count do
       begin
         TempString := '';
         for j := 1 to length(TempStringList.Strings[i-1]) do
           write(OutFile, (TempStringList.Strings[i-1])[j] + #0);
         write(OutFile, #13 + #0 + #10 + #0);
       end;
     CloseFile(OutFile);
     TempStringList.Destroy;
     WorkStr := 'mstsc.exe c:\template.rdp' + Chr(0); //C:\WINNT\System32\mstsc.exe
     Sleep(2000);
     WinExec(@Workstr[1], sw_normal)
end;

procedure StartTelnet(IPAddress :string);
Var
  WorkStr : String;
begin
      WorkStr := 'Telnet.exe ' + IPAddress + Chr(0);
      WinExec(@Workstr[1], sw_normal)
end;


Function StripParens(AStr : String) : String;
var
   Open : Integer;
   Close  : Integer;
Begin
   Open := POS('(', AStr);
   Close := POS(')', AStr);
   If Open > 0 then begin
      If Close = 0 then Close := Length(AStr);
      Delete(AStr, Open, Close - Open + 1);
   end;

   Result := AStr;

end;

Function StripAllParens(AStr : String) : String;
Begin
   While Pos('(', AStr) <> 0 do
      AStr := StripParens(AStr);
   Result := AStr;
end;

Function GetTimeZoneBias : Integer;
var
   TZoneInfo: TTimeZoneInformation;
begin
   GetTimeZoneInformation(TZoneInfo);
   Result := TZoneInfo.Bias;
end;

Function GetSQLQueryText(AVariable : String; ACheckList : TCheckListBox) : String;
var
  OutStr : String;
  I      : Integer;
Begin
   OutStr := '';
   For I := 0 to ACheckList.Items.Count-1 do begin
       If ACheckList.Checked[I] then
          OutStr := OutStr + ' (Trim(' +AVariable + ') = '''+ACheckList.Items[I]+''') OR';
   end;
   OutStr := StripTrailingOR(OutStr);

   If Trim(OutStr) = '' then OutStr := ' TRUE ';

   Result := OutStr;
End;

Function GetSQLQueryTextNoTrim(AVariable : String; ACheckList : TCheckListBox) : String;
var
  OutStr : String;
  I      : Integer;
  Itemstr : String;
Begin
   OutStr := '';
   For I := 0 to ACheckList.Items.Count-1 do begin
       If ACheckList.Checked[I] then begin
          ItemStr := ACheckList.Items[I];
          If Trim(Itemstr) = '' then
             OutStr := OutStr + ' (' +AVariable + ') = NULL OR'
          else
             OutStr := OutStr + ' (' +AVariable + ') = '''+ItemStr+''' OR';

       end;
   end;
   OutStr := StripTrailingOR(OutStr);

   If Trim(OutStr) = '' then OutStr := ' TRUE ';

   Result := OutStr;
End;


Procedure AddDataSetFieldToListBox(ADS : TDataSet; AFieldName : String; ALB : TCheckListBox);
Begin
   ADS.First;
   While NOT ADS.EOF do begin
      ALB.Items.Add(Trim(ADS.FieldByName(AFieldName).AsString));
      ADS.next;
   end;
end;

Function CheckListSelCount(ACheckList : TCheckListBox) : Integer;
var
  I      : Integer;
Begin
   Result := 0;
   For I := 0 to ACheckList.Items.Count-1 do begin
       If ACheckList.Checked[I] then
          Result := Result + 1;
   end;
End;

Procedure CheckListBoxClearSelection(ALB : TCheckListBox);
var
   I : Integer;
Begin
   For I := 0 to ALB.Items.Count -1 do
      ALB.State[I] := cbUnchecked;
end;

Procedure AddFieldsToGrid(FieldList : String; AGrid :TDBGrid);
var
  Col : TColumn;
  ColList : TStringList;
  WS      : String;
  FieldName :String;
  Caption   :String;
  Width     :String;
  Flags     :String;
  I         : Integer;
begin
   ColList := TStringList.Create;
   ColList.CommaText := FieldList;
   For I := 0 to ColList.Count -1 do begin
      WS := Trim(ColList[I]);
      If WS <> '' then begin
         FieldName := ParseToChar(WS, '|');
         Caption := ParseToChar(WS, '|');
         Width := ParseToChar(WS, '|');
         Flags := Trim(UpperCase(ParseToChar(WS, '|')));
         Col := AGrid.Columns.Add;
         Col.FieldName := FieldName;
         Col.Width := Valu(Width);
         Col.Title.Caption := Caption;

      end;
   end;
   ColList.Free;
end;

Function GetWinComputerName : String;
var temp: array[0.. MAX_COMPUTERNAME_LENGTH + 1] of char;
    a:DWord;

begin
a:= MAX_COMPUTERNAME_LENGTH + 1;
GetComputerName(@temp[0],a);
Result := StrPas(@Temp[0]);
end;

procedure RemoveDirAndContents(Dir :string);
begin
  Dir := RemoveBackSlash(Dir);
  DeleteFiles(Dir+'\*.*');
  RemoveDir(Dir);
end;

Function StopSystemService(EventHandler : TEventLogEvent; ServiceName : String; ServiceDescription : String) : Boolean;
var
   SvcMgr    : SC_HANDLE;
   SvcHandle : SC_HANDLE;
   TempString, TempPath :string;
   BytesNeeded: DWORD;
   ServicesReturned: DWORD;
   ResumeHandle      : DWORD;
   SvcStatus         : TServiceStatus;
   NameBuffer        : Array[1..255] of char;
   ServiceArray      : Array[1..200] of TEnumServiceStatus;
   BufSize           : DWORD;
   Status            : Boolean;
   ArgPointers       : PChar;
   TryCount          : Integer;
begin
   Result := False;
   Try
      SvcMgr := OpenSCManager('', 'ServicesActive', SC_MANAGER_ALL_ACCESS);
      if SvcMgr > 0 then begin
         EnumServicesStatus(SvcMgr, 272, SERVICE_STATE_ALL,
         ServiceArray[1], SizeOf(ServiceArray), BytesNeeded, ServicesReturned,ResumeHandle);

         BufSize := SizeOf(NameBuffer);
         GetServiceKeyName(SvcMgr,@ServiceDescription[1], @NameBuffer[1], BufSize);
         SvcHandle := OpenService(SvcMgr, @ServiceName[1], SERVICE_ALL_ACCESS);
         if SvcHandle > 0 then begin
            ArgPointers := NIL;
            EventHandler(ltInfo, 'Issuing Service Stop Request', '');
            Status := ControlService(SvcHandle, SERVICE_CONTROL_STOP, SvcStatus);
            If NOT Status then Begin
               EventHandler(ltWarning, 'Error Stopping '+ServiceDescription, ControlServiceErrorText(GetLastError))
            end;
            QueryServiceStatus(SvcHandle, SvcStatus);
            TryCount := 0;
            Status := True;
            If Status then Repeat
               inc(TryCount);
               Status := QueryServiceStatus(SvcHandle, SvcStatus);
               If SvcStatus.dwCurrentState <> SERVICE_STOPPED then begin
                  Sleep(1000);
                  EventHandler(ltInfo, 'Waiting for '+ServiceDescription+' to Stop', 'Service Status = '+ ServiceStateText(SvcStatus.dwCurrentState));
               end else begin
                  Status := False;
               end;
            Until (NOT Status) or (TryCount > 30);
            If TryCount > 30 then
               EventHandler(ltWarning, 'Timeout Waiting for Card Service to Stop', 'Service Status = '+ ServiceStateText(SvcStatus.dwCurrentState));

            If SvcStatus.dwCurrentState = SERVICE_STOPPED then begin
               EventHandler(ltInfo, 'Service Confirmed Stopped', '');
               Result := true;
            end;


            CloseServiceHandle(SvcHandle);
         end else begin
            EventHandler(ltWarning, ServiceDescription + ' Service Error', 'Couldn''t open Service Handle');
         end;
         CloseServiceHandle(SvcHandle);
      end else begin
         EventHandler(ltWarning, ServiceDescription + ' Service Error', 'Couldn''t open Service Control Manager');
      end;
      CloseServiceHandle(SvcMgr);
   Except
      On E:Exception do begin
         EventHandler(ltWarning, ServiceDescription +' Exception', E.Message);
      end;
   end;
end;

Function StartSystemService(EventHandler : TEventLogEvent; ServiceName : String; ServiceDescription : String) : Boolean;
var
   SvcMgr    : SC_HANDLE;
   SvcHandle : SC_HANDLE;
   TempString, TempPath :string;
   BytesNeeded: DWORD;
   ServicesReturned: DWORD;
   ResumeHandle      : DWORD;
   SvcStatus         : TServiceStatus;
   NameBuffer        : Array[1..255] of char;
   ServiceArray      : Array[1..200] of TEnumServiceStatus;
   BufSize           : DWORD;
   Status            : Boolean;
   ArgPointers       : PChar;
   TryCount          : Integer;
begin
   Result := False;
   Try
      SvcMgr := OpenSCManager('', 'ServicesActive', SC_MANAGER_ALL_ACCESS);
      if SvcMgr > 0 then begin
         EnumServicesStatus(SvcMgr, 272, SERVICE_STATE_ALL,
         ServiceArray[1], SizeOf(ServiceArray), BytesNeeded, ServicesReturned,ResumeHandle);

         BufSize := SizeOf(NameBuffer);
         GetServiceKeyName(SvcMgr,@ServiceDescription[1], @NameBuffer[1], BufSize);
         SvcHandle := OpenService(SvcMgr, @ServiceName[1], SERVICE_ALL_ACCESS);
         if SvcHandle > 0 then begin
            ArgPointers := NIL;
            EventHandler(ltInfo, 'Issuing Service Start Request', '');
            Status := StartService(SvcHandle,0,ArgPointers);  //Only issues start command to the service
            If NOT Status then Begin
               EventHandler(ltWarning, 'Error Starting '+ServiceDescription, ControlServiceErrorText(GetLastError))
            end;
            QueryServiceStatus(SvcHandle, SvcStatus);
            TryCount := 0;
            If Status then Repeat  //Now we'll see if it actually started
               inc(TryCount);
               Status := QueryServiceStatus(SvcHandle, SvcStatus);
               If SvcStatus.dwCurrentState <> SERVICE_RUNNING then begin
                  Sleep(1000);
                  EventHandler(ltInfo, 'Waiting for Service to Start', 'Service Status = '+ ServiceStateText(SvcStatus.dwCurrentState));
               end else begin
                  Status := False;
               end;
            Until (NOT Status) or (TryCount > 20);
            If TryCount > 20 then
               EventHandler(ltWarning, 'Timeout Waiting for Card Service to Start', 'Service Status = '+ ServiceStateText(SvcStatus.dwCurrentState))
            else If SvcStatus.dwCurrentState <> SERVICE_RUNNING then
               EventHandler(ltWarning, 'The service could not be started.', 'Service Status = '+ ServiceStateText(SvcStatus.dwCurrentState))
            else begin
               EventHandler(ltInfo, 'Service Confirmed started', '');
               Result := True;
            end;

            CloseServiceHandle(SvcHandle);
         end else begin
            EventHandler(ltWarning, ServiceDescription + ' Service Error', 'Couldn''t open Service Handle');
         end;
         CloseServiceHandle(SvcHandle);
      end else begin
         EventHandler(ltWarning, ServiceDescription + ' Service Error', 'Couldn''t open Service Control Manager');
      end;
      CloseServiceHandle(SvcMgr);
   Except
      On E:Exception do begin
         EventHandler(ltWarning, ServiceDescription +' Exception', E.Message);
      end;
   end;

end;
Function ServiceStateText(State :DWord): String;
Begin
   Case State of
      SERVICE_STOPPED : Result := 'Stopped';
      SERVICE_START_PENDING : Result := 'Starting';
      SERVICE_STOP_PENDING: Result := 'Stopping';
      SERVICE_RUNNING: Result := 'Running';
      SERVICE_CONTINUE_PENDING : Result := 'Continue is pending';
      SERVICE_PAUSE_PENDING : Result := 'Pause is pending';
      SERVICE_PAUSED: Result := 'Paused';
   else
      Result := 'Unknown';
   end; {Case}
end;
Function ControlServiceErrorText(LastError : DWord ) : String;
Begin
   If LastError = ERROR_SERVICE_NOT_ACTIVE then
      Result :=  'Service Not Active'
   else If LastError = ERROR_ACCESS_DENIED then
      Result :=  'Access Denied'
   else If LastError = ERROR_DEPENDENT_SERVICES_RUNNING then
      Result :=  'Dependent Services Running'
   else If LastError = ERROR_INVALID_SERVICE_CONTROL then
      Result :=  'The requested control code is not valid, or it is unacceptable to the service'
   else If LastError = ERROR_SERVICE_CANNOT_ACCEPT_CTRL then
      Result :=  'Cannot Accept, service is SERVICE_STOPPED, SERVICE_START_PENDING, or SERVICE_STOP_PENDING.'
   else If LastError = ERROR_SERVICE_REQUEST_TIMEOUT then
      Result :=  'Timeout: The service did not respond in a timely fashon'
   else If LastError = ERROR_INVALID_HANDLE then
      Result :=  'Invalid Handle'
   else If LastError = ERROR_PATH_NOT_FOUND then
      Result :=  'Service Binary file could not be found'
   else If LastError = ERROR_SERVICE_ALREADY_RUNNING then
      Result :=  'Service Already Running'
   else If LastError = ERROR_SERVICE_DATABASE_LOCKED then
      Result :=  'Service Database Locked'
   else If LastError = ERROR_SERVICE_DEPENDENCY_DELETED then
      Result :=  'Dependency Deleted'
   else If LastError = ERROR_SERVICE_DEPENDENCY_FAIL then
      Result :=  'Dependency Failed to Start'
   else If LastError = ERROR_SERVICE_DISABLED then
      Result :=  'Service has been disabled'
   else If LastError = ERROR_SERVICE_LOGON_FAILED then
      Result :=  'Service Logon Failed'
   else If LastError = ERROR_SERVICE_MARKED_FOR_DELETE then
      Result :=  'Service has been marked for deletion'
   else If LastError = ERROR_SERVICE_NO_THREAD then
      Result :=  'Could not create thread for Win32 Service'
   else If LastError = ERROR_SERVICE_DEPENDENCY_DELETED then
      Result :=  'Dependency Deleted'
   else
      Result :=  'Unknown status = ' + Stri(LastError, -1);

end;
Procedure FloatFieldToCurrencyDisplayDS(ADS : TDataSet; Format : String);
Var
   I : Integer;
   AField : TFloatField;
begin
   For I := 0 to ADS.FieldCount - 1 do begin
      if ADS.Fields[I] is TFloatField then begin
         AField := TFloatField(ADS.Fields[I]);
         AField.DisplayFormat := Format;
      end;
   end;
end;
Procedure TrimStringsDS(ADS : TDataSet);
Var
   I : Integer;
   AField : TField;
begin
   For I := 0 to ADS.FieldCount - 1 do begin
      if ADS.Fields[I] is TStringField then begin
         AField := TStringField(ADS.Fields[I]);
         AField.AsString := Trim(AField.AsString);
      end;
   end;
end;

Procedure UpdateFloatDisplayOnForm(AFrm : TComponent; Find : String; Replace : String);
Var
   I : Integer;
   AField : TFloatField;
   NewExpr : String;
begin
   For I := 0 to AFrm.ComponentCount - 1 do begin
      if AFrm.Components[I] is TFloatField then begin
         AField := TFloatField(AFrm.Components[I]);
         NewExpr := AField.DisplayFormat;
         ReplaceString(NewExpr,Find, Replace);
         AField.DisplayFormat := NewExpr;
      end;
   end;
end;

Function StripHighAscii(InStr : String) : String;
Var
   I : integer;
Begin
   Result := '';
   For I := 1 to length(InStr) do
      If Ord(InStr[I]) <= 127 then
         Result := Result + InStr[I];
end;

//Returns the pointer to the field if it exists in the dataset.
//First searches for the fieldname,
//then searches for tablename.fieldname, ignoring tablename
//this is to accomodate some query joins
Function QueryFindField(ADS : TDataSet; FieldName : String) : TField;
var
   I : integer;
   FF : TField;
   FN : String;
Begin
   Result := Nil;
   FF := ADS.FindField(FieldName);
   If FF <> NIL then begin
      Result := FF;
      exit;
   end;
   FieldName := UpCaseString(FieldName);
   For I := 0 to ADS.FieldCount -1 do begin
      FN := Trim(UpCaseString(ADS.Fields[I].FieldName));
      If Pos('.', FN) <> 0 then begin  //It's a join fieldname if it has a . in it
         ParseToChar(FN,'.');
         If FN = FieldName then begin
            Result := ADS.Fields[I];
            exit;
         end;
      end;
   end;
end;
function CtrlDown : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[vk_Control] And 128) <> 0) ;
end;

function ShiftDown : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[vk_Shift] and 128) <> 0) ;
end;

function AltDown : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[vk_Menu] and 128) <> 0) ;
end;

   //*************************************************
   Function GetCardNumFromSwipe(Swipe : String) : String;
   Var
      CardNum : String;
      SwipeData : String;
   Begin
      Swipe := Trim(Swipe);
      SwipeData := Swipe;
      CardNum := '';
      //%B8010033710059869087^RETAILNET/TEST ACCOUNT^121246329601?
      If POS('%B', Swipe) = 1 then begin
         If Length(Swipe) > 21 then
            CardNum := Copy(Swipe,3,19);
      end else begin
         CardNum := Swipe;
      end;
      If NOT IsValidCardNum(CardNum) then
         CardNum := '';
      Result := CardNum;
   end;

//Creates the check digit.  Do not pass char w/ check digit
Function ComputeCardCheckDigit(AStr : String) : String;
var
   I : Integer;
   Cnt : Integer;
   ChkTotal : Integer;
   Mult : Integer;
   CD   : Integer;
Begin
   AStr := Trim(NumericOnly(Astr));
   Cnt := 0;
   ChkTotal := 0;
   For I := Length(AStr) Downto 1 do begin
      If (Cnt mod 2) = 0 then begin
         Mult := Valu(AStr[I]) * 2;
         ChkTotal := ChkTotal + Mult Div 10;
         ChkTotal := ChkTotal + Mult Mod 10;
      end else begin
         ChkTotal := ChkTotal + Valu(AStr[I]);
      end;
      Inc(Cnt);
   end;
   CD := ChkTotal Mod 10;
   If CD <> 0 then begin
      CD := 10 - CD;
   end;

   Result := Stri(CD, -1);
end;

//True if the card num and check digit match
Function IsValidCardNum(AStr : String) : Boolean;
Var
   Card : String;
   Check : String;
Begin
   AStr := Trim(NumericOnly(AStr));
   Result := False;
   If Length(Astr) = 0 then exit;
   Check := AStr[Length(AStr)];
   Card := Copy(Astr, 1, Length(Astr) -1);
   Result := Check = ComputeCardCheckDigit(Card);
end;

//Used to print bitmaps to a printer when they aren't a device independent BM so that
//the printer driver doesn't reject them
procedure PrintBitmap( R: TRect; BM: TBitmap );
var
  BitmapHeader: pBitmapInfo;
  BitmapImage: Pointer;
  HeaderSize,  ImageSize:  DWord;
begin
  GetDIBSizes( BM.Handle, HeaderSize, ImageSize );
  GetMem( BitmapHeader, HeaderSize );
  try
    GetMem( BitmapImage, ImageSize );
    try
      GetDIB( BM.Handle, BM.Palette, BitmapHeader^, BitmapImage^ );
      StretchDIBits( Printer.Canvas.Handle,
                     R.Left, R.Top,           // Destination Origin
                     R.Right - R.Left,        // Destination Width
                     R.Bottom - R.Top,        // Destination Height
                     0, 0,                    // Source Origin
                     BM.Width, BM.Height,     // Source Width & Height
                     BitmapImage,
                     TBitmapInfo( BitmapHeader^ ),
                     DIB_RGB_COLORS,
                     srcCopy )
    finally
      FreeMem( BitmapImage, ImageSize );
    end;
  finally
    FreeMem( BitmapHeader, HeaderSize );
  end;
end;


Function IsValidDate(ADateStr : String) : Boolean;
Begin
   IsValidDate := False;
   Try
      If StrToDate(ADateStr) > 0 then
         ISValidDate := True;
   Except
      On E:Exception do begin
      end;
   end;
end;
Function GetEnvVar(AVar : String) :String;
var
   ResBuffer : Array[1..255] of char;
Begin
   FillChar(ResBuffer, 255, 0);
   Result := '';
   If Length(AVar) = 0 then exit;
   GetEnvironmentVariable(@AVar[1], @ResBuffer, 255);
   Result := StrPas(@ResBuffer[1]);
end;

Function ArrayParamStr(I : Integer) : String;
Var
   S : String;
Begin
   S := Stri(I, -1);
   If Length(S) = 1 then S := '0' + S;
   Result := '_A' + s;
end;

Function UpTimeStr(UpTime : TDateTime) : String;
var
  Days : Integer;
Begin
  Days := Trunc(NOW - UPTIME);
  Result := Stri(Days,-1) + ' Days, ' + FormatDateTime('HH:NN:SS', Frac(Now - UpTime));

end;
{*************************************************************************}
Function LoadFileToStr(FromFile : String) :String;
VAR
   InFile  : File;
   I       : LongInt;
   ExtraSize : Integer;
   Buffer  : Array[1..1000] of Byte;
Begin

   {$I-}
   Result := '';
   If NOT FileExists(FromFile) Then Exit;
   AssignFile(InFile, FromFile);
   Reset(InFile, 1);
   For I := 1 to FileSize(InFile) div 1000 do begin
      BlockRead(InFile, Buffer, 1000);
      SetLength(Result, Length(Result) + 1000);
      Move(Buffer[1], Result[Length(Result) - 1000 + 1], 1000);
   end;

   ExtraSize := (FileSize(InFile) - (FileSize(InFile) div 1000) * 1000);
   BlockRead(InFile, Buffer, ExtraSize);
   SetLength(Result, Length(Result) + ExtraSize);
   Move(Buffer[1], Result[Length(Result) - ExtraSize + 1], ExtraSize);

   CloseFile(InFile);

end;
{*************************************************************************}
Procedure SaveStringAsFile(FN : String; SaveString : String);
VAR
   AppFile : TextFile;
Begin
   AssignFile(AppFile, FN);
   Rewrite(AppFile);
   Write(AppFile, SaveString);
   CloseFile(AppFile);
end;
{*************************************************************************}
Procedure FTPRemoteToAddrPort(RemoteData :String; var RemoteAddr : String; var RemotePort :Word);
var
   WS : String;
   Port1 : String;
   Port2 : String;
Begin
   RemoteAddr := '';
   RemotePort := 0;
   RemoteAddr := ParseToChar(RemoteData, ',') + '.';
   RemoteAddr := RemoteAddr + ParseToChar(RemoteData, ',') + '.';
   RemoteAddr := RemoteAddr + ParseToChar(RemoteData, ',') + '.';
   RemoteAddr := RemoteAddr + ParseToChar(RemoteData, ',');

   Port1 := ParseToChar(RemoteData, ',');
   Port2 := ParseToChar(RemoteData, ',');
   RemotePort := (Valu(Port1) * 256) + Valu(Port2);
end;

Function GetNXMLTag(XMLData : String; Tag : String; TagNum : integer) : String;
Var
   CompleteTag : String;
   FoundPos : Integer;
   EndPos : Integer;
   EndTag : String;
   NestLevel : Integer;
Begin
   Result := '';
   CompleteTag := '<'+Tag+'>';
   EndTag := '</' + Tag + '>';

   FoundPos := PosN(CompleteTag, XMLData,TagNum);
   If FoundPos > 0 then Begin
      XMLData := Copy(XMLData, FoundPos + Length(CompleteTag), Length(XMLData) - Length(CompleteTag) - FoundPos + 1);
      EndPos := Pos(EndTag, XMLData);
      NestLevel := 1;
      While (POSN(CompleteTag, Copy(XMLData,1,EndPos), NestLevel) > 0) do begin
         EndPos := PosN(EndTag, XMLData, NestLevel +1);
         Inc(NestLevel);
      end;
      If EndPos > 0 then begin
         Result := Copy(XMLData,1,EndPos -1);
         Exit;
      end
   end;
end;

Function XMLtoDS(XMLData : String;DS : TDataSet;  RowTag : String) : Integer;
var
   I : Integer;
   Rowstr : String;
   X : Integer;
   RowData : TStringList;
   FN : String;
   FD : String;
   WS : String;
   AF : TField;
Begin
   I := 1;
   RowData := TStringList.Create;

   RowStr := GetNXMLTagStr(XMLData,RowTag,I);
   While RowStr <> '' do begin
      inc(I);
      Try
         DS.Insert;
         RowData.Text := RowStr;
         For X := 0 to RowData.Count -1 do begin
            WS := RowData[X];
            ParseToChar(WS,'<');
            FN := ParseToChar(WS,'>');
            FD := ParseToChar(WS,'<');
            AF := DS.FindField(FN);
            If AF <> NIL then
              AF.AsString := FD;

         end;

         {
         For X := 0 to DS.FieldCount -1 do begin
            Try
               DS.Fields[X].AsString := GetXMLTagStr(RowStr,UpCaseString(DS.Fields[X].FieldName));
            Except
               On E:Exception do begin
                  //exception on asstring assign, ignore
               end;
            end;
         end;}
         DS.Post;
      Except
         On E:Exception do begin
         end;
      end;
      RowStr := GetNXMLTagStr(XMLData,RowTag,I);
   end;

   RowData.free;
   DS.First;
   Result := I - 1;
end;


Function GetXMLTag(XMLData : TStrings; Tag : String) : String;
Begin
   Result := GetNXMLTag(XMLData.Text,Tag,1);

end;

Function GetXMLTagStr(XMLData : String; Tag : String) : String;
Begin
   Result := GetNXMLTag(XMLData,Tag,1);
end;

Function GetNXMLTagStr(XMLData : String; Tag : String; TagNum : Integer) : String;
Begin
   Result := GetNXMLTag(XMLData,Tag,TagNum);
end;

Function PosN(SubStr : String; FindStr : String; Nth : Integer) : Integer;
Var
   I : Integer;
   OffsetIndex : Integer;
   FoundPos : Integer;
Begin
   Result := 0;
   OffsetIndex := 0;
   For I := 1 to nth do begin
      FoundPos := Pos(SubStr, FindStr);
      If (FoundPos > 0) and (I = Nth) then begin
         Result := FoundPOS + OffsetIndex;
         Exit;
      end;
      If FoundPos = 0 then Exit;
      Delete(FindStr,1,FoundPos + Length(SubStr) -1);
      OffsetIndex := OffsetIndex + FoundPos + Length(SubStr) -1
   end;
end;

Function MoneyFormat : String;
Begin
   Result := '$#,##0.00';
end;
Function MoneyDecimal : String;
Begin
   Result := '#,##0.00';
end;


function GetLocalhostIP(var HostName, IPaddr, WSAErr: string): Boolean;
type
  Name = array[0..100] of Char;
  PName = ^Name;
var
  HEnt: pHostEnt;
  HName: PName;
  WSAData: TWSAData;
  i: Integer;
begin
  Result := False;
  IPaddr := '';
  if WSAStartup($0101, WSAData) <> 0 then begin
    WSAErr := 'Winsock is not responding."';
    Exit;
  end;
  New(HName);
  if GetHostName(HName^, SizeOf(Name)) = 0 then
  begin
    HostName := StrPas(HName^);
    HEnt := GetHostByName(HName^);
    for i := 0 to HEnt^.h_length - 1 do
     IPaddr :=
      Concat(IPaddr,
      IntToStr(Ord(HEnt^.h_addr_list^[i])) + '.'); 
    SetLength(IPaddr, Length(IPaddr) - 1);
    Result := True;
  end
  else begin 
   case WSAGetLastError of
    WSANOTINITIALISED:WSAErr:='WSANotInitialised'; 
    WSAENETDOWN      :WSAErr:='WSAENetDown';
    WSAEINPROGRESS   :WSAErr:='WSAEInProgress'; 
   end; 
  end;
  Dispose(HName); 
  WSACleanup;
end;

function GetIPOfHost(var HostName, IPaddr, WSAErr: string): Boolean;
type
  Name = array[0..100] of Char;
  PName = ^Name;
var
  HEnt: pHostEnt;
  WSAData: TWSAData;
  i: Integer;
begin
  Result := False;
  IPaddr := '';

  if WSAStartup($0101, WSAData) <> 0 then begin
    WSAErr := 'Winsock is not responding."';
    Exit;
  end;
  FillChar(WSAData, SizeOf(WSAData), #0);
  If HostName <> '' then begin
    HEnt := GetHostByName(@HostName[1]);
    If HEnt <> NIL then begin
       for i := 0 to HEnt^.h_length - 1 do
        IPaddr := Concat(IPaddr,IntToStr(Ord(HEnt^.h_addr_list^[i])) + '.');
       SetLength(IPaddr, Length(IPaddr) - 1);
    end else begin
       result := False;
       WSAErr := 'Could Not Find Host ' + HostName;
       exit;
    end;

    Result := True;
  end
  else begin
   case WSAGetLastError of
    WSANOTINITIALISED:WSAErr:='WSANotInitialised';
    WSAENETDOWN      :WSAErr:='WSAENetDown';
    WSAEINPROGRESS   :WSAErr:='WSAEInProgress';
   end;
  end;

  WSACleanup;
end;

Function GetSubnetBroadcastAddress(LocalIP : String) : String;
Begin
   Result := '';
   If LocalIP = '' then exit;
   Result := ParseToChar(LocalIP, '.') + '.' + ParseToChar(LocalIP, '.') + '.' + ParseToChar(LocalIP, '.') + '.255';
end;

Procedure SaveGridToFile(AGrid : TDBGrid; FN : String; PB : TProgressBar);
Var
   I : Integer;
   DS : TDataSet;
   AStr : String;
   OutFile : TextFile;
   SaveFileDialog : TSaveDialog;
   Cnt : Integer;
Begin
   Cnt := 0;
   SaveFileDialog := TSaveDialog.Create(Nil);
   SaveFileDialog.DefaultExt := '.TXT';


   SaveFileDialog.FileName := FN;
   If NOT SaveFileDialog.Execute then begin
      SaveFileDialog.free;
      exit;
   end;


   Try
      AssignFile(OutFile, SaveFileDialog.FileName);
      ReWrite(OutFile);
   Except
      On E:Exception do begin
         MessageDlg(E.Message, mtInformation, [mbOk], 0);
         Exit;
      end;
   end;

Try
   DS := AGrid.DataSource.DataSet;
   DS.DisableControls;
   If GlobalCopyGridFieldNames then begin
      AStr := '';
      For I := 0 to AGrid.Columns.Count - 1 do begin
         AStr := AStr + AGrid.Columns[I].FieldName + Chr(9);
      End;
      Writeln(OutFile, AStr);
   end;

   Screen.Cursor := crHourGlass;
   DS.First;
   While NOT DS.EOF do begin
      inc(Cnt);
      AStr := '';
      For I := 0 to AGrid.Columns.Count - 1 do begin
         AStr := AStr + DS.FieldByName(AGrid.Columns[I].FieldName).AsString + Chr(9);
      End;
      Writeln(OutFile, AStr);
      DS.Next;
      Application.ProcessMessages;
      If Assigned(PB) then
         PB.Position := Cnt Mod 100;
   end;
   Screen.Cursor := crDefault;
Finally
   DS.First;
   DS.EnableControls;
   CloseFile(OutFile);
end;
end;
//****************************************************************
function ForceForegroundWindow(hwnd: THandle): Boolean;
const
  SPI_GETFOREGROUNDLOCKTIMEOUT = $2000;
  SPI_SETFOREGROUNDLOCKTIMEOUT = $2001;
var
  ForegroundThreadID: DWORD;
  ThisThreadID: DWORD;
  timeout: DWORD;
begin
  if IsIconic(hwnd) then ShowWindow(hwnd, SW_RESTORE);

  if GetForegroundWindow = hwnd then Result := True
  else
  begin
    // Windows 98/2000 doesn't want to foreground a window when some other
    // window has keyboard focus

    if ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion > 4)) or
      ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
      ((Win32MajorVersion > 4) or ((Win32MajorVersion = 4) and
      (Win32MinorVersion > 0)))) then
    begin
      // Code from Karl E. Peterson, www.mvps.org/vb/sample.htm
      // Converted to Delphi by Ray Lischner
      // Published in The Delphi Magazine 55, page 16

      Result := False;
      ForegroundThreadID := GetWindowThreadProcessID(GetForegroundWindow, nil);
      ThisThreadID := GetWindowThreadPRocessId(hwnd, nil);
      if AttachThreadInput(ThisThreadID, ForegroundThreadID, True) then
      begin
        BringWindowToTop(hwnd); // IE 5.5 related hack
        SetForegroundWindow(hwnd);
        AttachThreadInput(ThisThreadID, ForegroundThreadID, False);
        Result := (GetForegroundWindow = hwnd);
      end;
      if not Result then
      begin
        // Code by Daniel P. Stasinski
        SystemParametersInfo(SPI_GETFOREGROUNDLOCKTIMEOUT, 0, @timeout, 0);
        SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(0),
          SPIF_SENDCHANGE);
        BringWindowToTop(hwnd); // IE 5.5 related hack
        SetForegroundWindow(hWnd);
        SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(timeout), SPIF_SENDCHANGE);
      end;
    end
    else
    begin
      BringWindowToTop(hwnd); // IE 5.5 related hack
      SetForegroundWindow(hwnd);
    end;

    Result := (GetForegroundWindow = hwnd);
  end;
end; { ForceForegroundWindow }

Function BoolToStr(ABool : Boolean) : String;
Begin
   If ABool then
      result := 'TRUE'
   else
      RESULT := 'FALSE';
end;
//****************************************************************

Function OnlyAlpha(AStr : String) : String;
Var
   I : Integer;
Begin
   Result := '';
   For I := 1 to length(AStr) Do begin
      If ((Ord(AStr[I]) >= 32) and (ord(AStr[I]) <= 126)) or (ord(AStr[I]) = 9) then
         Result := Result + AStr[I];
   end;
end;

//******************************************************************
Function GenerateBarcode(Num : integer; Mask : String) : String;
Var
   WorkStr      : String;
   WorkI        : integer;
   I            : Integer;
Begin
   Result := '';
   WorkStr := Trim(Stri(Num, -1));
   While Length(WorkStr) < 13 do
      WorkStr := '0' + WorkStr;
   WorkI := 13;
   For I := length(Mask) Downto  1 do begin
      If Mask[I] = '#' then begin
         Result := Workstr[WorkI] + Result;
         Dec(WorkI);
      end else begin
         Result := Mask[I] + Result;
      end;
   end;
end;

Function AppFindComponent(ComponentName : String) : TComponent;
var
   I : integer;
begin
  For I:= 0 to Application.ComponentCount -1 do begin
     If //(Application.Components[i] is TForm) and
        (Trim(UpCaseString(Application.Components[i].Name)) = UpCaseString(Trim(ComponentName))) then begin
        Result := Application.Components[i];
        exit;
     end;
  end;
end;

Function ExtractBuildNumberFromVersion(VersionStr : String): Integer;
Begin
   ParseToChar(VersionStr, '.');
   ParseToChar(VersionStr, '.');
   ParseToChar(VersionStr, '.');
   Result := Valu(VersionStr);
end;
//******************************************************************
Function StringListAdd(AddFrom : TStringList; AddTo : TStringList) : Integer;
var
   I : Integer;
Begin
   For I := 0 to AddFrom.Count -1 do begin
      AddTo.Add(AddFrom[I]);
   end;
   Result := AddFrom.Count;
end;
//******************************************************************
const
  Codes64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';
function Base64Decode(const S: String): String;
var
  i: Integer;
  a: Integer;
  x: Integer;
  b: Integer;
begin
  Result := '';
  a := 0;
  b := 0;
  for i := 1 to Length(s) do
  begin
    x := Pos(s[i], codes64) - 1;
    if x >= 0 then
    begin
      b := b * 64 + x;
      a := a + 6;
      if a >= 8 then
      begin
        a := a - 8;
        x := b shr a;
        b := b mod (1 shl a);
        x := x mod 256;
        Result := Result + chr(x);
      end;
    end
    else
      Exit;
  end;
end;
//******************************************************************
function Base64Encode(const S: String): String;
var
  i: Integer;
  a: Integer;
  x: Integer;
  b: Integer;
begin
  Result := '';
  a := 0;
  b := 0;
  for i := 1 to Length(s) do
  begin
    x := Ord(s[i]);
    b := b * 256 + x;
    a := a + 8;
    while a >= 6 do
    begin
      a := a - 6;
      x := b div (1 shl a);
      b := b mod (1 shl a);
      Result := Result + Codes64[x + 1];
    end;
  end;
  if a > 0 then
  begin
    x := b shl (6 - a);
    Result := Result + Codes64[x + 1];
  end;
end;

Function Base64CharsOnly(S : String) : String;
var
   I : Integer;
Begin
   Result := '';
   For I := 1 to Length(S) do begin
      If Pos(S[I],Codes64) > 0 then begin
         Result := Result + S[I];
      end;
   end;


end;

//******************************************************************
Function CutWords(Var InStr : String; MaxChars : Integer) : String;
var
   I : Integer;
Begin
   If Length(InStr) < MaxChars then begin
      Result := Trim(InStr);
      InStr := '';
      exit;
   end;

   I := MaxChars;
   While (InStr[I] <> ' ') and (I <> 1) do
      Dec(I);
   Result := Copy(InStr,1,I);
   Delete(InStr,1,I);

end;
//******************************************************************
Function getsys32Folder : String;
var
  lpBuffer: array[0..255] of char;
  SysDir: string;
begin
  GetSystemDirectory(lpBuffer, 255);
  Result := StrPas(@lpBuffer[0]);
end;

//******************************************************************
function ExecAndWait(const ExecuteFile, ParamString : string): boolean;
var
  SEInfo: TShellExecuteInfo;
  ExitCode: DWORD;
begin
  FillChar(SEInfo, SizeOf(SEInfo), 0);
  SEInfo.cbSize := SizeOf(TShellExecuteInfo);
  with SEInfo do begin
    fMask := SEE_MASK_NOCLOSEPROCESS;
    Wnd := Application.Handle;
    lpFile := PChar(ExecuteFile);
    lpParameters := PChar(ParamString);
    nShow := SW_HIDE;
  end;
  if ShellExecuteEx(@SEInfo) then
  begin
    repeat
      Application.ProcessMessages;
      GetExitCodeProcess(SEInfo.hProcess, ExitCode);
    until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
    Result:=True;
  end
  else Result:=False;
end;

//******************************************************************

Function RegisterOCX(FileName : String) : Boolean;
type
  TRegFunc = function : HResult; stdcall;
var
  ARegFunc : TRegFunc;
  aHandle  : THandle;
begin
 Result := False;
 try
  aHandle := LoadLibrary(@FileName[1]);
  if aHandle <> 0 then
  begin
    ARegFunc := GetProcAddress(aHandle,'DllRegisterServer');
    if Assigned(ARegFunc) then
    begin
      ExecAndWait('regsvr32','/s ' + FileName);
    end;
    FreeLibrary(aHandle);
    Result := True;
  end;
 except
 end;
end;
//******************************************************************
Function EXEFolder : String;
Var
WS : String;
Begin
   WS := ParamStr(0);
   Result := Pathonly(WS);
end;
//******************************************************************

Function StringEndsWith(TestStr : String; TestEnding : String) : Boolean;
Begin
   Result := False;
   If Length(TestEnding) > Length(TestStr) Then exit;
   Result := TestEnding = Copy(TestStr, Length(TestStr) - Length(TestEnding) + 1, Length(TestEnding));

end;
//******************************************************************
Function TrimCRLF(AStr : String): String;
Begin
   ReplaceString(AStr,#10,'');
   ReplaceString(AStr,#13,'');
   Result := AStr;
end;
//******************************************************************

procedure DisableProcessWindowsGhosting;
var
  DisableProcessWindowsGhostingProc: procedure;
begin
  DisableProcessWindowsGhostingProc := GetProcAddress(
    GetModuleHandle('user32.dll'),
    'DisableProcessWindowsGhosting');
  if Assigned(DisableProcessWindowsGhostingProc) then
    DisableProcessWindowsGhostingProc;
end;

//******************************************************************

Function EMailUserPart(Email : String) : String;
Begin
   EMail := UpCasestring(Email);
   EMail := Trim(Email);
   Result := ParseToChar(EMail,'@');
end;
Function EMailDomainPart(Email : String) : String;
Begin
   ParseToChar(EMail,'@');
   Result := Email;
end;

Function GetNthTabPosition(AStr : String;APos : Integer) : String;
var
   I : Integer;
Begin
   For I := 1 to APos -1 do
      ParseToChar(AStr,#9);
   Result := ParseToChar(AStr,#9);
end;


Function FileToInclude(SourceFile : String) : integer;
Var
  InFile : String;
  OutFile : TStringList;
  WS : String;
  I : Integer;

Begin
   OutFile := TStringList.Create;
   InFile := LoadFileToStr(SourceFile);

   OutFile.Add('Const ' + FileOnly(SourceFile) + ': Array[1..' + Stri(Length(InFile),-1) + '] of Byte = (');

   While length(InFile) > 0 do begin
      WS := '';
      For I := 1 to 16 do begin
         If Length(InFile) <> 0 then begin
            WS := WS + '$' + BytesToHexString(InFile[1],1) + ',';
            Delete(InFile,1,1);
         end;
      end;
      If InFile = '' then
      StripTrailingComma(WS);
      OutFile.Add(WS);
   end;
   OutFile.Add(');');
   OutFile.SaveToFile(SourceFile + '.inc');
   OutFile.Free;

end;

function FindVolumeSerial(const Drive : String) : string;
var
   VolumeSerialNumber : DWORD;
   MaximumComponentLength : DWORD;
   FileSystemFlags : DWORD;
   SerialNumber : string;
begin
   Result:='';

   GetVolumeInformation(
        @Drive[1],
        nil,
        0,
        @VolumeSerialNumber,
        MaximumComponentLength,
        FileSystemFlags,
        nil,
        0) ;
   SerialNumber :=
         IntToHex(HiWord(VolumeSerialNumber), 4) +
         ' - ' +
         IntToHex(LoWord(VolumeSerialNumber), 4) ;

   Result := SerialNumber;
end; (*FindVolumeSerial*)

Function NormalizeWebInput(Astr : String) : String;
var
   WS : String;
   I : integer;
   NewChar : String;
begin

   Repeat
      I := Pos('%',AStr);
      If I > 0 then begin
         WS := Copy(AStr,I+1,2);
         NewChar := Chr(StrToInt('$' + WS));
         ReplaceString(AStr,'%' + WS, NewChar);
      end;
   Until I = 0;
   Result := AStr;
end;

Function WebParamEncode(Astr : String) : String;
var
   WS : String;
   I : integer;
   HS : String;
begin
   WS := '';
   For I := 1 to length(AStr) do begin
      If AStr[I] in ['A'..'Z', 'a'..'z','0'..'9'] then begin
{         WS := WS + AStr[I];
      end else begin}

         WS := WS + AStr[I];
      end else begin

         WS := WS + '%'+ BytesToHexString(AStr[I],1);
      end;
   end;

   Result := WS;
end;

Function ToUTF(InStr : String): String;
var
   I : Integer;
Begin
   Result := InStr;
   ReplaceString(Result,'&', #254+'amp;');
   ReplaceString(Result,'<', '&lt;');
   ReplaceString(Result,'>', '&gt;');
   ReplaceString(Result,'"', '&quot;');
   ReplaceString(Result,'''', '&apos;');

   //do the 254 thing so we don't loop forever
   For I := 1 to Length(Result) do begin
      If Result[I] = #254 then Result[I] := '&';
   end;

end;
Function FromUTF(InStr : String): String;
var
   I : Integer;
Begin
   Result := InStr;
   ReplaceString(Result,'&amp;', '&');
   ReplaceString(Result,'&lt;','<');
   ReplaceString(Result,'&gt;','>');
   ReplaceString(Result,'&quot;','"');
   ReplaceString(Result,'&apos;','''');
end;

Function CorpWWWStyle : String;
Begin
   Result := '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">' +
             '<STYLE TYPE="text/css">' +
             '<!--' +
             '   BODY' +
             '   {' +
             '     color:Black;' +
             '     font-size:10pt;' +
             '     background-color:White;' +
             '     font-family:sans-serif;' +
             '   }' +
             '   TABLE' +
             '   {' +
             '     color:Black;' +
             '     font-size:8pt;' +
             '     background-color:White;' +
             '     font-family:sans-serif;' +
             '   }' +
             'A:link{color:Blue}' +
             'A:visited{color:Purple}' +
             '-->' +
             '</STYLE>';
end;

Function HTMLStateSelected(State : String) : String;
var
   ASL : TstringList;
   WS : String;
   XS : String;
   StateShort : String;
   I : Integer;
Begin
   ASL := TStringList.Create;
   State := Trim(UpCaseString(State));
   If State = '' then State := 'AL';
   ASL.Add('AL=Alabama');
   ASL.Add('AK=Alaska');
   ASL.Add('AZ=Arizona');
   ASL.Add('AR=Arkansas');
   ASL.Add('CA=California');
   ASL.Add('CO=Colorado');
   ASL.Add('CT=Connecticut');
   ASL.Add('DE=Delaware');
   ASL.Add('DC=District Of Columbia'); 
   ASL.Add('FL=Florida'); 
   ASL.Add('GA=Georgia'); 
   ASL.Add('HI=Hawaii'); 
   ASL.Add('ID=Idaho'); 
   ASL.Add('IL=Illinois'); 
   ASL.Add('IN=Indiana'); 
   ASL.Add('IA=Iowa'); 
   ASL.Add('KS=Kansas'); 
   ASL.Add('KY=Kentucky'); 
   ASL.Add('LA=Louisiana'); 
   ASL.Add('ME=Maine'); 
   ASL.Add('MD=Maryland'); 
   ASL.Add('MA=Massachusetts'); 
   ASL.Add('MI=Michigan');
   ASL.Add('MN=Minnesota');
   ASL.Add('MS=Mississippi');
   ASL.Add('MO=Missouri');
   ASL.Add('MT=Montana');
   ASL.Add('NE=Nebraska');
   ASL.Add('NV=Nevada'); 
   ASL.Add('NH=New Hampshire');
   ASL.Add('NJ=New Jersey');
   ASL.Add('NM=New Mexico'); 
   ASL.Add('NY=New York'); 
   ASL.Add('NC=North Carolina'); 
   ASL.Add('ND=North Dakota'); 
   ASL.Add('OH=Ohio'); 
   ASL.Add('OK=Oklahoma');
   ASL.Add('OR=Oregon'); 
   ASL.Add('PA=Pennsylvania'); 
   ASL.Add('RI=Rhode Island'); 
   ASL.Add('SC=South Carolina'); 
   ASL.Add('SD=South Dakota'); 
   ASL.Add('TN=Tennessee'); 
   ASL.Add('TX=Texas'); 
   ASL.Add('UT=Utah'); 
   ASL.Add('VT=Vermont');
   ASL.Add('VA=Virginia');
   ASL.Add('WA=Washington');
   ASL.Add('WV=West Virginia');
   ASL.Add('WI=Wisconsin');
   ASL.Add('WY=Wyoming');
   WS := '<select name="STATE">';
   For I := 0 to ASL.Count -1 do begin
      XS := ASL[I];
      StateShort := ParseToChar(XS,'=');
      WS := WS + '<option value="'+ StateShort +'" ';
      If StateShort = State then
         WS := WS + 'selected="selected"';
      WS := WS + '>'+XS+'</option>';
   end;
   WS := WS + '</select>';

   Result := Ws;
   ASL.Free;
end;

Function ZTimeToLocalTime(ZTime : String) : TDateTime;
var
   Year,Month,Day : Integer;
   Hour,min,Sec,MSEC : Integer;
Begin
   Year := Valu(Copy(ZTime,1,4));
   Month := Valu(Copy(ZTime,6,2));
   Day := Valu(Copy(ZTime,9,2));
   Hour := Valu(Copy(Ztime,12,2));
   Min := Valu(Copy(Ztime,15,2));
   Sec := valu(Copy(Ztime,18,2));
   MSec := Valu(Copy(ZTime,21,3));
   Result := EncodeDate(Year,Month,Day) + EncodeTime(Hour,Min,Sec,msec);
   Result := Result - GetTimeZoneBiasDT;

end;

Function GetTimeZoneBiasDT : TdateTime;
var
   Hour : Integer;
   Min : Integer;
begin
   Hour := GetTimeZoneBias div 60;
   Min := GetTimeZOneBias mod 60;
   Result := Encodetime(Hour,Min,0,0);
end;

Function GetTimeZoneBiasByName(ZoneAbbr : String) : TDateTime;
Begin
   Result := EncodeTime(5,0,0,0); //Default to EST
   ZoneAbbr := Trim(UpCaseString(ZoneAbbr));

   If ZoneAbbr = '' Then
      Result := GetTimeZoneBiasDT;

   If ZoneAbbr = 'AST' then Result := EncodeTime(4,0,0,0); //Atlantic
   If ZoneAbbr = 'EST' then Result := EncodeTime(5,0,0,0); //Eastern
   If ZoneAbbr = 'CST' then Result := EncodeTime(6,0,0,0); //Central
   If ZoneAbbr = 'MST' then Result := EncodeTime(7,0,0,0); //Mountain
   If ZoneAbbr = 'PST' then Result := EncodeTime(8,0,0,0); //Pacific
   If ZoneAbbr = 'AKST' then Result := EncodeTime(9,0,0,0); //Alaska
   If ZoneAbbr = 'HAST' then Result := EncodeTime(10,0,0,0); //Hawaii
end;

Function LocalTimeToGMT(LocalTime : TDateTime) : TDateTime;
Begin
   Result := LocalTime + GetTimeZoneBiasDT;
end;

Function GMTToLocalTime(GMTTime : TDateTime) : TDateTime;
Begin
  Result := GMTTime - GetTimeZoneBiasDT;
end;

Function LocalTimeToZoneTime(LocalTime : TDateTime; ZoneAbbr : String) : TDateTime;
var
  GMTTime : TDateTime;
Begin
   GMTTime := LocalTimeToGMT(LocalTime);
   Result := GMTTime - GetTimeZoneBiasByName(ZoneAbbr);
end;

Function DTToGMTStr(ADT : TDateTime) : String;
Begin
   Result := FormatDateTime('YYYY-MM-DD', ADT + GetTimeZoneBiasDT) + 'T' + FormatDateTime('HH:NN:SS.ZZZ', ADT + GetTimeZoneBiasDT);
end;

Function ValidateStateAbbr(State : String) : Boolean;
var
   StateList : TStringList;
Begin
   State := Trim(UpCaseString(State));
   StateList := TStringList.Create;
   StateList.CommaText := 'AL,AK,AZ,AR,CA,CO,CT,DE,FL,GA,HI,ID,IL,IN,IA,KS,KY,LA,ME,MD,MA,MI,MN,MS,MO,MT,' +
                          'NE,NV,NH,NJ,NM,NY,NC,ND,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VT,VA,WA,WV,WI,WY,'+
                          'AE,AA,AP';
   Result := StateList.IndexOf(State) <> -1;
   StateList.Free;

end;


Function GenerateGUID : String;
var
  Guid : TGuid;
  WS : String;
begin
  Result := '';
  if CoCreateGuid(Guid) = S_OK then begin
     WS := GuidToString(Guid);
     ParseToChar(WS, '{');
     result := ParseToChar(WS, '}');
  end;
end;

function CurrentMemoryUsage: Cardinal;
var
  pmc: TProcessMemoryCounters;
begin
  pmc.cb := SizeOf(pmc) ;
  Result := 0;
  if GetProcessMemoryInfo(GetCurrentProcess, @pmc, SizeOf(pmc)) then
    Result := pmc.WorkingSetSize;
end;

Function IsValidUploadStr(Astr : String) : Boolean;
Var
   I : integer;
Begin
   Result := False;
   For I := 1 to length(AStr) -1 do begin
      if NOT (AStr[I] in [#9,#10,#13,' '..'~']) then begin
         messagebeep(0);
         exit;
      end;
   end;
   Result := True;
end;

Function CleanUploadStr(ASTR : String) : String;
var
   I : Integer;
Begin
   For I := 1 to length(AStr) do begin
      If AStr[I] in [#9,#10,#13,' '..'~'] then
         Result := Result + Astr[I];
   end;

end;

Function StripNulls(Astr : String) : String;
var
   I : Integer;
begin
   Result := '';
   For I := 1 to length(AStr) do begin
      If AStr[I] <> #0 then
         Result := Result + Astr[I];
   end;
end;

Procedure StripXMLTag(Var RawXML: String; TagName : String);
var
   StartTagPos : integer;
   EndTagPos : Integer;
Begin
   StartTagPos := Pos('<' +TagName + '>', RawXML);
   EndTagPos := Pos('</' +TagName + '>', RawXML);

   If StartTagPos = 0 then exit;
   If EndTagPos = 0 then Exit;
   If EndTagPos < StartTagPos then exit;
   Delete(RawXML, StartTagPos, EndTagPos - StartTagPos + Length('</' +TagName + '>'));
end;


Function DSToHTMLTable(ADS : TDataSet) : String;
var
   WS : String;
   I : integer;
Begin
   WS :=  '<TABLE border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse">';
   WS := WS + '<TR>';
   For I := 0 to ADS.FieldCount -1 do begin
       WS := WS + '<TD><B>' + Ads.Fields[I].FieldName + '</B></TD>';
   end;
   WS := WS + '</TR>';

   ADS.First;
   While Not ADS.EOF do begin
   WS := WS + '<TR>';
      For I := 0 to ADS.FieldCount -1 do begin
          WS := WS + '<TD>' + Ads.Fields[I].AsString + '</TD>';
      end;
      WS := WS + '</TR>';
      ADS.Next;
   end;
   WS := WS + '</TABLE>';
   Result := WS;
end;

Initialization
   GlobalCopyGridFieldNames := False;
   Try
      DisableProcessWindowsGhosting;
   except
      On E:Exception do begin
      end;
   end;

   UtilityReg := TRegIniFile.Create('Tempus Technologies');
   UtilityReg.RootKey := HKEY_LOCAL_MACHINE;
   UtilityReg.OpenKey('SOFTWARE\Tempus Technologies', True);
Finalization
   UtilityReg.Free;

end.




