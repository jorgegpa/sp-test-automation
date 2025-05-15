require_relative 'base_page'

class LoginPage < BasePage
  URL_PATH = '/'.freeze
  EMAIL_FIELD_ID = 'user_email'.freeze
  PASSWORD_FIELD_ID = 'user_password'.freeze
  SIGN_IN_BTN_ID = "submitBtn".freeze
  ERROR_MESSAGE_CSS = "div.alert.alert-error".freeze

  def visit
    visit_page(URL_PATH)
  end

  def fill_email(email)
    @session.fill_in EMAIL_FIELD_ID, with: email
  end

  def fill_password(password)
    @session.fill_in PASSWORD_FIELD_ID, with: password
  end

  def click_sign_in_button
    @session.find(id: SIGN_IN_BTN_ID).click
  end

  def login_as(email, password)
    fill_email(email)
    fill_password(password)
    click_sign_in_button
  end

  def has_login_error_message?(expected_message)
    @session.has_css?(ERROR_MESSAGE_CSS, text: expected_message, wait: 5)
  end

  def on_login_page?
      @session.has_field?(EMAIL_FIELD_ID) &&
      @session.has_field?(PASSWORD_FIELD_ID) &&
      @session.has_css?('#'+SIGN_IN_BTN_ID)
  end
end