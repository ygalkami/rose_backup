unit Monitor;
{
This file contains code to intercept API hooks and handle them
}
interface

uses Pickle, Windows, madCodeHook, SysUtils, Dialogs, Database, Hash;

var
    SSA_DB : TDBModule;
    HashObj : THashModule;

procedure StartMonitor();
procedure StopMonitor();
function fileWhitelisted(Path : string) : Integer;

implementation

function BoolToStr(b:LongBool):String;
Begin
  if b = true then
    result := 'true'
  else
    result := 'false';
end;

//this function is referenced in StartMonitor below. Its purpose is to receive IPC messages from the DLL.
procedure ReceiveIPC(name       : pchar;
                     messageBuf : pointer;
                     messageLen : dword;
                     answerBuf  : pointer;
                     answerLen  : dword); stdcall;
var cr:TCreationRequest;
begin
   //right now, all I'm doing is unpacking the creationRequest (the pickled arguments)
   //and displaying them to see what I have. One interesting thing I've noticed is that
   //both of the pointers (ProcessHandle and ObjectAttributes) are always NIL
   cr := TCreationRequest(messageBuf^);
   //both pointers are NIL
   //return an answer to the DLL
   //this is how you tell the DLL to either allow the process creation or not.
   boolean(answerBuf^) := boolean(MessageBox(0, pchar('Message received: '+#13#10+
                                                //although ProcessHandle is supposedly a PHandle (^Handle), I can't dereference it.
                                                //this may be because I'm not using pointers correctly, but I think it is because I'm
                                                //either getting a corrupted address or it's not really supposed to be a pointer.
                                                Format('%p', [cr.ProcessHandle])+#13#10+
                                                //objectAttributes seems to be always nil, which is inconvenient because that's where
                                                //the info we need should be stored.
                                                BoolToStr(longBool(cr.objectAttributes=nil))+#13#10+ //nil
                                                IntToStr(DWORD(cr.DesiredAccess))+#13#10+
                                                IntToStr(LongWord(cr.InheritFromProcessHandle))+#13#10+
                                                BoolToStr(cr.InheritHandles)+#13#10+
                                                IntToStr(DWORD(cr.SectionHandle))+#13#10+
                                                IntToStr(DWORD(cr.DebugPort))+#13#10+
                                                IntToStr(DWORD(cr.ExceptionPort))+#13#10+
                                                IntToStr(DWORD(cr.dwSaferFlags))),
                                                'Question...',
                                      MB_ICONQUESTION or MB_YESNO or MB_TOPMOST) = ID_YES);
   //it doesn't appear that hooking NtCreateProcessEx will work for what we're trying to accomplish. It may, with a little more digging.
end;

procedure InitMonitor();
Begin
  SSA_DB := TDBModule.GetInstance();
  HashObj := THashModule.GetInstance();
end;

//Determine if a file is whitelisted
//This function is intended to be called solely by HandleProcessCreationRequest.
//The idea is to get the message from the DLL in HandleProcessCreationRequest, unpack it, and extract the file path.
//Then, pass the path to this function, which will access the database and determine if the file is whitelisted or not.
//Since we don't have hooking working, we have simulated a test. Clicking 'Test' calls this function directly.
function fileWhitelisted(Path : string): Integer;
var
    dbHash : Variant;
    dbBool : Variant;
    FileHash : String;
