@echo off

SETLOCAL

set PRJ_PATH=%~dp0..
SET SDK_PATH=%PRJ_PATH%\sdk

SET OUT_BIN=%PRJ_PATH%\bin

pushd %PRJ_PATH%


::where make >nul 2>&1 || call :setenv || goto :errorEnd

:start
::call make clean || goto :errorEnd
call :clean

:normalEnd
popd
goto :eof

:errorEnd
popd
exit /b 1

:setenv
call %SDK_PATH%\setsdkenv_windows.bat

:clean
if exist %OUT_BIN% (
    rd /S /Q %OUT_BIN%
)