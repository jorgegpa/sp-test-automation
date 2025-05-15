# SimplePractice UI Test Automation

This project contains automated UI tests for the SimplePractice application, focusing on client management and login functionalities. It is built using Ruby, RSpec, and Capybara.

## Table of Contents

- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Environment Variables](#environment-variables)
- [Running the Tests](#running-the-tests)
- [Continuous Integration (CI) with GitHub Actions](#continuous-integration-ci-with-github-actions)
- [Viewing Allure Test Reports](#viewing-allure-test-reports)
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
*   **Allure RSpec**: Gem for generating Allure test reports

## Prerequisites

Before you begin, ensure you have the following installed on your system:

1.  **Ruby**: It's recommended to use a Ruby version manager like `rbenv` or `RVM`.
2.  **Bundler**: Install Bundler gem: `gem install bundler`
3.  **Google Chrome**: The tests are configured to run with Chrome by default.
4.  **Allure Commandline (Optional, for local report viewing)**: If you want to view reports locally, install Allure. (e.g., `brew install allure` on macOS).

## Setup Instructions

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/jorgegpa/sp-test-automation
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

This will run all spec files located in the `./spec` directory and generate raw Allure result files in the `./allure-results` directory.

You can also run specific spec files (relative to the project root):

```bash
bundle exec rspec ./spec/client_spec.rb
bundle exec rspec ./spec/login_spec.rb
```

## Continuous Integration (CI) with GitHub Actions

This project is configured to run tests automatically using GitHub Actions on every push to the `main` branch and on pull requests targeting `main`.

The workflow is defined in `./.github/workflows/ci.yml`.

**Key CI Steps:**
1.  Checks out the code.
2.  Sets up Ruby and installs dependencies (gems).
3.  Installs Google Chrome.
4.  Runs RSpec tests (generating Allure results).
5.  Generates an Allure HTML report from the results.
6.  Uploads the Allure report as a build artifact.

**Required GitHub Secrets for CI:**
For the CI pipeline to run successfully, the following secrets must be configured in your GitHub repository settings (Settings > Secrets and variables > Actions):
*   `SIMPLEPRACTICE_VALID_EMAIL`
*   `SIMPLEPRACTICE_VALID_PASSWORD`

## Viewing Allure Test Reports

### Locally
1.  Ensure you have Allure Commandline installed.
2.  Run your tests: `bundle exec rspec`
3.  Generate the report: `allure generate allure-results --clean -o allure-report`
4.  Open the report: `allure open allure-report`

### From GitHub Actions
1.  Navigate to the "Actions" tab in your GitHub repository.
2.  Select the desired workflow run.
3.  On the run's summary page, download the `allure-report` artifact (it will be a ZIP file).
4.  Unzip the downloaded file and open the `index.html` file in your browser.

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
    *   `spec_helper.rb`: RSpec configuration, Capybara setup, and Allure formatter configuration.
    *   `login_spec.rb`: Tests for the login functionality.
    *   `client_spec.rb`: Tests for client creation and verification.
*   `Gemfile` & `Gemfile.lock`: Define and lock project dependencies.
*   `./.github/workflows/ci.yml`: GitHub Actions workflow definition for CI.
*   `.env`: (You create this) Stores environment variables (e.g., credentials).
*   `allure-results/`: (Generated) Directory for raw Allure JSON results.
*   `allure-report/`: (Generated locally) Directory for the HTML Allure report when generated locally.
*   `README.md`: (This file) Project overview and instructions.