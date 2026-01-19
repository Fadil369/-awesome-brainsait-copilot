@echo off
REM Complete automation runner for Bupa batch submission

echo ====================================================================
echo BUPA BATCH STATEMENT AUTOMATION
echo ====================================================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found! Please install Python 3.10 or higher.
    pause
    exit /b 1
)

echo Python found: 
python --version
echo.

REM Check if Selenium is installed
python -c "import selenium" >nul 2>&1
if errorlevel 1 (
    echo Selenium not found. Installing...
    pip install selenium
    echo.
)

echo Ready to run automation!
echo.
echo PREREQUISITES:
echo 1. Chrome must be running with remote debugging (run START_CHROME_DEBUG.bat first)
echo 2. You must be logged into Bupa portal
echo 3. Navigate to the Batch Statement Review page
echo.
echo Press any key to start automation...
pause >nul

echo.
echo Starting automation...
echo.

python bupa_automation.py

echo.
echo ====================================================================
echo Automation completed! Check the log file for details.
echo ====================================================================
pause
