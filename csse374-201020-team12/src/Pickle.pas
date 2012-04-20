unit Pickle;

interface
{
This file contains the data structures that the DLL and our program use to communicate.
}
uses Windows, JwaWinType;

//NTSTATUS, not defined in Windows, or in any Jedi library I could find
type //NTSTATUS = LongInt;

	//couldn't find this in Jedi either.
    PUNICODE_STRING = ^UNICODE_STRING;
	UNICODE_STRING = packed record
	Length: Word;
	MaximumLength: Word;
        Buffer: PWideChar;
end;
	//couldn't find this one in Jedi either.
    POBJECT_ATTRIBUTES = ^OBJECT_ATTRIBUTES;
	OBJECT_ATTRIBUTES = packed record
	Length: Cardinal;
	RootDirectory: THandle;
        ObjectName: PUNICODE_STRING;
	Attributes: Cardinal;
	SecurityDescriptor: Pointer;
	SecurityQualityOfService: Pointer;
end;
//it is possible that my problems are stemming from improper definitions of the structures above.

//This is the pickle object. For my current testing, i'm just passing along all of the arguments from the hook so I can look at what I'm getting.  You can make this data structure anything you want. DO NOT USE STRINGS. (I think pchars are okay).
     TCreationRequest = record
        ProcessHandle : PLongWord;//PHandle same as ^LongWord = PLongWord
        DesiredAccess: ACCESS_MASK;
        ObjectAttributes: POBJECT_ATTRIBUTES;
        InheritFromProcessHandle: THANDLE;
        InheritHandles: LONGBOOL;
        SectionHandle: DWORD;
        DebugPort: DWORD;
        ExceptionPort: DWORD;
        dwSaferFlags: DWORD;
end;
implementation

end.
