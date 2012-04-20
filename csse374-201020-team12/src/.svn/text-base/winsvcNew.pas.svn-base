
{*******************************************************}
{                                                       }
{       Delphi Run-time Library                         }
{       Windows 32bit API Interface Unit                }
{                                                       }
{       Copyright (c) 1996,97 Borland International     }
{                                                       }
{*******************************************************}

unit winsvcNew;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses Windows;

//
// Constants
//

const

//
// Service database names
//
  SERVICES_ACTIVE_DATABASEA     = 'ServicesActive';
  SERVICES_ACTIVE_DATABASEW     = 'ServicesActive';
  SERVICES_ACTIVE_DATABASE = SERVICES_ACTIVE_DATABASEA;
  SERVICES_FAILED_DATABASEA     = 'ServicesFailed';
  SERVICES_FAILED_DATABASEW     = 'ServicesFailed';
  SERVICES_FAILED_DATABASE = SERVICES_FAILED_DATABASEA;

//
// Character to designate that a name is a group
//
  SC_GROUP_IDENTIFIERA          = '+';
  SC_GROUP_IDENTIFIERW          = '+';
  SC_GROUP_IDENTIFIER = SC_GROUP_IDENTIFIERA;

//
// Value to indicate no change to an optional parameter
//
  SERVICE_NO_CHANGE              = $FFFFFFFF;

//
// Service State -- for Enum Requests (Bit Mask)
//
  SERVICE_ACTIVE                 = $00000001;
  SERVICE_INACTIVE               = $00000002;
  SERVICE_STATE_ALL              = (SERVICE_ACTIVE   or
                                    SERVICE_INACTIVE);

//
// Controls
//
  SERVICE_CONTROL_STOP           = $00000001;
  SERVICE_CONTROL_PAUSE          = $00000002;
  SERVICE_CONTROL_CONTINUE       = $00000003;
  SERVICE_CONTROL_INTERROGATE    = $00000004;
  SERVICE_CONTROL_SHUTDOWN       = $00000005;

//
// Service State -- for CurrentState
//
  SERVICE_STOPPED                = $00000001;
  SERVICE_START_PENDING          = $00000002;
  SERVICE_STOP_PENDING           = $00000003;
  SERVICE_RUNNING                = $00000004;
  SERVICE_CONTINUE_PENDING       = $00000005;
  SERVICE_PAUSE_PENDING          = $00000006;
  SERVICE_PAUSED                 = $00000007;

//
// Controls Accepted  (Bit Mask)
//
  SERVICE_ACCEPT_STOP            = $00000001;
  SERVICE_ACCEPT_PAUSE_CONTINUE  = $00000002;
  SERVICE_ACCEPT_SHUTDOWN        = $00000004;

//
// Service Control Manager object specific access types
//
  SC_MANAGER_CONNECT             = $0001;
  SC_MANAGER_CREATE_SERVICE      = $0002;
  SC_MANAGER_ENUMERATE_SERVICE   = $0004;
  SC_MANAGER_LOCK                = $0008;
  SC_MANAGER_QUERY_LOCK_STATUS   = $0010;
  SC_MANAGER_MODIFY_BOOT_CONFIG  = $0020;

  SC_MANAGER_ALL_ACCESS          = (STANDARD_RIGHTS_REQUIRED or
                                    SC_MANAGER_CONNECT or
                                    SC_MANAGER_CREATE_SERVICE or
                                    SC_MANAGER_ENUMERATE_SERVICE or
                                    SC_MANAGER_LOCK or
                                    SC_MANAGER_QUERY_LOCK_STATUS or
                                    SC_MANAGER_MODIFY_BOOT_CONFIG);

