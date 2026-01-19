@echo off
echo ============================================
echo GitHub SSH Setup for BrainSAIT
echo ============================================
echo.

REM Check if .ssh directory exists
if not exist "%USERPROFILE%\.ssh" (
    echo Creating .ssh directory...
    mkdir "%USERPROFILE%\.ssh"
)

REM Check if SSH key exists
if exist "%USERPROFILE%\.ssh\id_rsa.pub" (
    echo [OK] SSH key already exists
    goto :setup_config
) else if exist "%USERPROFILE%\.ssh\id_ed25519.pub" (
    echo [OK] SSH key already exists
    goto :setup_config
) else (
    echo No SSH key found. Generating new SSH key...
    echo.
    set /p EMAIL="Enter your GitHub email: "
    ssh-keygen -t ed25519 -C "%EMAIL%" -f "%USERPROFILE%\.ssh\id_ed25519" -N ""
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to generate SSH key
        pause
        exit /b 1
    )
    echo.
    echo [OK] SSH key generated successfully!
)

:setup_config
echo.
echo Setting up SSH config...
(
echo Host github.com
echo     HostName github.com
echo     User git
echo     IdentityFile ~/.ssh/id_ed25519
echo     IdentitiesOnly yes
) > "%USERPROFILE%\.ssh\config"

echo [OK] SSH config created at: %USERPROFILE%\.ssh\config
echo.

REM Display public key
echo ============================================
echo Your SSH Public Key:
echo ============================================
echo.
if exist "%USERPROFILE%\.ssh\id_ed25519.pub" (
    type "%USERPROFILE%\.ssh\id_ed25519.pub"
) else if exist "%USERPROFILE%\.ssh\id_rsa.pub" (
    type "%USERPROFILE%\.ssh\id_rsa.pub"
)
echo.
echo ============================================
echo.

echo IMPORTANT: Add this key to GitHub
echo 1. Copy the key above
echo 2. Go to: https://github.com/settings/ssh/new
echo 3. Paste the key and give it a title
echo 4. Click "Add SSH key"
echo.
set /p CONTINUE="Press Enter after adding the key to GitHub..."

echo.
echo Testing SSH connection to GitHub...
ssh -T git@github.com
echo.

echo ============================================
echo SSH setup complete!
echo ============================================
pause
