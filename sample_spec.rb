require 'selenium-webdriver'
require 'rspec'

describe "BrowserStack Google Test" do
  it "should open Google and have the correct title" do
    caps = Selenium::WebDriver::Remote::Capabilities.new
    caps['browserName'] = 'Chrome'
    caps['browser_version'] = 'latest'
    caps['os'] = 'Windows'
    caps['os_version'] = '10'

    # These come from Jenkins Credentials
    user = ENV['BS_USERNAME']
    key = ENV['BS_ACCESS_KEY']
    url = "https://#{user}:#{key}@hub-cloud.browserstack.com/wd/hub"

    driver = Selenium::WebDriver.for(:remote, url: url, desired_capabilities: caps)
    
    driver.navigate.to "https://www.google.com"
    expect(driver.title).to include("Google")
    
    driver.quit
  end
end