@echo off

for /r %%i in (*.coverage) do (
echo %%~ti %%~zi %%i
echo "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Team Tools\Dynamic Code Coverage Tools\codecoverage.exe" analyze /include_skipped_functions /include_skipped_modules /output:"%%~ni.coveragexml" "%%i" >> run.txt
"C:\Program Files (x86)\Microsoft Visual Studio 12.0\Team Tools\Dynamic Code Coverage Tools\codecoverage.exe" analyze /include_skipped_functions /include_skipped_modules /output:"%%~ni.coveragexml" "%%i"

)
cd %WORKSPACE%
md %WORKSPACE%\History
@echo '%WORKSPACE%\tools\windows\coveragereport\ReportGenerator.exe' -reports:'%WORKSPACE%\*.coveragexml' -reporttypes:Html -historydir:%WORKSPACE%\History -targetdir:%WORKSPACE%\CoverageReport\  >> run.txt
"%WORKSPACE%\tools\windows\coveragereport\ReportGenerator.exe" "-reports:%WORKSPACE%\*.coveragexml" "-reporttypes:Html" "-historydir:%WORKSPACE%\History" "-targetdir:%WORKSPACE%\CoverageReport\"
@echo on
exit 0