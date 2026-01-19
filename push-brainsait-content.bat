@echo off
echo ============================================
echo Adding BrainSAIT Content to Repository
echo ============================================
echo.

cd /d C:\Users\rcmrejection3\.copilot\skills

echo Step 1: Adding all files to git...
git add .
if %errorlevel% neq 0 (
    echo [ERROR] Failed to add files
    pause
    exit /b 1
)
echo [OK] Files added

echo.
echo Step 2: Checking status...
git status
echo.

echo Step 3: Committing changes...
git commit -m "Add complete BrainSAIT Copilot Enterprise customization - Healthcare AI agents and documentation"
if %errorlevel% neq 0 (
    echo [ERROR] Commit failed
    pause
    exit /b 1
)
echo [OK] Changes committed

echo.
echo Step 4: Pushing to GitHub...
git push origin main
if %errorlevel% equ 0 (
    echo.
    echo ============================================
    echo [SUCCESS] All BrainSAIT files pushed!
    echo ============================================
    echo.
    echo View your repository at:
    echo https://github.com/Fadil369/-awesome-brainsait-copilot
    echo.
    echo Files added:
    echo - 8 Healthcare AI Agent files
    echo - Complete documentation
    echo - Setup scripts
    echo - Configuration files
    echo.
) else (
    echo [ERROR] Push failed
    echo Check your internet connection and SSH key
    pause
    exit /b 1
)

echo Step 5: Showing recent commits...
git log --oneline -n 5

echo.
echo ============================================
echo BrainSAIT Repository Setup Complete!
echo ============================================
pause
