require 'capybara/rspec'
require 'selenium-webdriver'
require 'faker'
require 'webdrivers' 
require 'base64'
require 'logger'
require 'allure-rspec'
require 'dotenv/load'
# Ensure the lib directory (and its subdirectories) is in the load path
$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))

# Require all page object files
Dir[File.expand_path('../lib/pages/**/*.rb', __dir__)].sort.each { |f| require f }

# Require all constants files
Dir[File.expand_path('../lib/constants/**/*.rb', __dir__)].sort.each { |f| require f }

Capybara.configure do |config|
  config.default_driver = :selenium_chrome # Use Chrome
  # For headless Chrome, use:
  # config.default_driver = :selenium_chrome_headless
  config.app_host = 'https://secure.simplepractice.com'
  config.default_max_wait_time = 10 # Default wait time for elements to appear
end

RSpec.configure do |config|
  config.include Capybara::DSL

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus

  # Configure Allure RSpec formatter
  config.formatter = AllureRspecFormatter

  config.after(:each) do |example|
    # Attach screenshot to Allure report if a Capybara test fails
    if example.exception && defined?(Capybara) && Capybara.current_session.driver.browser_options.is_a?(Selenium::WebDriver::Chrome::Options)
      session_to_use = @session || Capybara.current_session
      if session_to_use.respond_to?(:save_screenshot)
        # Create a unique filename for the screenshot
        screenshot_name = "failure-#{SecureRandom.uuid}.png"
        screenshot_path = File.join(AllureRspec.configuration.results_directory, screenshot_name)
        session_to_use.save_screenshot(screenshot_path, full: true)
        Allure.add_attachment(
          name: "Screenshot on failure",
          source: File.open(screenshot_path, "rb"),
          type: Allure::ContentType::PNG
        )
      end
    end
  end
end

AllureRspec.configure do |c|
  c.results_directory = "allure-results" # Default directory for Allure results
  c.clean_results_directory = true       # Clean the results directory before each run
  # You can add more Allure configurations here if needed, e.g.:
  # c.link_tms_pattern = "http://your-tms-instance/browse/{}"
  # c.link_issue_pattern = "http://your-issue-tracker/browse/{}"
end
