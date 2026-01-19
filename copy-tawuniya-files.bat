@echo off
REM Copy essential Tawuniya files to skills repository

echo ====================================================================
echo COPYING TAWUNIYA FILES TO SKILLS REPOSITORY
echo ====================================================================
echo.

cd /d C:\Users\rcmrejection3

echo Copying master_enhanced_system.py...
copy "Taw-Riyd-Sep\master_enhanced_system.py" ".copilot\skills\tawuniya_master_enhanced_system.py"

echo Copying add_smartclaim_page_enhanced.py...
copy "Taw-Riyd-Sep\add_smartclaim_page_enhanced.py" ".copilot\skills\tawuniya_smartclaim_page.py"

echo Copying pdf_design_system.py...
copy "Taw-Riyd-Sep\pdf_design_system.py" ".copilot\skills\tawuniya_pdf_design.py"

echo.
echo ====================================================================
echo FILES COPIED SUCCESSFULLY!
echo ====================================================================
echo.
echo Core Tawuniya processing files are now in the skills folder.
echo.
pause
