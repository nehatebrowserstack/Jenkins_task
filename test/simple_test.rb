require "minitest/autorun"
require "minitest/reporters"
require "selenium-webdriver"
require "fileutils"

# Ensure reports folder exists
FileUtils.mkdir_p("reports")

# JUnit reporter
Minitest::Reporters.use!(
  Minitest::Reporters::JUnitReporter.new("reports/results.xml", single_file: true)
)

class BrowserStackTest < Minitest::Test
  def test_example_page
    username = ENV["BROWSERSTACK_USERNAME"]
    access_key = ENV["BROWSERSTACK_ACCESS_KEY"]

    # Chrome options object
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_option("bstack:options", {
      userName: username,
      accessKey: access_key,
      sessionName: "Simple Rake Test",
      os: "Windows",
      osVersion: "10"
    })

    # Remote driver
    driver = Selenium::WebDriver.for(
      :remote,
      url: "https://hub.browserstack.com/wd/hub",
      capabilities: options
    )

    driver.navigate.to("https://example.com")
    assert_includes driver.title, "Example"

    driver.quit
  end
end
