@echo off
setlocal enabledelayedexpansion

:: Use ASCII to avoid encoding issues
set "EXIFTOOL=%~dp0bin\exiftool.exe"
set "RAW_DIR=RAW"
set "OUTPUT_FILE=shutter_info.csv"

echo ---------------------------------------
echo Scanning RAW folder, please wait...
echo ---------------------------------------

:: Use exiftool's built-in progress feature and customized output
:: -progress: shows a progress bar in the terminal
:: -csv: generate CSV structure
:: -filename, -LensID, -FocalLength, -ShutterMode, -ShutterSpeed, -FNumber, -ISO, -VibrationReduction, -FocusMode
:: We use -csv mode here for compatibility with the built-in progress bar

"%EXIFTOOL%" -progress -csv -filename -LensID -FocalLength -ShutterMode -ShutterSpeed -FNumber -ISO -VibrationReduction -FocusMode -ext NEF "%RAW_DIR%" > "%OUTPUT_FILE%.tmp"

:: Post-process to fix ShutterSpeed column to match your specific requirements (Dec + Frac)
:: and order (FileName, Lens, FocalLength, ShutterMode, ShutterSpeedDec, ShutterSpeedFrac, FNumber, ISO, VR, FocusMode)
:: To keep it simple and stable in BAT, we'll use a slightly different approach for the progress:

echo.
echo Finalizing CSV structure...

:: Re-writing the header
echo FileName,Lens,FocalLength,ShutterMode,ShutterSpeedDec,ShutterSpeedFrac,FNumber,ISO,VR,FocusMode > "%OUTPUT_FILE%"

:: Use a second pass to format the data as requested (Dec + Frac)
:: Since there's no easy way to get both # and non-# in one -csv call, we use -p for the final write
:: The progress was shown by the first command.
"%EXIFTOOL%" -q -r -f -p "$Filename,=\"$LensID\",$FocalLength,$ShutterMode,$shutterSpeed#,=\"$ShutterSpeed\",$FNumber,$ISO,$VibrationReduction,$FocusMode" -ext NEF "%RAW_DIR%" >> "%OUTPUT_FILE%"

del "%OUTPUT_FILE%.tmp"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo SUCCESS: Results saved to %OUTPUT_FILE%
) else (
    echo.
    echo ERROR: Processing failed.
)

pause
