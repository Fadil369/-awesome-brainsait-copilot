@echo off
echo ============================================
echo BrainSAIT Repository Initialization
echo ============================================
echo.

cd /d C:\Users\rcmrejection3\.copilot\skills

REM Create README.md with echo command as specified
echo # -awesome-brainsait-copilot >> README.md
echo [OK] README.md created

REM Initialize git
echo.
echo Initializing git repository...
git init
if %errorlevel% neq 0 (
    echo [ERROR] Git initialization failed
    pause
    exit /b 1
)

REM Add README
echo Adding README.md...
git add README.md
if %errorlevel% neq 0 (
    echo [ERROR] Failed to add README.md
    pause
    exit /b 1
)

REM Commit
echo Committing changes...
git commit -m "first commit"
if %errorlevel% neq 0 (
    echo [ERROR] Commit failed
    pause
    exit /b 1
)

REM Rename branch to main
echo Renaming branch to main...
git branch -M main
if %errorlevel% neq 0 (
    echo [ERROR] Failed to rename branch
    pause
    exit /b 1
)

REM Add remote
echo Adding remote origin...
git remote add origin git@github.com:Fadil369/-awesome-brainsait-copilot.git
if %errorlevel% neq 0 (
    echo [WARNING] Remote may already exist or SSH not configured
    echo Trying to set remote URL...
    git remote set-url origin git@github.com:Fadil369/-awesome-brainsait-copilot.git
)

REM Push to main
echo.
echo Pushing to GitHub...
git push -u origin main
if %errorlevel% equ 0 (
    echo.
    echo ============================================
    echo [SUCCESS] Repository pushed to GitHub!
    echo ============================================
    echo.
    echo View at: https://github.com/Fadil369/-awesome-brainsait-copilot
    echo.
) else (
    echo.
    echo [ERROR] Push failed. Common issues:
    echo 1. SSH key not added to GitHub
    echo 2. Repository doesn't exist on GitHub
    echo 3. Network issues
    echo.
    echo Please ensure:
    echo - You created the repository: https://github.com/new
    echo - Repository name: -awesome-brainsait-copilot
    echo - SSH key is added: https://github.com/settings/keys
    echo.
)

pause
