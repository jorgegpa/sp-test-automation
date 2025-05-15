require_relative 'base_page'

class CommonMenuPage < BasePage

  #Top Menu Locators
  MY_ACCOUNT_BTN_CSS = 'div.my-account'.freeze
  SEARCH_FIELD_CSS = 'input.spds-input-search-input'.freeze
  CREATE_BTN_CSS= 'button.create'.freeze
  CREATE_CLIENT_BTN_CSS= 'div.item button.button-link'.freeze

  #Left Menu Locators
  CLIENTS_MENU_BTN_CSS = 'a[href="/clients"]'



  def search_clients(client)
    @session.fill_in(SEARCH_FIELD_CSS, with: client)
  end  

  def click_my_account_button
    @session.find(MY_ACCOUNT_BTN_CSS).click
  end

  def click_create_button
    @session.find(CREATE_BTN_CSS).click
  end

  def click_create_client_button
     @session.find(CREATE_CLIENT_BTN_CSS, text: 'Create client').click
  end

  def click_clients_menu_button
    @session.find(CLIENTS_MENU_BTN_CSS).click
  end

  def is_my_account_button_visible?
    element = @session.find(MY_ACCOUNT_BTN_CSS)
    element.visible?
  rescue Capybara::ElementNotFound
    false
  end
end