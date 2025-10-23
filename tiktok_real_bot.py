#!/usr/bin/env python3
"""
TikTok Real Bot - Termux Edition
Gabungan TikTokApi + Selenium + Requests
"""

import os
import time
import random
import requests
import json
from TikTokApi import TikTokApi
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import urllib.parse

class TikTokRealBot:
    def __init__(self):
        self.session = requests.Session()
        self.setup_headers()
        self.api = None
        self.driver = None
        
    def setup_headers(self):
        """Setup headers untuk mimic mobile app"""
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Mobile Safari/537.36',
            'Accept': 'application/json, text/plain, */*',
            'Accept-Language': 'en-US,en;q=0.9',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
        }
        self.session.headers.update(self.headers)
    
    def init_tiktok_api(self):
        """Initialize TikTokApi"""
        try:
            self.api = TikTokApi()
            print("✅ TikTokApi initialized!")
            return True
        except Exception as e:
            print(f"❌ TikTokApi error: {e}")
            return False
    
    def init_selenium(self):
        """Initialize Selenium WebDriver"""
        try:
            chrome_options = Options()
            chrome_options.add_argument('--no-sandbox')
            chrome_options.add_argument('--disable-dev-shm-usage')
            chrome_options.add_argument('--disable-blink-features=AutomationControlled')
            chrome_options.add_experimental_option("excludeSwitches", ["enable-automation"])
            chrome_options.add_experimental_option('useAutomationExtension', False)
            
            self.driver = webdriver.Chrome(options=chrome_options)
            self.driver.execute_script("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})")
            print("✅ Selenium WebDriver initialized!")
            return True
        except Exception as e:
            print(f"❌ Selenium error: {e}")
            return False
    
    def extract_video_id(self, url):
        """Extract video ID from TikTok URL"""
        try:
            if '/video/' in url:
                return url.split('/video/')[1].split('?')[0]
            return None
        except:
            return None
    
    def real_copy_link_selenium(self, video_url, count):
        """Real copy link menggunakan Selenium"""
        if not self.init_selenium():
            return False
        
        try:
            success_count = 0
            for i in range(count):
                try:
                    print(f"📋 Copy link attempt {i+1}/{count}")
                    
                    self.driver.get(video_url)
                    time.sleep(3)
                    
                    # Cari tombol share
                    share_buttons = self.driver.find_elements(By.CSS_SELECTOR, '[data-e2e*="share"]')
                    if not share_buttons:
                        share_buttons = self.driver.find_elements(By.XPATH, "//*[contains(text(), 'Share')]")
                    
                    if share_buttons:
                        share_buttons[0].click()
                        time.sleep(2)
                        
                        # Cari tombol copy link
                        copy_buttons = self.driver.find_elements(By.XPATH, "//*[contains(text(), 'Copy link')]")
                        if copy_buttons:
                            copy_buttons[0].click()
                            success_count += 1
                            print(f"✅ Successfully copied link {i+1}")
                        else:
                            print("❌ Copy button not found")
                    else:
                        print("❌ Share button not found")
                    
                    # Random delay antara 3-8 detik
                    time.sleep(random.randint(3, 8))
                    
                except Exception as e:
                    print(f"❌ Error in attempt {i+1}: {e}")
                    continue
            
            print(f"🎯 Copy link completed: {success_count}/{count} successful")
            return success_count > 0
            
        finally:
            if self.driver:
                self.driver.quit()
    
    def get_video_info_api(self, video_url):
        """Get video info menggunakan TikTokApi"""
        if not self.init_tiktok_api():
            return None
        
        try:
            video_id = self.extract_video_id(video_url)
            if video_id:
                video_info = self.api.video(id=video_id).info()
                return video_info
            return None
        except Exception as e:
            print(f"❌ API Error: {e}")
            return None
    
    def simulate_views_requests(self, video_url, count):
        """Simulate views menggunakan requests"""
        try:
            success_count = 0
            for i in range(count):
                try:
                    response = self.session.get(video_url, timeout=10)
                    if response.status_code == 200:
                        success_count += 1
                        print(f"👀 View simulated {i+1}/{count}")
                    else:
                        print(f"❌ View failed: HTTP {response.status_code}")
                    
                    # Random delay
                    time.sleep(random.uniform(2, 5))
                    
                except Exception as e:
                    print(f"❌ View error: {e}")
                    continue
            
            print(f"🎯 Views completed: {success_count}/{count}")
            return success_count
            
        except Exception as e:
            print(f"❌ Views simulation error: {e}")
            return 0
    
    def advanced_copy_link(self, video_url, count):
        """Advanced copy link dengan multiple methods"""
        print("🚀 Starting advanced copy link...")
        
        results = {
            'selenium': 0,
            'api': 0,
            'total': 0
        }
        
        # Method 1: Selenium
        print("\n🔧 Method 1: Selenium Automation")
        selenium_success = self.real_copy_link_selenium(video_url, count)
        if selenium_success:
            results['selenium'] = count
        
        # Method 2: API Approach
        print("\n🔧 Method 2: API Interaction")
        api_success = 0
        for i in range(count):
            try:
                video_info = self.get_video_info_api(video_url)
                if video_info:
                    api_success += 1
                    print(f"📊 API interaction {i+1}: Success")
                time.sleep(1)
            except:
                continue
        
        results['api'] = api_success
        results['total'] = results['selenium'] + results['api']
        
        print(f"\n🎯 FINAL RESULTS:")
        print(f"   Selenium: {results['selenium']}/{count}")
        print(f"   API: {results['api']}/{count}")
        print(f"   Total: {results['total']}/{count}")
        
        return results
    
    def batch_operation(self, urls, operation_type, counts):
        """Batch operations untuk multiple URLs"""
        results = []
        for i, url in enumerate(urls):
            print(f"\n🔄 Processing URL {i+1}/{len(urls)}")
            
            if operation_type == "copy":
                result = self.advanced_copy_link(url, counts[i])
            elif operation_type == "view":
                result = self.simulate_views_requests(url, counts[i])
            else:
                result = None
            
            results.append({
                'url': url,
                'type': operation_type,
                'count': counts[i],
                'result': result
            })
            
            # Delay antara URLs
            time.sleep(5)
        
        return results