begin
    //REMOVE THIS CALL, it is only for the test button. When hooking is working, there is no need to initialize the monitor,
    //it will already be done.
    InitMonitor();
    
    //Get the hash of the file from the db
    dbHash := SSA_DB.getFileHash(Path);
    //Hash the file
    FileHash := HashObj.HashFile(Path);

    if (vartype(dbHash) and VarTypeMask) <> varString then
    Begin
      MessageDlg('file was not in the db', mtInformation, [mbOk], 0);
    end
    else
    Begin
        //Check to see if the file has changed since we added it to the db
        if FileHash = dbhash then
        Begin
           //if it hasn't changed see if it is whitelisted
           dbBool := SSA_DB.isFileWhitelisted(dbHash);
           //make sure we get a boolean from the db
           if (vartype(dbBool) and VarTypeMask) = varBoolean then
           Begin
                if dbBool = True then
                Begin
                    showmessage(Path + ' can run');
                end
                else
                begin
                    showmessage(Path + ' cannot run');
                end;
           end
           else
           Begin
               showmessage(Path + ' was not in the db');
           end;
        end
        else
        Begin
           showmessage(Path + ' hash did not match file hash');
        end;
    end;
    result := 1;
end;

function InjectHookDLL():Boolean;
Begin
  //This loads the Madshi driver which must already have been configured by createDriver.bat
  //The first argument is the driver name, which must match the name in createDriver.bat
  //the other args are the 32-bit driver and 64-bit driver.
  result := LoadInjectionDriver('HookProcessCreationDriver',
                                'TempusInjectionDriver32.sys',
                                'TempusInjectionDriver64.sys');
  if result = true then
  begin
      MessageDlg('Driver successfully loaded.', mtInformation,      [mbOk], 0);
  end else
  begin
      MessageDlg('Failed to load driver.', mtInformation,      [mbOk], 0);
      exit;
  end;
  //now that the driver has been loaded, we can use it to inject our DLL systemwide.
  //loading the driver doesn't do that automatically.
  //args are DriverName (must match createDriver.bat and the driveName above), and the DLL to inject.
  //notice that in createDriver.bat, we told our driver to only inject THIS dll into the system, it can't
  //inject an arbitrary dll.
  result :=   InjectLibraryA(PAnsiChar('HookProcessCreationDriver'),
                             PAnsiChar('HookCreateProcessAPIs.dll'),
                             ALL_SESSIONS, true);
  if result = true then
  begin
      MessageDlg('Driver successfully injected.', mtInformation,      [mbOk], 0);
  end else
  begin
      MessageDlg('Failed to inject driver.', mtInformation,      [mbOk], 0);

  end;
end;

//start the process monitor
procedure StartMonitor();
Begin
  //Creates an IPC queue. This means that our application is now 'checking' the system mailbox for messages.
  //notice that we need to check the proper address, "HookProcessCreateion+CurrentSessionID' is the mailbox which
  //the DLL is configured to deliver to.
  //the other argument is the function to call when a message is received
     InitMonitor();
     if CreateIpcQueue(pchar('HookProcessCreation' + IntToStr(GetCurrentSessionId)), ReceiveIPC) then
     Begin
        // if we create the queue, inject the dll, because we are now ready to listen.
        InjectHookDLL();
     end
     else
     Begin
        MessageDlg('Could not create IPC queue', mtInformation, [mbOk], 0);
     end;
end;

function RemoveHookDLL():Boolean;
Begin
  //this stops the hooking
  result := UninjectLibraryA(PAnsiChar('HookProcessCreationDriver'),
                             PAnsiChar('HookCreateProcessAPIs.dll'),
                             ALL_SESSIONS, true);
  if result = true then
  begin
      MessageDlg('Successfully uninjected the library.', mtInformation,      [mbOk], 0);
  end else
  begin
      MessageDlg('Could not uninject the library.', mtInformation,      [mbOk], 0);
  end;
  //stops injecting the dll
  result := StopInjectionDriver('HookProcessCreationDriver');
  if result=true then
  Begin
      MessageDlg('Driver stopped.', mtInformation,      [mbOk], 0);
  end
  else
  Begin
      MessageDlg('Could not stop driver.', mtInformation,      [mbOk], 0);
  end;
  DestroyIPCQueue(pchar('HookProcessCreation' + IntToStr(GetCurrentSessionId)));
end;

procedure StopMonitor();
Begin
   RemoveHookDLL();
end;
end.
