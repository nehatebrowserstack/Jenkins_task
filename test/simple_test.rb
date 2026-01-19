require "fileutils"
require "minitest/autorun"
require "minitest/reporters"
require "selenium-webdriver"

project_root = File.expand_path("..", __dir__)
reports_path = File.join(project_root, "reports")

# 2. Clean and create the folder at the absolute project root
FileUtils.rm_rf(reports_path)
FileUtils.mkdir_p(reports_path)

# 3. Tell the reporter exactly where to go
Minitest::Reporters.use!(
  Minitest::Reporters::JUnitReporter.new(reports_path)
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