def main():
    bot = TikTokRealBot()
    
    while True:
        print("\n" + "="*50)
        print("🎵 TIKTOK REAL BOT - TERMUX EDITION")
        print("="*50)
        print("1. Advanced Copy Link")
        print("2. Simulate Views")
        print("3. Get Video Info")
        print("4. Batch Operations")
        print("5. Exit")
        
        choice = input("\nSelect option (1-5): ").strip()
        
        if choice == "1":
            url = input("Enter TikTok video URL: ").strip()
            count = int(input("Enter copy count (1-50): "))
            bot.advanced_copy_link(url, min(count, 50))
            
        elif choice == "2":
            url = input("Enter TikTok video URL: ").strip()
            count = int(input("Enter view count (1-100): "))
            bot.simulate_views_requests(url, min(count, 100))
            
        elif choice == "3":
            url = input("Enter TikTok video URL: ").strip()
            info = bot.get_video_info_api(url)
            if info:
                print(f"\n📊 Video Info:")
                print(f"   Author: {info.get('author', {}).get('uniqueId', 'N/A')}")
                print(f"   Description: {info.get('desc', 'N/A')[:100]}...")
                print(f"   Likes: {info.get('stats', {}).get('diggCount', 'N/A')}")
                print(f"   Shares: {info.get('stats', {}).get('shareCount', 'N/A')}")
            else:
                print("❌ Failed to get video info")
                
        elif choice == "4":
            print("\n🔄 Batch Operations:")
            urls = input("Enter URLs (comma separated): ").split(',')
            counts = [int(x.strip()) for x in input("Enter counts (comma separated): ").split(',')]
            op_type = input("Operation type (copy/view): ").strip().lower()
            
            if len(urls) == len(counts):
                bot.batch_operation(urls, op_type, counts)
            else:
                print("❌ URLs and counts must match!")
                
        elif choice == "5":
            print("👋 Goodbye!")
            break
            
        else:
            print("❌ Invalid choice!")
        
        input("\nPress Enter to continue...")

if __name__ == "__main__":
    main()
