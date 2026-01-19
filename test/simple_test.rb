require "minitest/autorun"
require "minitest/reporters"
require "selenium-webdriver"
require "fileutils"

# Ensure reports folder exists
FileUtils.mkdir_p("reports")

# Configure JUnit reporter
Minitest::Reporters.use!(
  Minitest::Reporters::JUnitReporter.new("reports", single_file: true)
)

class BrowserStackTest < Minitest::Test
  def test_example_page
    username = ENV["BROWSERSTACK_USERNAME"]
    access_key = ENV["BROWSERSTACK_ACCESS_KEY"]

    caps = {
      "browser" => "Chrome",
      "browser_version" => "latest",
      "os" => "Windows",
      "os_version" => "10",
      "name" => "Simple Rake Test"
    }

    driver = Selenium::WebDriver.for(
      :remote,
      url: "https://#{username}:#{access_key}@hub.browserstack.com/wd/hub",
      capabilities: caps
    )

    driver.navigate.to("https://example.com")
    assert_includes driver.title, "Example"

    driver.quit
  end
end
