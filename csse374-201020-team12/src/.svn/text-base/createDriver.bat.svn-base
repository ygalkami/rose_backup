@echo off
Echo Resetting drivers...
REM Part of this process modifies drivers provided by Madshi (C:\Program Files\madCollection\madCodeHook\Driver)
REM The DoNotModify.sys files are the ORIGINAL drivers. I copy over the modified versions to start fresh.
REM The drivers take the DLL you wrote and inject it into the system.  There is a 32-bit driver and a 64-bit driver. I use the same DLL for each, I'm not sure if this is appropriate, but since I'm not using 64-bit, I don't care.
copy DoNotModify32.sys /B TempusInjectionDriver32.sys /V /Y
copy DoNotModify64.sys /B TempusInjectionDriver64.sys /V /Y



Echo Configuring drivers to inject HookCreateProcessAPIs.dll
REM madConfigDrv is a Madshi tool which configures HIS drivers (a 32-bit one and a 64-bit one). We provide a driver, a "DriverName" (which can be arbitrary, but must match several other places in the code), the DLL to add to the driver, and a stop mode. Allowing unsafe stops means that we can unhook the driver for development. You will probably want to change this later to "safeStopAllowed" (see http://help.madshi.net/mchDrvCfg.htm for details). The entire point of "configuring" the driver is to tell the driver which DLL's it is allowed to inject into the system. (It uses hash, not file name, which is why you have to do this every time you edit the DLL).
madConfigDrv TempusInjectionDriver32.sys HookProcessCreationDriver HookCreateProcessAPIs.dll -unsafeStopAllowed
madConfigDrv TempusInjectionDriver64.sys HookProcessCreationDriver HookCreateProcessAPIs.dll -unsafeStopAllowed

REM Here's the nasty part. Although XP does NOT require drivers to be signed, MadCodeHook DOES. Your driver must be signed (even if the signature is invalid) for MadCodeHook APIs to load the driver (which will allow you to inject the DLL into the system). Although there is no mention of a certificate in the code below, signtool looks in your certicate store for a certificate matching "Tempus Technologies", and uses it to sign the driver. You technically need a Microsoft cross-certificate to make this valid, but since we don't have one, we skip it. It works fine in XP (may complain on some systems), but will NOT work for Vista/7 (at least the 64-bit versions).
signtool sign /v /n "Tempus Technologies" /t http://timestamp.verisign.com/scripts/timestamp.dll /d "HookProcessCreationDriver" /du "www.tempustechnologies.com" TempusInjectionDriver32.sys
signtool sign /v /n "Tempus Technologies" /t http://timestamp.verisign.com/scripts/timestamp.dll /d "HookProcessCreationDriver" /du "www.tempustechnologies.com" TempusInjectionDriver64.sys
pause
