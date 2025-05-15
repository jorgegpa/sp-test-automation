require 'spec_helper'

RSpec.describe 'Login Functionality', type: :feature do
  let(:login_page) { LoginPage.new } # Instantiate our page object
  let(:common_menu_page) { CommonMenuPage.new } # Instantiate our page object

  before do
    # Ensure we are actually on the login page before each test
    login_page.visit
    expect(login_page).to be_on_login_page, "Failed to load the login page at #{Capybara.app_host}#{LoginPage::URL_PATH}"
  end

  context 'when providing invalid credentials' do
    it 'shows an error message "Invalid email or password."' do
      login_page.login_as(Faker::Internet.email, Faker::Internet.password(min_length: 8))
      expect(login_page).to have_login_error_message(TestConstants::Messages::INVALID_CREDENTIALS_ERROR)
      # Verify we are still on the login page
      expect(login_page).to be_on_login_page
    end
  end

  context 'when providing valid credentials' do
    # IMPORTANT: Set these environment variables before running the test:
    # export SIMPLEPRACTICE_VALID_EMAIL="your_valid_email@example.com"
    # export SIMPLEPRACTICE_VALID_PASSWORD="your_valid_password"
    let(:valid_email) { ENV['SIMPLEPRACTICE_VALID_EMAIL'] }
    let(:valid_password) { ENV['SIMPLEPRACTICE_VALID_PASSWORD'] }

    it 'redirects to the dashboard or a logged-in area' do
      unless valid_email && valid_password
        skip(TestConstants::Messages::MISSING_CREDENTIALS_SKIP)
      end

      login_page.login_as(valid_email, valid_password)
      expect(common_menu_page.is_my_account_button_visible?).to be_truthy
    end
  end
end