library HookCreateProcessAPIs;

// see http://www.delphipages.com/forum/showthread.php?t=43003 for info on imagebase
// this changes the address that the DLL loads to by default
{$IMAGEBASE $5a800000}

//'use' as few files as possible in your DLL
uses
  Windows,
  madCodeHook,
  madStrings,
  //The next three files are from the Jedi for Delphi Project
  JwaNtStatus,
  JwaWinBase,
  JwaWinType,
  //Pickle.pas contains the data structure that our DLL will pass to the main program
  Pickle;

//This function sends an IPC (inter-process commincation) message to the main program
//It is currently configured to work for NtCreateProcessEx
//Currently, the goal is simply to pass along the arguments so I can analyze them in the main program.
function SendIPC(ProcessHandle : PLongWord;
                 DesiredAccess: ACCESS_MASK;
                 ObjectAttributes: POBJECT_ATTRIBUTES;
                 InheritFromProcessHandle: THANDLE;
                 InheritHandles: LONGBOOL;
                 SectionHandle: DWORD;
                 DebugPort: DWORD;
                 ExceptionPort: DWORD;
                 dwSaferFlags: DWORD) : boolean;
var cr : TCreationRequest;
begin
    //TCreationRequest is the pickle object, we initialize with the funciton arguments,
    //which are the same arguments obtained from hooking NtCreateProcessEx. This pickle
    //could be anything, just don't use strings (as the pickle itself, or as a member of the record)!!!
    cr.ProcessHandle:= ProcessHandle;
    cr.DesiredAccess:= DesiredAccess;
    cr.ObjectAttributes:= ObjectAttributes;
    cr.InheritFromProcessHandle:= InheritFromProcessHandle;
    cr.InheritHandles:= InheritHandles;
    cr.SectionHandle:= SectionHandle;
    cr.DebugPort:= DebugPort;
    cr.ExceptionPort:= ExceptionPort;
    cr.dwSaferFlags:= dwSaferFlags;
    //HookProcessCreation+CurrentSessionID is the "mailbox" to deliver this message to
    //It has to match the "CreateIPC" call and the "DestroyIPC" call in Monitor.pas of the main program
    //The SendIpcMessage takes the address (mailbox), pickle object, size of the pickle, and a result pointer and size.
    //The main program can pass anything back to the dll through the result parameter
    if not SendIpcMessage(pchar('HookProcessCreation' + IntToStrEx(GetCurrentSessionId)),
                          @cr,     sizeOf(cr),            // our message
                          @result, sizeOf(result)) then   // the answer
    Begin
        //this is the action to take if the IPC send fails. This would occur if our program isn't running,
        //for example, when it crashes during development. This allows us to start a new instance of the
        //program so we can unload the driver without restarting the computer.
        //FOR DEBUG ONLY. For release, this MUST be changed to 'false' so that if malicious code kills our
        //program, ALL programs are denied, rather than all apps being allowed.
        result := true;
    end;
end;

//This is the "APINext" header. It is NOT defined, only declared. You have to make
//a separate APINext variable for each API, EVEN IF THE PARAMETERS ARE THE SAME.
//This function represents the "next thing to do" in the chain of events. We call
//it to continue the process creation process.
var NtCreateProcessExNext:function(ProcessHandle : PLongWord;
                                   DesiredAccess: ACCESS_MASK;
                                   ObjectAttributes: POBJECT_ATTRIBUTES;
                                   InheritFromProcessHandle: THANDLE;
                                   InheritHandles: LONGBOOL;
                                   SectionHandle: DWORD;
                                   DebugPort: DWORD;
                                   ExceptionPort: DWORD;
                                   dwSaferFlags: DWORD): NTSTATUS; stdcall;

//This is the funciton that is called when the API is hooked. Its paramenters
//must match EXACTLY with the APINext function and the API header.
function NtCreateProcessExCallback(ProcessHandle : PLongWord;
                                   DesiredAccess: ACCESS_MASK;
                                   ObjectAttributes: POBJECT_ATTRIBUTES;
                                   InheritFromProcessHandle: THANDLE;
                                   InheritHandles: LONGBOOL;
                                   SectionHandle: DWORD;
                                   DebugPort: DWORD;
                                   ExceptionPort: DWORD;
                                   dwSaferFlags: DWORD): NTSTATUS; stdcall;