//
// Service object specific access type
//
  SERVICE_QUERY_CONFIG           = $0001;
  SERVICE_CHANGE_CONFIG          = $0002;
  SERVICE_QUERY_STATUS           = $0004;
  SERVICE_ENUMERATE_DEPENDENTS   = $0008;
  SERVICE_START                  = $0010;
  SERVICE_STOP                   = $0020;
  SERVICE_PAUSE_CONTINUE         = $0040;
  SERVICE_INTERROGATE            = $0080;
  SERVICE_USER_DEFINED_CONTROL   = $0100;

  SERVICE_ALL_ACCESS             = (STANDARD_RIGHTS_REQUIRED or
                                    SERVICE_QUERY_CONFIG or
                                    SERVICE_CHANGE_CONFIG or
                                    SERVICE_QUERY_STATUS or
                                    SERVICE_ENUMERATE_DEPENDENTS or
                                    SERVICE_START or
                                    SERVICE_STOP or
                                    SERVICE_PAUSE_CONTINUE or
                                    SERVICE_INTERROGATE or
                                    SERVICE_USER_DEFINED_CONTROL);


type

//
// Handle Types
//

  SC_HANDLE = THandle;
  LPSC_HANDLE = ^SC_HANDLE;

  SERVICE_STATUS_HANDLE = DWORD;

//
// pointer to string pointer
//

  PLPSTRA = ^PAnsiChar;
  PLPSTRW = ^PWideChar;
  PLPSTR = PLPSTRA;

//
// Service Status Structure
//

  PServiceStatus = ^TServiceStatus;
  TServiceStatus = record
    dwServiceType: DWORD;
    dwCurrentState: DWORD;
    dwControlsAccepted: DWORD;
    dwWin32ExitCode: DWORD;
    dwServiceSpecificExitCode: DWORD;
    dwCheckPoint: DWORD;
    dwWaitHint: DWORD;
  end;

//
// Service Status Enumeration Structure
//
  PEnumServiceStatusA = ^TEnumServiceStatusA;
  PEnumServiceStatusW = ^TEnumServiceStatusW;
  PEnumServiceStatus = PEnumServiceStatusA;
  TEnumServiceStatusA = record
    lpServiceName: PAnsiChar;
    lpDisplayName: PAnsiChar;
    ServiceStatus: TServiceStatus;
  end;
  TEnumServiceStatusW = record
    lpServiceName: PWideChar;
    lpDisplayName: PWideChar;
    ServiceStatus: TServiceStatus;
  end;
  TEnumServiceStatus = TEnumServiceStatusA;

//
// Structures for the Lock API functions
//
  SC_LOCK = Pointer;
  PQueryServiceLockStatusA = ^TQueryServiceLockStatusA;
  PQueryServiceLockStatusW = ^TQueryServiceLockStatusW;
  PQueryServiceLockStatus = PQueryServiceLockStatusA;
  TQueryServiceLockStatusA = record
    fIsLocked: DWORD;
    lpLockOwner: PAnsiChar;
    dwLockDuration: DWORD;
  end;
  TQueryServiceLockStatusW = record
    fIsLocked: DWORD;
    lpLockOwner: PWideChar;
    dwLockDuration: DWORD;
  end;
  TQueryServiceLockStatus = TQueryServiceLockStatusA;

//
// Query Service Configuration Structure
//
  PQueryServiceConfigA = ^TQueryServiceConfigA;
  PQueryServiceConfigW = ^TQueryServiceConfigW;
  PQueryServiceConfig = PQueryServiceConfigA;
  TQueryServiceConfigA = record
    dwServiceType: DWORD;
    dwStartType: DWORD;
    dwErrorControl: DWORD;
    lpBinaryPathName: PAnsiChar;
    lpLoadOrderGroup: PAnsiChar;
    dwTagId: DWORD;
    lpDependencies: PAnsiChar;
    lpServiceStartName: PAnsiChar;
    lpDisplayName: PAnsiChar;
  end;
  TQueryServiceConfigW = record
    dwServiceType: DWORD;
    dwStartType: DWORD;
    dwErrorControl: DWORD;
    lpBinaryPathName: PWideChar;
    lpLoadOrderGroup: PWideChar;
    dwTagId: DWORD;
    lpDependencies: PWideChar;
    lpServiceStartName: PWideChar;
    lpDisplayName: PWideChar;
  end;
  TQueryServiceConfig = TQueryServiceConfigA;

