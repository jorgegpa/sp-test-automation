require_relative 'base_page'

class CreateClientPage < BasePage
  FORM_CONTAINER_CSS = 'div.prospective-client-ui'.freeze       
  LEGAL_FIRST_NAME_FIELD_NAME = 'firstName'.freeze             
  LEGAL_LAST_NAME_FIELD_NAME = 'lastName'.freeze               
  CONTINUE_BTN_CSS='div.footer button'.freeze

  def fill_legal_first_name(firstName)
    @session.fill_in LEGAL_FIRST_NAME_FIELD_NAME, with: firstName
  end

  def fill_legal_last_name(lastName)
    @session.fill_in LEGAL_LAST_NAME_FIELD_NAME, with: lastName
  end

  def click_continue_button
    @session.find(CONTINUE_BTN_CSS).click
  end

  def wait_for_form_to_load(timeout = Capybara.default_max_wait_time)
    unless @session.has_css?(FORM_CONTAINER_CSS, wait: timeout)
      raise "Create client form container (#{FORM_CONTAINER_CSS}) did not appear within #{timeout} seconds on page: #{@session.current_url}"
    end
    # Wait for the field to be present AND enabled, using its name attribute
    unless @session.has_field?(LEGAL_FIRST_NAME_FIELD_NAME, wait: 5, disabled: false) # Check for enabled state
      @session.save_and_open_page
      raise "Legal first name field (name: '#{LEGAL_FIRST_NAME_FIELD_NAME}') did not appear or was not enabled within the form after container was loaded."
    end
  end

  def create_new_client(firstName, lastName)
     wait_for_form_to_load
     fill_legal_first_name(firstName)
     fill_legal_last_name(lastName)
     click_continue_button
  end

end