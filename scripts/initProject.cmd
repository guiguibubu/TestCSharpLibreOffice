@echo off

SETLOCAL

set PRJ_PATH=%~dp0..

SET TMP_PATH=%PRJ_PATH%\tmp
set SCRIPT_PATH=%PRJ_PATH%\scripts

set DOTNET_URL="https://download.visualstudio.microsoft.com/download/pr/2de622da-5342-48ec-b997-8b025d8ee478/5c11b643ea7534f749cd3f0e0302715a/dotnet-sdk-5.0.202-win-x64.exe"
set DOTNET_INSTALLER=dotnet-install.exe
set DOTNET_INSTALLER_PATH=%TMP_PATH%\%DOTNET_INSTALLER%

set NETFRAMEWORK_URL="https://download.visualstudio.microsoft.com/download/pr/014120d7-d689-4305-befd-3cb711108212/0307177e14752e359fde5423ab583e43/ndp48-devpack-enu.exe"
set NETFRAMEWORK_INSTALLER=netframework-install.exe
set NETFRAMEWORK_INSTALLER_PATH=%TMP_PATH%\%NETFRAMEWORK_INSTALLER%

set NETFRAMEWORK_FRA_URL="https://download.visualstudio.microsoft.com/download/pr/7afca223-55d2-470a-8edc-6a1739ae3252/dd09d40de54c0bbd3b27ba25fe08d822/ndp48-devpack-fra.exe"
set NETFRAMEWORK_FRA_INSTALLER=netframework-fra-install.exe
set NETFRAMEWORK_FRA_INSTALLER_PATH=%TMP_PATH%\%NETFRAMEWORK_FRA_INSTALLER%

pushd %PRJ_PATH%

IF [%1] == [--force] (
    SET FORCE_INIT=true
)

call %SCRIPT_PATH%\verifyDevEnv.cmd || goto :start

IF DEFINED FORCE_INIT (
    IF "%FORCE_INIT%"=="true" (
        goto :start 
    )
)

echo Dev Environment already set up. Use --force to force the set-up
goto :normalEnd

:start
call :cleanPreInstall || goto :errorEnd
call :initDotNet || goto :errorEnd

:normalEnd
popd
goto :eof

:errorEnd
popd
exit /b 1

:cleanPreInstall
IF EXIST %DOTNET_INSTALLER_PATH% (
    DEL /Q %DOTNET_INSTALLER_PATH%
)
IF EXIST %NETFRAMEWORK_INSTALLER_PATH% (
    DEL /Q %NETFRAMEWORK_INSTALLER_PATH%
)
IF EXIST %NETFRAMEWORK_FRA_INSTALLER_PATH% (
    DEL /Q %NETFRAMEWORK_FRA_INSTALLER_PATH%
)
exit /b %ERRORLEVEL%

:initDotNet
IF NOT EXIST %TMP_PATH% (
    MKDIR %TMP_PATH%
)
echo.
echo Download from %DOTNET_URL%
echo Output to %DOTNET_INSTALLER_PATH%
echo call curl %DOTNET_URL% --output %DOTNET_INSTALLER_PATH%
call curl %DOTNET_URL% --output %DOTNET_INSTALLER_PATH%

echo.
echo Download from %NETFRAMEWORK_URL%
echo Output to %NETFRAMEWORK_INSTALLER_PATH%
echo call curl %NETFRAMEWORK_URL% --output %NETFRAMEWORK_INSTALLER_PATH%
call curl %NETFRAMEWORK_URL% --output %NETFRAMEWORK_INSTALLER_PATH%

echo.
echo Download from %NETFRAMEWORK_FRA_URL%
echo Output to %NETFRAMEWORK_FRA_INSTALLER_PATH%
echo call curl %NETFRAMEWORK_FRA_URL% --output %NETFRAMEWORK_FRA_INSTALLER_PATH%
call curl %NETFRAMEWORK_FRA_URL% --output %NETFRAMEWORK_FRA_INSTALLER_PATH%

echo.
echo Launch %DOTNET_INSTALLER_PATH%
call %DOTNET_INSTALLER_PATH%
echo.
echo Launch %NETFRAMEWORK_INSTALLER_PATH%
call %NETFRAMEWORK_INSTALLER_PATH%
echo.
echo Launch %NETFRAMEWORK_FRA_INSTALLER_PATH%
call %NETFRAMEWORK_FRA_INSTALLER_PATH%

exit /b %ERRORLEVEL%