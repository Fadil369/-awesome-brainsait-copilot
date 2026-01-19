"""
BUPA Batch Statement Automation Tool - Windows Optimized
Automates submission of claim entries to Bupa Provider Portal
Version: 1.0
"""
import sys
import os
import time
import logging
from datetime import datetime

try:
    from selenium import webdriver
    from selenium.webdriver.common.by import By
    from selenium.webdriver.support.ui import Select, WebDriverWait
    from selenium.webdriver.support import expected_conditions as EC
except ImportError:
    print("ERROR: Selenium not installed. Run: pip install selenium")
    sys.exit(1)

# Configure logging
log_file = f'bupa_automation_{datetime.now().strftime("%Y%m%d_%H%M%S")}.log'
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(log_file),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class BupaAutomation:
    """Main automation class for Bupa batch submission"""
    
    def __init__(self, file_directory):
        self.file_directory = file_directory
        self.driver = None
        self.wait = None
        self.entries_added = 0
        self.entries_failed = 0
        logger.info(f"Initializing BUPA Automation Tool")
        logger.info(f"File Directory: {file_directory}")
    
    def connect_to_browser(self):
        """Connect to Chrome running with --remote-debugging-port=9222"""
        try:
            options = webdriver.ChromeOptions()
            options.add_experimental_option("debuggerAddress", "127.0.0.1:9222")
            self.driver = webdriver.Chrome(options=options)
            self.wait = WebDriverWait(self.driver, 20)
            logger.info("✓ Connected to Chrome browser successfully")
            return True
        except Exception as e:
            logger.error(f"✗ Failed to connect to browser: {str(e)}")
            logger.error("Make sure Chrome is running with: chrome.exe --remote-debugging-port=9222")
            return False
    
    def upload_file(self, file_path):
        """Upload file to form"""
        try:
            if not os.path.exists(file_path):
                logger.error(f"✗ File not found: {file_path}")
                return False
            
            file_input = self.driver.find_element(By.CSS_SELECTOR, 'input[type="file"]')
            abs_path = os.path.abspath(file_path)
            file_input.send_keys(abs_path)
            logger.info(f"✓ File uploaded: {os.path.basename(file_path)}")
            time.sleep(1)
            return True
        except Exception as e:
            logger.error(f"✗ Failed to upload file: {str(e)}")
            return False
    
    def add_entry(self, entry_data):
        """Add a single entry to the batch statement"""
        logger.info(f"\n{'='*70}")
        logger.info(f"Processing: {entry_data['claim_no']} - {entry_data['serv_desc']}")
        logger.info(f"{'='*70}")
        
        try:
            # Step 1: Select Shortfall Category
            logger.info("  [1/7] Selecting shortfall category...")
            shortfall_select = self.driver.find_element(By.CSS_SELECTOR, 'select')
            Select(shortfall_select).select_by_value('DE02')
            time.sleep(0.5)
            
            # Step 2: Fill Voucher Number
            logger.info("  [2/7] Filling voucher number...")
            textboxes = self.driver.find_elements(By.CSS_SELECTOR, 'input[type="text"]')
            if textboxes:
                textboxes[0].clear()
                textboxes[0].send_keys(entry_data['claim_no'])
                time.sleep(0.5)
            
            # Step 3: Fill Service Description
            logger.info("  [3/7] Filling service description...")
            textareas = self.driver.find_elements(By.CSS_SELECTOR, 'textarea')
            if len(textareas) > 0:
                service_desc = f"{entry_data['claim_no']}-{entry_data['file_no']}-{entry_data['epis_no']}-{entry_data['serv_desc']}"
                service_desc = service_desc[:150]
                textareas[0].clear()
                textareas[0].send_keys(service_desc)
                time.sleep(0.5)
            
            # Step 4: Fill Justification
            logger.info("  [4/7] Filling justification...")
            if len(textareas) > 1:
                textareas[1].clear()
                textareas[1].send_keys("Report")
                time.sleep(0.5)
            
            # Step 5: Upload File
            logger.info(f"  [5/7] Uploading file: {entry_data['file_name']}")
            file_path = os.path.join(self.file_directory, entry_data['file_name'])
            if not self.upload_file(file_path):
                logger.error(f"✗ Failed to upload file for entry {entry_data['claim_no']}")
                self.entries_failed += 1
                return False
            time.sleep(1)
            
            # Step 6: Click Upload Button
            logger.info("  [6/7] Clicking Upload button...")
            upload_buttons = self.driver.find_elements(By.CSS_SELECTOR, 'button[type="submit"]')
            if len(upload_buttons) > 0:
                upload_buttons[0].click()
                time.sleep(2)
            
            # Step 7: Click Add Button
            logger.info("  [7/7] Clicking Add button...")
            add_buttons = self.driver.find_elements(By.CSS_SELECTOR, 'button[type="submit"]')
            if len(add_buttons) > 1:
                add_buttons[1].click()
                time.sleep(2)
            
            logger.info(f"✓ Entry {entry_data['claim_no']} added successfully!")
            self.entries_added += 1
            return True
            
        except Exception as e:
            logger.error(f"✗ Error adding entry {entry_data['claim_no']}: {str(e)}")
            self.entries_failed += 1
            return False
    
    def get_summary(self):
        """Get completion summary"""
        total = self.entries_added + self.entries_failed
        success_rate = (self.entries_added / total * 100) if total > 0 else 0
        return {
            'total_entries': total,
            'successful': self.entries_added,
            'failed': self.entries_failed,
            'success_rate': success_rate
        }
    
    def run(self, entries):
        """Run the automation for all entries"""
        logger.info("\n" + "="*70)
        logger.info("BUPA BATCH SUBMISSION AUTOMATION")
        logger.info("="*70)
        logger.info(f"Total entries to process: {len(entries)}")
        logger.info(f"{'='*70}\n")
        
        # Connect to browser
        if not self.connect_to_browser():
            logger.error("Failed to connect to browser. Exiting.")
            return False
        
        # Process each entry
        for idx, entry in enumerate(entries, 1):
            logger.info(f"\n--- Processing Entry {idx} of {len(entries)} ---")
            self.add_entry(entry)
            time.sleep(1)
        
        # Print summary
        logger.info(f"\n{'='*70}")
        logger.info("AUTOMATION COMPLETED")
        summary = self.get_summary()
        logger.info(f"Total Entries: {summary['total_entries']}")
        logger.info(f"Successful: {summary['successful']}")
        logger.info(f"Failed: {summary['failed']}")
        logger.info(f"Success Rate: {summary['success_rate']:.1f}%")
        logger.info(f"{'='*70}\n")
        
        return True

