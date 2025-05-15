class BasePage
  include Capybara::DSL

  def initialize(session = Capybara.current_session)
    @session = session
  end

  def visit_page(url_path)
    @session.visit(url_path) # Capybara will prepend app_host
  end

  # You can add more common helper methods here, e.g., for waiting for elements
end