@echo off
echo ============================================
echo BrainSAIT Copilot Repository Setup
echo ============================================
echo.

cd /d "%~dp0"

echo Step 1: Checking for GitHub CLI...
where gh >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] GitHub CLI found!
    echo.
    echo Checking authentication...
    gh auth status
    if %errorlevel% equ 0 (
        echo [OK] GitHub CLI authenticated!
        goto :create_with_gh
    ) else (
        echo [WARNING] GitHub CLI not authenticated
        echo Please run: gh auth login
        goto :manual_setup
    )
) else (
    echo [INFO] GitHub CLI not found
    goto :manual_setup
)

:create_with_gh
echo.
echo Step 2: Creating repository with GitHub CLI...
gh repo create awesome-brainsait-copilot --public --description "🧠 Awesome list of BrainSAIT Copilot resources for healthcare AI, NPHIES integration, and Saudi healthcare transformation" --source=. --remote=origin
if %errorlevel% equ 0 (
    echo [OK] Repository created successfully!
    goto :init_git
) else (
    echo [ERROR] Failed to create repository
    goto :manual_setup
)

:init_git
echo.
echo Step 3: Initializing local git repository...
git init
if %errorlevel% neq 0 (
    echo [ERROR] Git not found or failed to initialize
    pause
    exit /b 1
)

echo Checking git configuration...
git config user.name >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Git user.name not set
    set /p GIT_NAME="Enter your name: "
    git config --global user.name "%GIT_NAME%"
)

git config user.email >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Git user.email not set
    set /p GIT_EMAIL="Enter your email: "
    git config --global user.email "%GIT_EMAIL%"
)

echo.
echo Step 4: Adding files to git...
git add .
git commit -m "Initial BrainSAIT Copilot Enterprise customization - Healthcare AI agents for Saudi market"
git branch -M main

echo.
echo Step 5: Pushing to GitHub...
git push -u origin main
if %errorlevel% equ 0 (
    echo.
    echo ============================================
    echo [SUCCESS] Repository created and pushed!
    echo ============================================
    echo.
    echo View your repository at:
    gh repo view --web
    echo.
) else (
    echo [ERROR] Failed to push to GitHub
    echo Please check your credentials and try again
)
pause
exit /b 0

:manual_setup
echo.
echo ============================================
echo MANUAL SETUP REQUIRED
echo ============================================
echo.
echo GitHub CLI is not available or not authenticated.
echo.
echo Option 1 - Install GitHub CLI:
echo   1. Download from: https://cli.github.com/
echo   2. Install and run: gh auth login
echo   3. Run this script again
echo.
echo Option 2 - Manual Repository Creation:
echo   1. Go to: https://github.com/new
echo   2. Repository name: awesome-brainsait-copilot
echo   3. Description: 🧠 Awesome list of BrainSAIT Copilot resources for healthcare AI, NPHIES integration, and Saudi healthcare transformation
echo   4. Visibility: Public
echo   5. Do NOT initialize with README
echo   6. Click "Create repository"
echo.
echo Then run these commands:
echo.
echo   cd "%~dp0"
echo   git init
echo   git add .
echo   git commit -m "Initial BrainSAIT Copilot Enterprise customization"
echo   git branch -M main
echo   git remote add origin https://github.com/fadil369/awesome-brainsait-copilot.git
echo   git push -u origin main
echo.
echo ============================================
pause
exit /b 0