//
// Function Prototype for the Service Main Function
//

  TServiceMainFunctionA = TFarProc;
  TServiceMainFunctionW = TFarProc;
  TServiceMainFunction = TServiceMainFunctionA;

//
// Service Start Table
//
  PServiceTableEntryA = ^TServiceTableEntryA;
  PServiceTableEntryW = ^TServiceTableEntryW;
  PServiceTableEntry = PServiceTableEntryA;
  TServiceTableEntryA = record
    lpServiceName: PAnsiChar;
    lpServiceProc: TServiceMainFunctionA;
  end;
  TServiceTableEntryW = record
    lpServiceName: PWideChar;
    lpServiceProc: TServiceMainFunctionW;
  end;
  TServiceTableEntry = TServiceTableEntryA;

//
// Prototype for the Service Control Handler Function
//

  THandlerFunction = TFarProc;

///////////////////////////////////////////////////////////////////////////
// API Function Prototypes
///////////////////////////////////////////////////////////////////////////

function ChangeServiceConfigA(hService: SC_HANDLE; dwServiceType, dwStartType,
  dwErrorControl: DWORD; lpBinaryPathName, lpLoadOrderGroup: PAnsiChar;
  lpdwTagId: LPDWORD; lpDependencies, lpServiceStartName, lpPassword,
  lpDisplayName: PAnsiChar): BOOL; stdcall;
function ChangeServiceConfigW(hService: SC_HANDLE; dwServiceType, dwStartType,
  dwErrorControl: DWORD; lpBinaryPathName, lpLoadOrderGroup: PWideChar;
  lpdwTagId: LPDWORD; lpDependencies, lpServiceStartName, lpPassword,
  lpDisplayName: PWideChar): BOOL; stdcall;
function ChangeServiceConfig(hService: SC_HANDLE; dwServiceType, dwStartType,
  dwErrorControl: DWORD; lpBinaryPathName, lpLoadOrderGroup: PChar;
  lpdwTagId: LPDWORD; lpDependencies, lpServiceStartName, lpPassword,
  lpDisplayName: PChar): BOOL; stdcall;
function CloseServiceHandle(hSCObject: SC_HANDLE): BOOL; stdcall;
function ControlService(hService: SC_HANDLE; dwControl: DWORD;
  var lpServiceStatus: TServiceStatus): BOOL; stdcall;
function CreateServiceA(hSCManager: SC_HANDLE; lpServiceName, lpDisplayName: PAnsiChar;
  dwDesiredAccess, dwServiceType, dwStartType, dwErrorControl: DWORD;
  lpBinaryPathName, lpLoadOrderGroup: PAnsiChar; lpdwTagId: LPDWORD; lpDependencies,
  lpServiceStartName, lpPassword: PAnsiChar): SC_HANDLE; stdcall;
function CreateServiceW(hSCManager: SC_HANDLE; lpServiceName, lpDisplayName: PWideChar;
  dwDesiredAccess, dwServiceType, dwStartType, dwErrorControl: DWORD;
  lpBinaryPathName, lpLoadOrderGroup: PWideChar; lpdwTagId: LPDWORD; lpDependencies,
  lpServiceStartName, lpPassword: PWideChar): SC_HANDLE; stdcall;
function CreateService(hSCManager: SC_HANDLE; lpServiceName, lpDisplayName: PChar;
  dwDesiredAccess, dwServiceType, dwStartType, dwErrorControl: DWORD;
  lpBinaryPathName, lpLoadOrderGroup: PChar; lpdwTagId: LPDWORD; lpDependencies,
  lpServiceStartName, lpPassword: PChar): SC_HANDLE; stdcall;
function DeleteService(hService: SC_HANDLE): BOOL; stdcall;
function EnumDependentServicesA(hService: SC_HANDLE; dwServiceState: DWORD;
  var lpServices: TEnumServiceStatusA; cbBufSize: DWORD; var pcbBytesNeeded,
  lpServicesReturned : DWORD): BOOL; stdcall;
