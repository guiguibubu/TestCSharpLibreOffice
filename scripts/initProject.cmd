@echo off

SETLOCAL

set PRJ_PATH=%~dp0..

SET TMP_PATH=%PRJ_PATH%\tmp
SET TOOL_PATH=%TMP_PATH%\tools

SET COMPILER_NUGET_ID=Microsoft.Net.Compilers.Toolset
SET COMPILER_NUGET_PATH=%TMP_PATH%\%COMPILER_NUGET_ID%

pushd %PRJ_PATH%

call :cleanPreInstall || goto :errorEnd
call :initNuget || goto :errorEnd
call :initCompiler || goto :errorEnd

:normalEnd
popd
goto :eof

:errorEnd
popd
exit /b 1

:cleanPreInstall
DEL /Q %TOOL_PATH%\nuget.exe
RD /s /q %TOOL_PATH%\compiler
RD /s /q %COMPILER_NUGET_PATH%

:initNuget
curl https://dist.nuget.org/win-x86-commandline/latest/nuget.exe --output %TOOL_PATH%\nuget.exe

:initCompiler
mkdir %TOOL_PATH%\compiler
call %TOOL_PATH%\nuget.exe install %COMPILER_NUGET_ID% -ExcludeVersion -OutputDirectory %TMP_PATH%
ROBOCOPY %COMPILER_NUGET_PATH%\tasks\net472 %TOOL_PATH%\compiler /256 /E
RD /s /q %COMPILER_NUGET_PATH%