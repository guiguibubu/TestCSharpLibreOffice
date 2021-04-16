@echo off

SETLOCAL

set PRJ_PATH=%~dp0..

set SCRIPT_PATH=%PRJ_PATH%\scripts

pushd %PRJ_PATH%

call %SCRIPT_PATH%\verifyDevEnv.cmd || goto :errorEnd

:start
call :build || goto :errorEnd

:normalEnd
popd
goto :eof

:errorEnd
popd
exit /b 1

:build
call dotnet build