# Entry data for the 12 remaining entries
REMAINING_ENTRIES = [
    {
        'claim_no': '325861981',
        'file_no': '99179',
        'epis_no': '19',
        'serv_desc': 'URINARY BLADDER CATHETERIZATION',
        'file_name': '99179 URINARY BLADDER CATHETERIZATION.pdf'
    },
    {
        'claim_no': '325852036',
        'file_no': '334777',
        'epis_no': '27',
        'serv_desc': 'UROFLOWMETRY / FREE PSA',
        'file_name': '334777 UROFLOWMETRY.pdf'
    },
    {
        'claim_no': '325839102',
        'file_no': '369642',
        'epis_no': '62',
        'serv_desc': 'PULMONARY FUNCTION TEST',
        'file_name': '369642 PULMONARY FUNCTION TEST.pdf'
    },
    {
        'claim_no': '325861849',
        'file_no': '283143',
        'epis_no': '66',
        'serv_desc': 'INTRA LESIONAL INJECTION',
        'file_name': '283143 INTRA LESIONAL INJECTION.pdf'
    },
    {
        'claim_no': '325853667',
        'file_no': '26510',
        'epis_no': '96',
        'serv_desc': 'PHYSIOTHERAPY 2 MODALITIES',
        'file_name': '26510 PHYSIOTHERAPY.pdf'
    },
    {
        'claim_no': '325853645',
        'file_no': '26510',
        'epis_no': '94',
        'serv_desc': 'INTRA-ARTICULAR INJECTION',
        'file_name': '26510 INTRA ARTICULAR INJECTION.pdf'
    },
    {
        'claim_no': '325861984',
        'file_no': '99179',
        'epis_no': '20',
        'serv_desc': 'PHYSIOTHERAPY 2 MODALITIES',
        'file_name': '99179 PHYSIOTHERAPY.pdf'
    },
    {
        'claim_no': '325861981',
        'file_no': '99179',
        'epis_no': '19',
        'serv_desc': 'UROFLOWMETRY',
        'file_name': '99179 UROFLOWMETRY.pdf'
    },
    {
        'claim_no': '325861910',
        'file_no': '498434',
        'epis_no': '12',
        'serv_desc': 'CONSULTATION FEE',
        'file_name': '498434 CONSULTATION FEE (CONSULTANT).pdf'
    },
    {
        'claim_no': '325839043',
        'file_no': '369642',
        'epis_no': '61',
        'serv_desc': 'ECG',
        'file_name': '369642 ECG.pdf'
    },
    {
        'claim_no': '325861932',
        'file_no': '498434',
        'epis_no': '15',
        'serv_desc': 'ECHO CARDIOGRAPHY',
        'file_name': '498434 ECHO.pdf'
    },
    {
        'claim_no': '326034605',
        'file_no': '26510',
        'epis_no': '94',
        'serv_desc': 'HYALUBRIX INTRA-ARTICULAR',
        'file_name': '26510 HYALUBRIX INTRA-ARTICULAR INJECTION.pdf'
    }
]

def main():
    """Main execution function"""
    # Configuration
    FILE_DIR = r"C:\Users\rcmrejection3\520660"
    
    # Validate file directory
    if not os.path.exists(FILE_DIR):
        print(f"ERROR: File directory not found: {FILE_DIR}")
        return False
    
    # Create automation instance
    automation = BupaAutomation(FILE_DIR)
    
    try:
        # Run automation
        success = automation.run(REMAINING_ENTRIES)
        
        # Print summary
        summary = automation.get_summary()
        print(f"\n{'='*70}")
        print("AUTOMATION COMPLETED")
        print(f"{'='*70}")
        print(f"Total Processed: {summary['total_entries']}")
        print(f"Successful: {summary['successful']}")
        print(f"Failed: {summary['failed']}")
        print(f"Success Rate: {summary['success_rate']:.1f}%")
        print(f"{'='*70}\n")
        
        return success
        
    except KeyboardInterrupt:
        logger.info("Automation interrupted by user")
        return False

if __name__ == "__main__":
    main()
