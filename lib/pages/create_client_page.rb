require_relative 'base_page'

class CreateClientPage < BasePage
  # Locators (using IDs and specific CSS selectors for robustness)
  FORM_CONTAINER_CSS = 'div.prospective-client-ui'.freeze # Main container for the create client form
  LEGAL_FIRST_NAME_FIELD_CSS = 'div.prospective-client-ui input[name=\'firstName\']'.freeze
  LEGAL_LAST_NAME_FIELD_CSS = 'div.prospective-client-ui input[name=\'lastName\']'.freeze
  CONTINUE_BTN_CSS='div.footer button'.freeze

  def fill_legal_first_name(firstName)
    @session.fill_in LEGAL_FIRST_NAME_FIELD_CSS, with: firstName
  end

  def fill_legal_last_name(lastName)
    @session.fill_in LEGAL_LAST_NAME_FIELD_CSS, with: lastName
  end

  def click_continue_button
    @session.find(CONTINUE_BTN_CSS).click
  end

  def wait_for_form_to_load(timeout = Capybara.default_max_wait_time)
    unless @session.has_css?(FORM_CONTAINER_CSS, wait: timeout)
      # This block executes if the container is not found after waiting
      @session.save_and_open_page # Helpful for debugging: opens current page in browser
      raise "Create client form container (#{FORM_CONTAINER_CSS}) did not appear within #{timeout} seconds on page: #{@session.current_url}"
    end
    # Optionally, you can also wait for the first field to be specifically visible within the container
    unless @session.has_css?(LEGAL_FIRST_NAME_FIELD_CSS, wait: 2) # Shorter wait, assuming container is now present
      @session.save_and_open_page
      raise "Legal first name field (#{LEGAL_FIRST_NAME_FIELD_CSS}) did not appear within the form after container was loaded."
    end
  end

  def create_new_client(firstName, lastName)
     wait_for_form_to_load
     fill_legal_first_name(firstName)
     fill_legal_last_name(lastName)
     click_continue_button
  end

end