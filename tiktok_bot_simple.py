cat > tiktok_bot_simple.py << 'EOF'
#!/usr/bin/env python3
"""
TikTok Bot Simple - Termux Compatible
Menggunakan Selenium + Requests saja
"""

import os
import time
import random
import requests
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

class SimpleTikTokBot:
    def __init__(self):
        self.setup_driver()
        self.session = requests.Session()
        self.setup_headers()
        
    def setup_driver(self):
        """Setup ChromeDriver untuk Termux"""
        try:
            chrome_options = Options()
            chrome_options.add_argument('--no-sandbox')
            chrome_options.add_argument('--disable-dev-shm-usage')
            chrome_options.add_argument('--disable-gpu')
            chrome_options.add_argument('--remote-debugging-port=9222')
            chrome_options.add_argument('--user-agent=Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36')
            
            # Untuk Termux, kita perlu path yang benar
            self.driver = webdriver.Chrome(options=chrome_options)
            print("✅ ChromeDriver initialized successfully!")
            
        except Exception as e:
            print(f"❌ ChromeDriver error: {e}")
            print("🔧 Trying alternative method...")
            self.driver = None
    
    def setup_headers(self):
        """Setup headers untuk requests"""
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            'Accept-Language': 'en-US,en;q=0.5',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
        }
        self.session.headers.update(self.headers)
    
    def real_copy_link(self, video_url, count):
        """Real copy link function"""
        if not self.driver:
            print("❌ ChromeDriver not available. Using simulation method.")
            return self.simulate_copy_link(video_url, count)
            
        print(f"🚀 Starting REAL copy link: {count} times")
        success_count = 0
        
        for i in range(count):
            try:
                print(f"📋 Attempt {i+1}/{count}")
                
                # Buka URL TikTok
                self.driver.get(video_url)
                time.sleep(5)  # Tunggu page load
                
                # Method 1: Cari tombol share dengan berbagai selector
                share_selectors = [
                    '[data-e2e="share-icon"]',
                    'svg[width="24"][height="24"]',  # Icon share
                    'button[aria-label*="hare"]',    # Button dengan label share
                    'div[class*="share"]',
                    '//*[contains(text(), "Share")]',
                    '//*[contains(@class, "share")]'
                ]
                
                share_button = None
                for selector in share_selectors:
                    try:
                        if selector.startswith('//'):
                            elements = self.driver.find_elements(By.XPATH, selector)
                        else:
                            elements = self.driver.find_elements(By.CSS_SELECTOR, selector)
                        
                        if elements:
                            share_button = elements[0]
                            break
                    except:
                        continue
                
                if share_button:
                    self.driver.execute_script("arguments[0].click();", share_button)
                    print("✅ Share button clicked")
                    time.sleep(3)
                    
                    # Cari tombol copy link
                    copy_selectors = [
                        '//*[contains(text(), "Copy link")]',
                        '//*[contains(text(), "Salin tautan")]',
                        'div[class*="copy-link"]',
                        'button[aria-label*="opy"]'
                    ]
                    
                    copy_button = None
                    for selector in copy_selectors:
                        try:
                            if selector.startswith('//'):
                                elements = self.driver.find_elements(By.XPATH, selector)
                            else:
                                elements = self.driver.find_elements(By.CSS_SELECTOR, selector)
                            
                            if elements:
                                copy_button = elements[0]
                                break
                        except:
                            continue
                    
                    if copy_button:
                        self.driver.execute_script("arguments[0].click();", copy_button)
                        success_count += 1
                        print(f"✅ Successfully copied link {i+1}")
                    else:
                        print("❌ Copy link button not found")
                else:
                    print("❌ Share button not found")
                
                # Random delay
                delay = random.randint(5, 10)
                print(f"⏳ Waiting {delay} seconds...")
                time.sleep(delay)
                
            except Exception as e:
                print(f"❌ Error in attempt {i+1}: {str(e)[:100]}...")
                continue
        
        print(f"🎯 Copy link completed: {success_count}/{count} successful")
        return success_count
    
    def simulate_copy_link(self, video_url, count):
        """Simulasi copy link jika ChromeDriver tidak tersedia"""
        print(f"🔄 Using SIMULATION method: {count} times")
        
        for i in range(count):
            print(f"📋 Simulation {i+1}/{count}")
            
            # Simulasi HTTP request ke URL
            try:
                response = self.session.get(video_url, timeout=10)
                if response.status_code == 200:
                    print(f"✅ Link accessed successfully {i+1}")
                else:
                    print(f"⚠️  HTTP {response.status_code}")
            except Exception as e:
                print(f"❌ Request error: {e}")
            
            # Simulasi copy action
            print("📋 Simulating copy link action...")
            
            # Random delay
            delay = random.randint(2, 5)
            time.sleep(delay)
        
        print(f"🎯 Simulation completed: {count}/{count}")
        return count
    
    def simulate_views(self, video_url, count):
        """Simulate views dengan requests"""
        print(f"👀 Starting view simulation: {count} views")
        
        success_count = 0
        for i in range(count):
            try:
                # Multiple request methods
                methods = [
                    lambda: self.session.get(video_url, timeout=10),
                    lambda: self.session.head(video_url, timeout=10),
                ]
                
                for method in methods:
                    try:
                        response = method()
                        if response.status_code in [200, 302, 304]:
                            success_count += 0.5  # Count partial success
                    except:
                        pass
                
                print(f"👀 View {i+1}/{count} simulated")
                
                # Random delay
                time.sleep(random.uniform(1, 3))
                
            except Exception as e:
                print(f"❌ View error: {e}")
                continue
        
        print(f"🎯 Views completed: {int(success_count)}/{count}")
        return int(success_count)
    
    def get_video_info(self, video_url):
        """Get basic video info"""
        print(f"📊 Getting video info...")
        
        try:
            response = self.session.get(video_url, timeout=10)
            if response.status_code == 200:
                # Extract basic info from HTML
                html_content = response.text
                
                # Cari judul/deskripsi
                import re
                title_match = re.search(r'<title>(.*?)</title>', html_content)
                title = title_match.group(1) if title_match else "Unknown"
                
                print(f"✅ Video info extracted:")
                print(f"   Title: {title}")
                print(f"   URL: {video_url}")
                return {"title": title, "url": video_url}
            else:
                print(f"❌ Failed to fetch video info: HTTP {response.status_code}")
                return None
                
        except Exception as e:
            print(f"❌ Error getting video info: {e}")
            return None
    
    def close(self):
        """Close driver"""
        if self.driver:
            self.driver.quit()
            print("🔚 ChromeDriver closed")