function EnumDependentServicesW(hService: SC_HANDLE; dwServiceState: DWORD;
  var lpServices: TEnumServiceStatusW; cbBufSize: DWORD; var pcbBytesNeeded,
  lpServicesReturned : DWORD): BOOL; stdcall;
function EnumDependentServices(hService: SC_HANDLE; dwServiceState: DWORD;
  var lpServices: TEnumServiceStatus; cbBufSize: DWORD; var pcbBytesNeeded,
  lpServicesReturned : DWORD): BOOL; stdcall;
function EnumServicesStatusA(hSCManager: SC_HANDLE; dwServiceType,
  dwServiceState: DWORD; var lpServices: TEnumServiceStatusA; cbBufSize: DWORD;
  var pcbBytesNeeded, lpServicesReturned, lpResumeHandle: DWORD): BOOL; stdcall;
function EnumServicesStatusW(hSCManager: SC_HANDLE; dwServiceType,
  dwServiceState: DWORD; var lpServices: TEnumServiceStatusW; cbBufSize: DWORD;
  var pcbBytesNeeded, lpServicesReturned, lpResumeHandle: DWORD): BOOL; stdcall;
function EnumServicesStatus(hSCManager: SC_HANDLE; dwServiceType,
  dwServiceState: DWORD; var lpServices: TEnumServiceStatus; cbBufSize: DWORD;
  var pcbBytesNeeded, lpServicesReturned, lpResumeHandle: DWORD): BOOL; stdcall;
function GetServiceKeyNameA(hSCManager: SC_HANDLE; lpDisplayName,
  lpServiceName: PAnsiChar; var lpcchBuffer: DWORD): BOOL; stdcall;
function GetServiceKeyNameW(hSCManager: SC_HANDLE; lpDisplayName,
  lpServiceName: PWideChar; var lpcchBuffer: DWORD): BOOL; stdcall;
function GetServiceKeyName(hSCManager: SC_HANDLE; lpDisplayName,
  lpServiceName: PChar; var lpcchBuffer: DWORD): BOOL; stdcall;
function GetServiceDisplayNameA(hSCManager: SC_HANDLE; lpServiceName,
  lpDisplayName: PAnsiChar; var lpcchBuffer: DWORD): BOOL; stdcall;
function GetServiceDisplayNameW(hSCManager: SC_HANDLE; lpServiceName,
  lpDisplayName: PWideChar; var lpcchBuffer: DWORD): BOOL; stdcall;
function GetServiceDisplayName(hSCManager: SC_HANDLE; lpServiceName,
  lpDisplayName: PChar; var lpcchBuffer: DWORD): BOOL; stdcall;
function LockServiceDatabase(hSCManager: SC_HANDLE): SC_LOCK; stdcall;
function NotifyBootConfigStatus(BootAcceptable: BOOL): BOOL; stdcall;
function OpenSCManagerA(lpMachineName, lpDatabaseName: PAnsiChar;
  dwDesiredAccess: DWORD): SC_HANDLE; stdcall;
function OpenSCManagerW(lpMachineName, lpDatabaseName: PWideChar;
  dwDesiredAccess: DWORD): SC_HANDLE; stdcall;
function OpenSCManager(lpMachineName, lpDatabaseName: PChar;
  dwDesiredAccess: DWORD): SC_HANDLE; stdcall;
function OpenServiceA(hSCManager: SC_HANDLE; lpServiceName: PAnsiChar;
  dwDesiredAccess: DWORD): SC_HANDLE; stdcall;
function OpenServiceW(hSCManager: SC_HANDLE; lpServiceName: PWideChar;
  dwDesiredAccess: DWORD): SC_HANDLE; stdcall;
function OpenService(hSCManager: SC_HANDLE; lpServiceName: PChar;
  dwDesiredAccess: DWORD): SC_HANDLE; stdcall;