Begin
  //all of the arguments passed in to the function are obtained from the API.

  //send a message containing all of this data for analysis to the main program
  //this notifies the main program that we hooked a process.
  if SendIPC(ProcessHandle,
             DesiredAccess,
             ObjectAttributes,
             InheritFromProcessHandle,
             InheritHandles,
             SectionHandle,
             DebugPort,
             ExceptionPort,
             dwSaferFlags) = true then
  Begin
  //To "allow" the process to continue, do your stuff and then call this as the last thing.
  //this continues the createProcess request from the user
       result := NtCreateProcessExNext(ProcessHandle,
                                     DesiredAccess,
                                     ObjectAttributes,
                                     InheritFromProcessHandle,
                                     InheritHandles,
                                     SectionHandle,
                                     DebugPort,
                                     ExceptionPort,
                                     dwSaferFlags);
  end
  else
  Begin
     //this NtStatus code is defined in JwaNtStatus.
     result := STATUS_ACCESS_DENIED;
  end;
end;


{
//This is the same deal for a different API. This API isn't published either, so again,
//something is wrong with my headers (I guess). While NtCreateProcessEx is THE lowest level
//(EVERY create process event calls it at some point), CreateProcessInternalW is the next
//best thing. Unfortunately, it crashes with nasty errors that I haven't had time to debug
//since the Next and Callback headers match excactly, the problem must be with matching the API
//header. Good luck doing that since it isn't published.
var CreateProcessInternalWNext:function(hToken:THANDLE;
                                        lpApplicationName:LPCWSTR;
                                        lpCommandLine:LPWSTR;
                                        lpProcessAttributes:PSecurityAttributes;
                                        lpThreadAttributes:PSecurityAttributes;
                                        bInheritHandles:LongBool;
                                        dwCreationFlags:DWORD;
                                        lpEnvironment:Pointer;
                                        lpCurrentDirectory:LPCWSTR;
                                        lpStartupInfo:LPSTARTUPINFOW;
                                        lpProcessInformation:LPPROCESS_INFORMATION;
                                        hNewToken:PHANDLE):LongBool;
function CreateProcessInternalWCallback(hToken:THANDLE;
                                        lpApplicationName:LPCWSTR;
                                        lpCommandLine:LPWSTR;
                                        lpProcessAttributes:PSecurityAttributes;
                                        lpThreadAttributes:PSecurityAttributes;
                                        bInheritHandles:LongBool;
                                        dwCreationFlags:DWORD;
                                        lpEnvironment:Pointer;
                                        lpCurrentDirectory:LPCWSTR;
                                        lpStartupInfo:LPSTARTUPINFOW;
                                        lpProcessInformation:LPPROCESS_INFORMATION;
                                        hNewToken:PHANDLE):LongBool;
Begin
  //SendIPC(ObjectAttributes);
  //result:= STATUS_ACCESS_DENIED;
  result := CreateProcessInternalWNext(hToken,
                                       lpApplicationName,
                                       lpCommandLine,
                                       lpProcessAttributes,
                                       lpThreadAttributes,
                                       bInheritHandles,
                                       dwCreationFlags,
                                       lpEnvironment,
                                       lpCurrentDirectory,
                                       lpStartupInfo,
                                       lpProcessInformation,
                                       hNewToken);
end; }
// ***************************************************************
begin
   //the line for GetVersion checks for Windows XP
  //if GetVersion and $80000000 = 0 then

   //HookAPI actually hooks the API. It takes the dll that the API is in, the name of the API to hook,
   //your callback function (the function that is called when the API is hooked) and the 'next' function,
   //which YOU call to continue the API chain.
   HookAPI('ntdll.dll', 'NtCreateProcessEx', @NtCreateProcessExCallback, @NtCreateProcessExNext);

   //this one crashes the system currently
   //Notice that CreateProcessInternalW is in a different DLL.
   //HookAPI('kernel32.dll', 'CreateProcessInternalW', @CreateProcessInternalWCallback, @CreateProcessInternalWNext);

end.
