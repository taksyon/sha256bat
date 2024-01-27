@echo off
setlocal EnableDelayedExpansion

echo Enter the file path for SHA256 calculation:
set /p filePath=

:: Remove quotation marks if present
set filePath=!filePath:"=!

:: Calculate SHA256 checksum using certutil and capture the output
certutil -hashfile "!filePath!" SHA256 > temp.txt

:: Extract the checksum, skipping unnecessary lines
for /f "skip=1 delims=" %%a in (temp.txt) do (
    set "checksum1=%%a"
    goto :hashRead
)
:hashRead

:: Trim leading and trailing spaces from checksum1
for /f "tokens=*" %%a in ("!checksum1!") do set checksum1=%%a

:: Remove temp file
del temp.txt

echo Calculated SHA256 checksum: !checksum1!

echo Enter the second checksum to compare:
set /p checksum2=

:: Trim leading and trailing whitespace in checksum2
for /f "tokens=*" %%a in ("!checksum2!") do set checksum2=%%a

:: Compare checksums
if "!checksum1!" == "!checksum2!" (
    echo Checksums match.
) else (
    echo Checksums do not match.
)

endlocal
pause