function QueryServiceConfigA(hService: SC_HANDLE;
  var lpServiceConfig: TQueryServiceConfigA; cbBufSize: DWORD;
  var pcbBytesNeeded: DWORD): BOOL; stdcall;
function QueryServiceConfigW(hService: SC_HANDLE;
  var lpServiceConfig: TQueryServiceConfigW; cbBufSize: DWORD;
  var pcbBytesNeeded: DWORD): BOOL; stdcall;
function QueryServiceConfig(hService: SC_HANDLE;
  var lpServiceConfig: TQueryServiceConfig; cbBufSize: DWORD;
  var pcbBytesNeeded: DWORD): BOOL; stdcall;
function QueryServiceLockStatusA(hSCManager: SC_HANDLE;
  var lpLockStatus: TQueryServiceLockStatusA; cbBufSize: DWORD;
  var pcbBytesNeeded: DWORD): BOOL; stdcall;
function QueryServiceLockStatusW(hSCManager: SC_HANDLE;
  var lpLockStatus: TQueryServiceLockStatusW; cbBufSize: DWORD;
  var pcbBytesNeeded: DWORD): BOOL; stdcall;
function QueryServiceLockStatus(hSCManager: SC_HANDLE;
  var lpLockStatus: TQueryServiceLockStatus; cbBufSize: DWORD;
  var pcbBytesNeeded: DWORD): BOOL; stdcall;
function QueryServiceObjectSecurity(hService: SC_HANDLE;
  dwSecurityInformation: SECURITY_INFORMATION;
  lpSecurityDescriptor: PSECURITY_DESCRIPTOR; cbBufSize: DWORD;
  var pcbBytesNeeded: DWORD): BOOL; stdcall;
function QueryServiceStatus(hService: SC_HANDLE; var
  lpServiceStatus: TServiceStatus): BOOL; stdcall;
function RegisterServiceCtrlHandlerA(lpServiceName: PAnsiChar;
  lpHandlerProc: ThandlerFunction): SERVICE_STATUS_HANDLE; stdcall;
function RegisterServiceCtrlHandlerW(lpServiceName: PWideChar;
  lpHandlerProc: ThandlerFunction): SERVICE_STATUS_HANDLE; stdcall;
function RegisterServiceCtrlHandler(lpServiceName: PChar;
  lpHandlerProc: ThandlerFunction): SERVICE_STATUS_HANDLE; stdcall;
function SetServiceObjectSecurity(hService: SC_HANDLE;
  dwSecurityInformation: SECURITY_INFORMATION;
  lpSecurityDescriptor: PSECURITY_DESCRIPTOR): BOOL; stdcall;
function SetServiceStatus(hServiceStatus: SERVICE_STATUS_HANDLE;
  var lpServiceStatus: TServiceStatus): BOOL; stdcall;
function StartServiceCtrlDispatcherA(
  var lpServiceStartTable: TServiceTableEntryA): BOOL; stdcall;
function StartServiceCtrlDispatcherW(
  var lpServiceStartTable: TServiceTableEntryW): BOOL; stdcall;
function StartServiceCtrlDispatcher(
  var lpServiceStartTable: TServiceTableEntry): BOOL; stdcall;
function StartServiceA(hService: SC_HANDLE; dwNumServiceArgs: DWORD;
  var lpServiceArgVectors: PAnsiChar): BOOL; stdcall;
function StartServiceW(hService: SC_HANDLE; dwNumServiceArgs: DWORD;
  var lpServiceArgVectors: PWideChar): BOOL; stdcall;
function StartService(hService: SC_HANDLE; dwNumServiceArgs: DWORD;
  var lpServiceArgVectors: PChar): BOOL; stdcall;
function UnlockServiceDatabase(ScLock: SC_LOCK): BOOL; stdcall;

implementation

const
  advapi32 = 'advapi32.dll';

