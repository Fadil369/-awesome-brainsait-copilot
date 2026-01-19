# Bupa Batch Statement Automation Tool

## Overview
Automated tool for submitting multiple claim entries to the Bupa Provider Portal. This tool eliminates manual data entry by automatically filling forms, uploading PDF files, and submitting entries in batch.

## Features
✅ Automated form filling  
✅ Programmatic file upload  
✅ Session persistence (maintains login)  
✅ Error handling and retry logic  
✅ Detailed logging and progress tracking  
✅ Reusable for future batches  

## Requirements
- **Python 3.10** or higher
- **Selenium library** (`pip install selenium`)
- **Google Chrome browser**
- **PDF files** in the specified directory

## Installation

### Step 1: Install Selenium
```bash
pip install selenium
```

### Step 2: Verify Installation
```bash
python -c "import selenium; print(selenium.__version__)"
```

## Usage Instructions

### Quick Start (Windows)

#### Method 1: Using Batch Files (Easiest)

1. **Start Chrome with Debugging**
   ```cmd
   START_CHROME_DEBUG.bat
   ```
   This opens Chrome with remote debugging enabled.

2. **Log into Bupa Portal**
   - Navigate to the Bupa provider portal
   - Log in with your credentials
   - Go to the Batch Statement Review page

3. **Run the Automation**
   ```cmd
   RUN_BUPA_AUTOMATION.bat
   ```
   The script will process all remaining entries automatically.

#### Method 2: Manual Execution

1. **Start Chrome with Remote Debugging**
   ```cmd
   "C:\Program Files\Google\Chrome\Application\chrome.exe" --remote-debugging-port=9222 --user-data-dir="C:\selenium\chrome-profile"
   ```

2. **Navigate to Bupa Portal**
   - Open the Bupa provider portal in Chrome
   - Log in and navigate to Batch Statement Review page

3. **Run Python Script**
   ```bash
   cd C:\Users\rcmrejection3\.copilot\skills
   python bupa_automation.py
   ```

## File Structure

```
C:\Users\rcmrejection3\
├── .copilot\skills\
│   ├── bupa_automation.py              # Main automation script
│   ├── START_CHROME_DEBUG.bat          # Chrome launcher with debugging
│   ├── RUN_BUPA_AUTOMATION.bat         # Complete automation runner
│   └── README_BUPA_AUTOMATION.md       # This file
└── 520660\                             # PDF files directory
    ├── 99179 URINARY BLADDER CATHETERIZATION.pdf
    ├── 334777 UROFLOWMETRY.pdf
    ├── 369642 PULMONARY FUNCTION TEST.pdf
    └── ... (other PDF files)
```

## Configuration

### Update File Directory
Edit `bupa_automation.py` line 220:
```python
FILE_DIR = r"C:\Users\rcmrejection3\520660"  # Change to your directory
```

### Update Entry Data
Modify the `REMAINING_ENTRIES` list in `bupa_automation.py` (lines 175-262) with your claim data:
```python
REMAINING_ENTRIES = [
    {
        'claim_no': '325861981',
        'file_no': '99179',
        'epis_no': '19',
        'serv_desc': 'URINARY BLADDER CATHETERIZATION',
        'file_name': '99179 URINARY BLADDER CATHETERIZATION.pdf'
    },
    # Add more entries...
]
```

## How It Works

1. **Connects to Chrome**: Uses Selenium to connect to Chrome with remote debugging
2. **Maintains Session**: Preserves your logged-in session in Bupa portal
3. **Fills Form**: For each entry:
   - Selects shortfall category (DE02)
   - Enters voucher number (claim number)
   - Fills service description
   - Adds justification text
   - Uploads PDF file
   - Clicks Upload button
   - Clicks Add button
4. **Logs Progress**: Creates detailed log file with timestamps
5. **Summary Report**: Shows success/failure statistics

## Logging

Each run creates a log file: `bupa_automation_YYYYMMDD_HHMMSS.log`

Example log output:
```
2026-01-19 12:45:30 - INFO - Processing: 325861981 - URINARY BLADDER CATHETERIZATION
2026-01-19 12:45:31 - INFO -   [1/7] Selecting shortfall category...
2026-01-19 12:45:32 - INFO -   [2/7] Filling voucher number...
2026-01-19 12:45:33 - INFO -   [5/7] Uploading file: 99179 URINARY BLADDER CATHETERIZATION.pdf
2026-01-19 12:45:35 - INFO - ✓ Entry 325861981 added successfully!
```

## Troubleshooting

### Issue: "Failed to connect to browser"
**Solution**: Make sure Chrome is running with `--remote-debugging-port=9222`
```cmd
START_CHROME_DEBUG.bat
```

### Issue: "File not found"
**Solution**: Verify PDF files exist in the directory and filenames match exactly
```bash
dir C:\Users\rcmrejection3\520660\*.pdf
```

### Issue: "Selenium not installed"
**Solution**: Install Selenium
```bash
pip install selenium
```

### Issue: Session expired/logged out
**Solution**: 
1. Stop the script (Ctrl+C)
2. Log back into Bupa portal manually in Chrome
3. Navigate to Batch Statement Review page
4. Re-run the script

## Current Progress

As of January 19, 2026:
- ✅ **3 entries completed** manually (VENOUS BLOOD GASES, HYALUBRIX, INTRA LESIONAL INJECTION)
- ⏳ **12 entries remaining** (ready for automation)

## Customization for Future Batches

To use this tool for new claim batches:

1. **Update PDF Directory**:
   ```python
   FILE_DIR = r"C:\path\to\new\batch\pdfs"
   ```

2. **Update Entry Data**:
   Replace `REMAINING_ENTRIES` list with new claim data from Excel/CSV

3. **Run the Automation**:
   ```cmd
   RUN_BUPA_AUTOMATION.bat
   ```

## Security Notes

- **Chrome Profile**: Uses separate profile (`C:\selenium\chrome-profile`) for automation
- **Session Safety**: Connects to existing browser session (no credential storage)
- **Local Files Only**: All files accessed locally (no network transmission)
- **Logging**: Contains claim numbers and file names (review before sharing)

## Support

For issues or questions:
1. Check log file: `bupa_automation_*.log`
2. Verify prerequisites are met
3. Ensure Chrome debugging is enabled
4. Confirm you're logged into Bupa portal

## Version History

- **v1.0** (2026-01-19): Initial release
  - Automated form filling
  - File upload support
  - Logging and error handling
  - Windows batch file runners

---

**Author**: Automation System  
**Last Updated**: January 19, 2026  
**License**: Internal Use Only
