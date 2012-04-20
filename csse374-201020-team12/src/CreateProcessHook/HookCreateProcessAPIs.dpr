library HookCreateProcessAPIs;

// see http://www.delphipages.com/forum/showthread.php?t=43003 for info on imagebase
// this changes the address that the DLL loads to by default
{$IMAGEBASE $5a800000}

uses
  Windows,
  madCodeHook,
  madRemote,
  madStrings;

type
  TTerminationRequest = record
    system             : boolean;
    process1, process2 : array [0..MAX_PATH] of char;
  end;

function IsAllowed(processHandle: dword) : boolean;
// ask the user whether the current process may create the specified process
var tr      : TTerminationRequest;
    arrChW  : array [0..MAX_PATH] of widechar;
    session : dword;
begin
  if (processHandle <> 0) and (processHandle <> GetCurrentProcess) then begin
    tr.system := AmSystemProcess();
    if GetVersion and $80000000 = 0 then begin
      GetModuleFileNameW(0, arrChW, MAX_PATH);
      WideToAnsi(arrChW, tr.process1);
    end else
      //Crash and burn, we don't support Win9x at this time
      result := false;

    //see who is doing the creating
    ProcessIdToFileNameA(ProcessHandleToId(processHandle), tr.process2, MAX_PATH);

    // which terminal server (XP fast user switching) session shall we contact?
    if AmSystemProcess and (GetCurrentSessionId = 0) then
      // some system process are independent of sessions
      // so let's contact the HookProcessTermination application instance
      // which is running in the current input session
      session := GetInputSessionId
    else
      // we're an application running in a specific session
      // let's contact the HookProcessTermination application instance
      // which runs in the same session as we do
      session := GetCurrentSessionId;
    // contact our application, which then will ask the user for confirmation
    // hopefully there's an instance running in the specified session
    if not SendIpcMessage(pchar('HookProcessCreation' + IntToStrEx(session)),
                          @tr,     sizeOf(tr),            // our message
                          @result, sizeOf(result)) then   // the answer
      // we can't reach our application, so we allow the creation
      // CHANGE THIS
      result := true;
    end else
      // the process may be created
      result := true;
end;   }

var NtCreateProcessNext : function (processHandle, exitCode: dword) : dword; stdcall;

function NtCreateProcessCallback(processHandle, exitCode: dword) : dword; stdcall;
const STATUS_ACCESS_DENIED = $C0000022;
begin
  //if not IsAllowed(processHandle) then
  SendIpcMessage(pchar('HookProcessCreation' + IntToStrEx(GetCurrentSessionId)),
                          nil, 0,            // our message
                          nil, 0);
  result:= STATUS_ACCESS_DENIED;
  //else
  //result := NtCreateProcessNext(processHandle, exitCode);
end;

// ***************************************************************
begin
  // the XP task manager's "end process" calls TerminateProcess but "end task"
  // calls NtTerminateProcess, so we hook the lower level API in the NT family
  //if GetVersion and $80000000 = 0 then
  //NtCreateProcessEx   NtWriteFile
   HookAPI('ntdll.dll', 'NtCreateProcessEx', @NtCreateProcessCallback, @NtCreateProcessNext);
   //HookAPI(   'ntdll.dll', 'NTWriteFile', @NtCreateProcessCallback, @NtCreateProcessNext);
end.
