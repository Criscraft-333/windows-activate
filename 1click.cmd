@echo off
setlocal enabledelayedexpansion

title Activate Windows 10 for FREE&cls
rem Declare values
set values[1]=TX9XD-98N7V-6WMQ6-BX7FG-H8Q99,Home
set values[2]=3KHY7-WNT83-DGQKR-F7HPR-844BM,HomeN
set values[3]=7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH,HomeSingleLanguage
set values[4]=PVMJN-6DFY6-9CCP6-7BKTT-D3WVR,HomeCountrySpecific
set values[5]=W269N-WFGWX-YVC9B-4J6C9-T83GX,Pro
set values[6]=MH37W-N47XK-V7XM9-C7227-GCQG9,ProN
set values[7]=NW6C2-QMPVW-D7KKK-3GKT6-VCFB2,Edu
set values[8]=2WH4N-8QGBV-H22JP-CT43Q-MDWWJ,EduN
set values[9]=NPPR9-FWDCX-D2C8J-H872K-2YT43,Enterp
set values[10]=DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4,EnterpN

echo Available Windows editions:
for /l %%i in (1,1,10) do (
    for /f "tokens=1,* delims=," %%a in ("!values[%%i]!") do echo %%i: %%b
)

:choice
set /p "chosenEdition=Which Windows will you activate? (Warning: choose the edition PC had out of the box.) "
if %chosenEdition% lss 1 goto choice
if %chosenEdition% gtr 10 goto choice

rem Split values using a comma as a delimiter
for /f "tokens=1,2 delims=," %%a in ("!values[%chosenEdition%]!") do (
    set value1=%%a
    set value2=%%b
)

echo Selected edition: %value2%.
echo Installing key %value1%...
:intents
slmgr /ipk %value1%
slmgr /skms kms8.msguides.com
slmgr /ato

if errorlevel 0xC004F074 (
    choice /c YN /m "Server connection failed! Try again? (Y, N)"
    if errorlevel 2 (
        exit /b 0
    ) else if errorlevel 1 (
        goto intents
    )
)

echo "Windows activated successfully (%value2% edition)!"
timeout 2 >nul

endlocal