function ChangeServiceConfigA;   external advapi32 name 'ChangeServiceConfigA';
function ChangeServiceConfigW;   external advapi32 name 'ChangeServiceConfigW';
function ChangeServiceConfig;   external advapi32 name 'ChangeServiceConfigA';
function CloseServiceHandle;       external advapi32 name 'CloseServiceHandle';
function ControlService;           external advapi32 name 'ControlService';
function CreateServiceA;         external advapi32 name 'CreateServiceA';
function CreateServiceW;         external advapi32 name 'CreateServiceW';
function CreateService;         external advapi32 name 'CreateServiceA';
function DeleteService;            external advapi32 name 'DeleteService';
function EnumDependentServicesA; external advapi32 name 'EnumDependentServicesA';
function EnumDependentServicesW; external advapi32 name 'EnumDependentServicesW';
function EnumDependentServices; external advapi32 name 'EnumDependentServicesA';
function EnumServicesStatusA;    external advapi32 name 'EnumServicesStatusA';
function EnumServicesStatusW;    external advapi32 name 'EnumServicesStatusW';
function EnumServicesStatus;    external advapi32 name 'EnumServicesStatusA';
function GetServiceKeyNameA;     external advapi32 name 'GetServiceKeyNameA';
function GetServiceKeyNameW;     external advapi32 name 'GetServiceKeyNameW';
function GetServiceKeyName;     external advapi32 name 'GetServiceKeyNameA';
function GetServiceDisplayNameA; external advapi32 name 'GetServiceDisplayNameA';
function GetServiceDisplayNameW; external advapi32 name 'GetServiceDisplayNameW';
function GetServiceDisplayName; external advapi32 name 'GetServiceDisplayNameA';
function LockServiceDatabase;      external advapi32 name 'LockServiceDatabase';
function NotifyBootConfigStatus;   external advapi32 name 'NotifyBootConfigStatus';
function OpenSCManagerA;         external advapi32 name 'OpenSCManagerA';
function OpenSCManagerW;         external advapi32 name 'OpenSCManagerW';
function OpenSCManager;         external advapi32 name 'OpenSCManagerA';
function OpenServiceA;           external advapi32 name 'OpenServiceA';
function OpenServiceW;           external advapi32 name 'OpenServiceW';
function OpenService;           external advapi32 name 'OpenServiceA';
function QueryServiceConfigA;    external advapi32 name 'QueryServiceConfigA';
function QueryServiceConfigW;    external advapi32 name 'QueryServiceConfigW';
function QueryServiceConfig;    external advapi32 name 'QueryServiceConfigA';
function QueryServiceLockStatusA;external advapi32 name 'QueryServiceLockStatusA';
function QueryServiceLockStatusW;external advapi32 name 'QueryServiceLockStatusW';
function QueryServiceLockStatus;external advapi32 name 'QueryServiceLockStatusA';
function QueryServiceObjectSecurity;external advapi32 name 'QueryServiceObjectSecurity';
function QueryServiceStatus;       external advapi32 name 'QueryServiceStatus';
function RegisterServiceCtrlHandlerA;external advapi32 name 'RegisterServiceCtrlHandlerA';
function RegisterServiceCtrlHandlerW;external advapi32 name 'RegisterServiceCtrlHandlerW';
function RegisterServiceCtrlHandler;external advapi32 name 'RegisterServiceCtrlHandlerA';
function SetServiceObjectSecurity; external advapi32 name 'SetServiceObjectSecurity';
function SetServiceStatus;         external advapi32 name 'SetServiceStatus';
function StartServiceCtrlDispatcherA;external advapi32 name 'StartServiceCtrlDispatcherA';
function StartServiceCtrlDispatcherW;external advapi32 name 'StartServiceCtrlDispatcherW';
function StartServiceCtrlDispatcher;external advapi32 name 'StartServiceCtrlDispatcherA';
function StartServiceA;          external advapi32 name 'StartServiceA';
function StartServiceW;          external advapi32 name 'StartServiceW';
function StartService;          external advapi32 name 'StartServiceA';
function UnlockServiceDatabase;    external advapi32 name 'UnlockServiceDatabase';

end.

