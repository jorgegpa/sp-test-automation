# SimplePractice UI Test Automation

This project contains automated UI tests for the SimplePractice application, focusing on client management and login functionalities. It is built using Ruby, RSpec, and Capybara.

## Table of Contents

- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Environment Variables](#environment-variables)
- [Running the Tests](#running-the-tests)
- [Project Structure](#project-structure)

## Tech Stack

*   **Ruby**: Programming language
*   **RSpec**: Testing framework for Ruby
*   **Capybara**: Acceptance test framework for web applications
*   **Selenium WebDriver**: Browser automation framework
*   **Webdrivers Gem**: Manages browser drivers (e.g., ChromeDriver)
*   **Faker**: Gem for generating fake data (e.g., names, emails)
*   **Dotenv**: Gem for loading environment variables from a `.env` file
*   **Bundler**: Manages Ruby gem dependencies

## Prerequisites

Before you begin, ensure you have the following installed on your system:

1.  **Ruby**: It's recommended to use a Ruby version manager like `rbenv` or `RVM`.
2.  **Bundler**: Install Bundler gem: `gem install bundler`
3.  **Google Chrome**: The tests are configured to run with Chrome by default.

## Setup Instructions

1.  **Clone the Repository**:
    ```bash
    git clone <your-repository-url>
    cd SimplePracticeTestAuto
    ```

2.  **Install Dependencies**:
    Navigate to the project directory and run Bundler to install the required gems:
    ```bash
    bundle install
    ```
    This will install all gems listed in the `Gemfile`.

3.  **Set Up Environment Variables**:
    This project uses environment variables to store sensitive information like login credentials. You'll need to create a `.env` file in the root of the project.

    Create a file named `.env` in the project root:
    ```
    SIMPLEPRACTICE_VALID_EMAIL="your_valid_email@example.com"
    SIMPLEPRACTICE_VALID_PASSWORD="your_valid_password"
    ```
    Replace `"your_valid_email@example.com"` and `"your_valid_password"` with actual valid credentials for the SimplePractice application.

    **Note**: The `.env` file is typically included in `.gitignore` to prevent committing sensitive credentials to version control. Ensure it is if you plan to share this repository.

## Running the Tests

To execute the test suite, run the following command from the project's root directory:

```bash
bundle exec rspec
```

This will run all spec files located in the `./spec` directory.

You can also run specific spec files (relative to the project root):

```bash
bundle exec rspec ./spec/client_spec.rb
bundle exec rspec ./spec/login_spec.rb
```

## Project Structure

A brief overview of the key directories (relative to the project root):

*   `./lib/pages/`: Contains Page Object Model classes that represent different pages or components of the web application.
    *   `base_page.rb`: A base class for page objects, containing common functionalities.
    *   `login_page.rb`: Interactions for the login page.
    *   `common_menu_page.rb`: Interactions for common menu elements (e.g., create button, navigation).
    *   `create_client_page.rb`: Interactions for the client creation form.
    *   `clients_page.rb`: Interactions for the clients listing/search page.
*   `./lib/constants/`: Contains constant values used across the tests (e.g., error messages).
*   `./spec/`: Contains the RSpec test files (specs).
    *   `spec_helper.rb`: RSpec configuration, Capybara setup, and requires for page objects and constants.
    *   `login_spec.rb`: Tests for the login functionality.
    *   `client_spec.rb`: Tests for client creation and verification.
*   `Gemfile` & `Gemfile.lock`: Define and lock project dependencies.
*   `.env`: (You create this) Stores environment variables (e.g., credentials).
*   `README.md`: (This file) Project overview and instructions.