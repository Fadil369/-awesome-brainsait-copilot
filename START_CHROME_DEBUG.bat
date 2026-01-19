@echo off
REM Batch file to start Chrome with remote debugging enabled
REM This allows Selenium to connect to an existing Chrome session

echo Starting Chrome with Remote Debugging...
echo.

REM Try common Chrome installation paths
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" (
    start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" --remote-debugging-port=9222 --user-data-dir="C:\selenium\chrome-profile"
    echo Chrome started from Program Files
    goto :success
)

if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" (
    start "" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --remote-debugging-port=9222 --user-data-dir="C:\selenium\chrome-profile"
    echo Chrome started from Program Files (x86)
    goto :success
)

REM Check user local installation
if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" (
    start "" "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" --remote-debugging-port=9222 --user-data-dir="C:\selenium\chrome-profile"
    echo Chrome started from LocalAppData
    goto :success
)

echo ERROR: Chrome not found in standard locations!
echo Please install Chrome or update this script with the correct path.
pause
goto :end

:success
echo.
echo Chrome is now running with remote debugging on port 9222
echo You can now run: python bupa_automation.py
echo.
pause

:end
