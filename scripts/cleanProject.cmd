@echo off

SETLOCAL

set PRJ_PATH=%~dp0..

set OUT_BIN=%PRJ_PATH%\bin
SET TMP_PATH=%PRJ_PATH%\tmp
set SCRIPT_PATH=%PRJ_PATH%\scripts

pushd %PRJ_PATH%

call %SCRIPT_PATH%\verifyDevEnv.cmd || goto :errorEnd

:start
call :clean || goto :errorEnd

:normalEnd
popd
goto :eof

:errorEnd
popd
exit /b 1

:clean
if exist %OUT_BIN% (
    RD /S /Q %OUT_BIN%
)
if exist %TMP_PATH% (
    RD /S /Q %TMP_PATH%
)
call dotnet clean --nologo -v m