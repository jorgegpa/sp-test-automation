require 'capybara/rspec'
require 'selenium-webdriver'
require 'faker'
require 'webdrivers' 
require 'base64'
require 'logger'
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
end
