@echo off

SETLOCAL

set PRJ_PATH=%~dp0..

SET SDK_PATH=%PRJ_PATH%\sdk
SET CLI_LIB_LOCATION=%SDK_PATH%\cli

SET OUT_BIN=%PRJ_PATH%\bin

SET TMP_PATH=%PRJ_PATH%\tmp
SET TOOL_PATH=%TMP_PATH%\tools
SET COMPILER_PATH=%TOOL_PATH%\compiler

pushd %PRJ_PATH%

::where make >nul 2>&1 || call :setenv || goto :errorEnd

:start
::call make buildAll || goto :errorEnd
call :build || goto :errorEnd

:normalEnd
popd
goto :eof

:errorEnd
popd
exit /b 1

:setenv
call %SDK_PATH%\setsdkenv_windows.bat

:build

IF NOT EXIST %OUT_BIN% (
    MKDIR %OUT_BIN%
)

SET CSC_FLAGS=-warnaserror+ -noconfig -platform:x64
::ifeq "$(DEBUG)" "yes"
SET CSC_FLAGS=%CSC_FLAGS% -debug+ -checked+ -define:DEBUG -define:TRACE
::else
::CSC_FLAGS += -o
::endif

SET CMD_LINE=%COMPILER_PATH%\csc.exe %CSC_FLAGS% -target:exe -out:%OUT_BIN%\ViewSample.exe -nologo ^
-r:%CLI_LIB_LOCATION%\cli_basetypes.dll ^
-r:%CLI_LIB_LOCATION%\cli_uretypes.dll ^
-r:%CLI_LIB_LOCATION%\cli_oootypes.dll ^
-r:%CLI_LIB_LOCATION%\cli_ure.dll ^
-r:%CLI_LIB_LOCATION%\cli_cppuhelper.dll ^
SpreadsheetDocHelper.cs ^
ViewSample.cs

SET CMD_LINE
call %CMD_LINE%