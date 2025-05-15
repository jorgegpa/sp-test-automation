require 'spec_helper'

RSpec.describe 'Client Functionality', type: :feature do
  let(:clients_page) { ClientsPage.new } 
  let(:create_client_page) { CreateClientPage.new } 
  let(:common_menu_page) { CommonMenuPage.new } 
  let(:login_page) { LoginPage.new } 

  before do
    # Do Login 
    login_page.visit
    login_page.login_as(ENV['SIMPLEPRACTICE_VALID_EMAIL'], ENV['SIMPLEPRACTICE_VALID_PASSWORD'])
    expect(common_menu_page.is_my_account_button_visible?).to be_truthy    
  end

  context 'Create new client prospect' do
    it 'Click on create and fill the client information to validate it was added"' do
      client_first_name=Faker::Name.first_name
      client_last_name=Faker::Name.last_name
      client_fullname=client_first_name+' '+client_last_name;
      common_menu_page.click_create_button
      common_menu_page.click_create_client_button
      create_client_page.create_new_client(client_first_name, client_last_name)
      common_menu_page.click_clients_menu_button # Navigates to clients list
      clients_page.search_for_client(client_fullname) # Search for the newly created client
      expect(clients_page.is_client_added?(client_fullname)).to be_truthy # Verify client is in the list
    end
  end
end