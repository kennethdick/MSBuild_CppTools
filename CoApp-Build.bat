@echo off
@echo "This script will build a nuget package using CoApp powershell tools"
@echo "CoApp: http://coapp.org/pages/releases.html "
@echo ""
@echo "REQUIRED Environment variables"
@echo "SolutionDir : Relative path to .sln file for batch build"
@echo "Solution : Filename of .sln file for batch build"
@echo "PackageName : Filename of the .AutoPkg file"
@echo ""
SET /P VersionUpdated='Confirm: Did you update the AutoPkg version? THIS IS IMPORTANT(y/n)'
if %VersionUpdated% == y (
REM <# Nuget Restore for Solution #>
cd %SolutionDir%
nuget restore %Solution%
cd..

@echo Bulk Build Project using the BuildAllPlatforms file found in this repo
"C:\Program Files (x86)\MSBuild\12.0\Bin\MSBuild" BuildAllPlatforms.proj /p:Projects="%SolutionDir%\%Solution%"  /p:Configuration="Debug;Release"  /p:Platform="Win32;x64" /p:Targets="Build" /verbosity:quiet  /p:BuildInParallel=true /m 

@echo Execute package build 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Write-NuGetPackage -Package %PackageName%"

) else (
@echo Please update version in %PackageName% to a higher version
call :print_head 5 %PackageName%
)

:print_head
setlocal EnableDelayedExpansion
set /a counter=0

for /f ^"usebackq^ eol^=^

^ delims^=^" %%a in (%2) do (
        if "!counter!"=="%1" goto :eof
        echo %%a
        set /a counter+=1
)

goto :eof










@echo on