import time
import unittest
import os
from configparser import ConfigParser
from selenium import webdriver


class GithubSearchTest(unittest.TestCase):
    def setUp(self):
        config = ConfigParser()
        config.read('test.ini')
        caps = {'browserName': os.getenv('BROWSER', 'firefox')}
        self.browser = webdriver.Remote(command_executor="http://{0}:4444/wd/hub".
                                        format(config.get('selenium_hub', 'url')),
                                        desired_capabilities=caps)

    def test_github_repo_search(self):
        browser = self.browser
        browser.get('https://www.google.com')
        search_box = browser.find_element_by_name('q')
        search_box.send_keys("Testing")
        time.sleep(10)  # simulate long running test

    def tearDown(self):
        self.browser.quit()  # quit vs close?


if __name__ == '__main__':
    unittest.main()
