require "minitest/autorun"
require "minitest/reporters"
require "selenium-webdriver"
require "fileutils"

# Create reports folder
FileUtils.mkdir_p("reports")

# JUnit Reporter
Minitest::Reporters.use!(
  Minitest::Reporters::JUnitReporter.new("reports", single_file: true)
)

class BrowserStackTest < Minitest::Test
  def test_example_page
    # BrowserStack capabilities
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      browser_name: "Chrome",
      browser_version: "latest",
      platform_name: "Windows 10",
      "bstack:options" => {
        userName: ENV["BROWSERSTACK_USERNAME"],
        accessKey: ENV["BROWSERSTACK_ACCESS_KEY"],
        sessionName: "Simple Rake Test"
      }
    )

    # Initialize remote driver
    driver = Selenium::WebDriver.for(
      :remote,
      url: "https://hub.browserstack.com/wd/hub",
      capabilities: caps
    )

    driver.navigate.to("https://example.com")
    assert_includes driver.title, "Example"

    driver.quit
  end
end
