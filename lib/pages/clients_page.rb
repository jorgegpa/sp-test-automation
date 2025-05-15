require_relative 'base_page'

class ClientsPage < BasePage
  SEARCH_FIELD_CSS= 'input.utility-search'.freeze
  CLIENT_LINK_CSS = 'div.client-list-item a.record-name'.freeze

  def search_for_client(fullName)
    search_field_element = @session.find(SEARCH_FIELD_CSS, wait: Capybara.default_max_wait_time)
    search_field_element.set(fullName)
  end
  
  def is_client_added?(fullName)
    @session.has_css?(CLIENT_LINK_CSS, text: fullName, wait: Capybara.default_max_wait_time)
  end

end