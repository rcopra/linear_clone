# frozen_string_literal: true

source 'https://rubygems.org'

# Core Rails stack
gem 'bcrypt', '~> 3.1.7'                     # For has_secure_password
gem 'importmap-rails'
gem 'pg', '~> 1.1'                           # PostgreSQL database
gem 'puma', '>= 5.0'                         # Web server
gem 'rails', '~> 7.2.2', '>= 7.2.2.1'
gem 'turbo-rails'

# Asset pipeline & frontend
gem 'blueprinter', '~> 1.1' # Fast JSON serializer
gem 'jbuilder' # JSON builder for APIs
gem 'sprockets-rails' # Rails asset pipeline
gem 'stimulus-rails'
gem 'tailwindcss-rails' # Tailwind CSS via Rails integration

# Platform-specific
gem 'tzinfo-data', platforms: %i[windows jruby]

# Performance
gem 'bootsnap', require: false # Reduces boot time by caching

# Optional (commented until needed)
# gem 'redis', '>= 4.0.1'                    # For Action Cable in production
# gem 'kredis'                               # Higher-level Redis-backed attributes
# gem 'image_processing', '~> 1.2'           # For Active Storage variants

# Development and Test environments
group :development, :test do
  gem 'database_cleaner-active_record' # Clean DB between tests
  gem 'factory_bot_rails' # Test data factories
  gem 'faker' # Fake data generation
  gem 'rspec-rails' # RSpec for testing
  gem 'shoulda-matchers' # Common Rails matchers

  # Rubocop linters
  gem 'rubocop', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rails-omakase', require: false
  gem 'rubocop-rspec', require: false

  # Security and debugging
  gem 'brakeman', require: false # Static security analysis
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'

  # Optional tools
  # gem 'bullet', '~> 6.1'                   # Detect N+1 queries
end

# Development-only
group :development do
  gem 'web-console' # Console on error pages
end

# Test-only
group :test do
  gem 'capybara'                             # Feature/system testing
  gem 'selenium-webdriver'                   # For Capybara + browser automation
end
