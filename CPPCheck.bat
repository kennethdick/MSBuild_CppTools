@echo off
@echo "REQUIRED Environment variables"
@echo "WORKSPACE : Relative path to working folder above solution"
@echo "SolutionDir : Solution folder name within workspace"
@echo "CPPEXCLUDE : -i[\Path] -i[\Path] list of paths to exclude seperated by space"
@echo ""
SET CPPEXCLUDE=%~1
@echo CPPCheck Begin

@echo Executing: "C:\Program Files (x86)\Cppcheck\cppcheck.exe" "%WORKSPACE%/%SolutionDir%" -i"%WORKSPACE%/%SolutionDir%/packages" %CPPEXCLUDE% --force --xml-version=2 --enable=all  >> run.txt

"C:\Program Files (x86)\Cppcheck\cppcheck.exe" "%WORKSPACE%/%SolutionDir%" -i"%WORKSPACE%/%SolutionDir%/packages" %CPPEXCLUDE% --force --xml-version=2 --enable=all 2>"%WORKSPACE%\cppcheck-result.xml"

@echo CPPCheck End
