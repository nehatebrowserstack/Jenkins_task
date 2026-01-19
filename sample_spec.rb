require 'selenium-webdriver'
require 'rspec'

describe "Google Search" do
  it "has the correct title" do
    options = Selenium::WebDriver::Chrome::Options.new
    # Since this runs in Jenkins, we run 'headless' (no window pops up)
    options.add_argument('--headless') 
    driver = Selenium::WebDriver.for :chrome, options: options
    
    driver.navigate.to "https://www.google.com"
    expect(driver.title).to eq("Google")
    
    driver.quit
  end
end