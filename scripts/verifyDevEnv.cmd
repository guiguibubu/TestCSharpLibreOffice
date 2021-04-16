@echo off

SETLOCAL

set PRJ_PATH=%~dp0..
set SCRIPT_PATH=%PRJ_PATH%\scripts

pushd %PRJ_PATH%

where dotnet >nul 2>&1 || echo dotnet is not installed, please run %SCRIPT_PATH%\initProject.cmd || goto :errorEnd

:start
call :verifyVersion || echo dotnet installed version is to old, please run %SCRIPT_PATH%\initProject.cmd || goto :errorEnd

:normalEnd
popd
goto :eof

:errorEnd
popd
exit /b 1

:verifyVersion
for /f "delims=" %%a in ('call dotnet --version') DO (
    echo dotnet installed version is : %%a
    IF %%a LSS 5 (
        exit /b 1
    )
)