def main():
    bot = SimpleTikTokBot()
    
    try:
        while True:
            print("\n" + "="*50)
            print("🎵 TIKTOK SIMPLE BOT - TERMUX")
            print("="*50)
            print("1. Real Copy Link (ChromeDriver)")
            print("2. Simulate Copy Link (Requests)")
            print("3. Simulate Views")
            print("4. Get Video Info")
            print("5. Exit")
            
            choice = input("\nSelect option (1-5): ").strip()
            
            if choice == "1":
                url = input("Enter TikTok video URL: ").strip()
                try:
                    count = int(input("Enter copy count (1-20): "))
                    count = min(max(1, count), 20)  # Limit 1-20
                    bot.real_copy_link(url, count)
                except ValueError:
                    print("❌ Please enter a valid number!")
                    
            elif choice == "2":
                url = input("Enter TikTok video URL: ").strip()
                try:
                    count = int(input("Enter copy count (1-50): "))
                    count = min(max(1, count), 50)
                    bot.simulate_copy_link(url, count)
                except ValueError:
                    print("❌ Please enter a valid number!")
                    
            elif choice == "3":
                url = input("Enter TikTok video URL: ").strip()
                try:
                    count = int(input("Enter view count (1-100): "))
                    count = min(max(1, count), 100)
                    bot.simulate_views(url, count)
                except ValueError:
                    print("❌ Please enter a valid number!")
                    
            elif choice == "4":
                url = input("Enter TikTok video URL: ").strip()
                bot.get_video_info(url)
                
            elif choice == "5":
                print("👋 Goodbye!")
                break
                
            else:
                print("❌ Invalid choice!")
            
            input("\nPress Enter to continue...")
            
    except KeyboardInterrupt:
        print("\n\n⚠️  Bot stopped by user")
    finally:
        bot.close()

if __name__ == "__main__":
    main()
EOF
