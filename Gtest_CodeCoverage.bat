@echo off
@echo Execute GTest

@echo cd "%WORKSPACE%\bin\%Platform%\%Compiler%\"
cd "%WORKSPACE%\bin\%Platform%\%Compiler%\"

for %%f in (*tests.exe) do (
	    echo start %%~nf.exe --gtest_output=xml:"\testresults\%%~nf_gtest.xml
            start %%~nf.exe --gtest_output=xml:"\testresults\%%~nf_gtest.xml
            "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Team Tools\Dynamic Code Coverage Tools\CodeCoverage.exe" collect /output:%%~nf.coverage "%%~nf.exe"
            "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Team Tools\Dynamic Code Coverage Tools\CodeCoverage.exe" analyze /output:%%~nf.coveragexml %%~nf.coverage
    )
@echo Finished GTest
@echo on