@echo off
@echo EXECUTE ALL TESTS
@echo "REQUIRED Environment variables"
@echo "WORKSPACE : Working folder above build output"
@echo "Platform : Win32\x64\ARM"
@echo "Compiler : Debug\Release"
@echo Uses file "%WORKSPACE%\src\CodeCoverage.runsettings" if found

set tests=
setlocal enabledelayedexpansion
for /r %%i in (%WORKSPACE%\%Platform%\%Compiler%\*Tests.exe) do set tests=!tests! !%%i
set tests=!tests:~1!
echo %tests%
echo "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" %tests% /Logger:trx /EnableCodeCoverage  /UseVsixExtensions:true /settings:"%WORKSPACE%\src\CodeCoverage.runsettings >> %WORKSPACE%\run.txt
"C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" %tests% /Logger:trx  /EnableCodeCoverage /UseVsixExtensions:true /settings:"%WORKSPACE%\src\CodeCoverage.runsettings

endlocal
