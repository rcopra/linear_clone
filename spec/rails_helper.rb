# frozen_string_literal: true

if ENV['CI']
  require 'simplecov'

  unless SimpleCov.running
    SimpleCov.start('rails') do
      add_filter '/lib/tasks/'
      add_group 'Models', 'app/models'
      add_group 'Controllers', 'app/controllers'
      add_group 'Helpers', 'app/helpers'
    end
  end
end

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

# Support files (load all helpers/config from spec/support)
Rails.root.glob('spec/support/**/*.rb').each { |f| require f }

# Maintain test schema
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

# Main RSpec config
RSpec.configure do |config|
  # Automatically infer type from file location (e.g., type: :model)
  config.infer_spec_type_from_file_location!

  # Filter noise from Rails gems in backtraces
  config.filter_rails_from_backtrace!

  # Use transactional fixtures
  config.use_transactional_fixtures = true

  # Sidekiq test mode (optional for async background jobs)
  # require 'sidekiq/testing'
  # Sidekiq::Testing.inline!

  # config.before do
  #   Sidekiq::Worker.clear_all
  # end

  # config.before(:all) do
  #   Sidekiq.logger.level = Logger::ERROR
  # end

  if defined?(Bullet) && Bullet.enable?
    config.before { Bullet.start_request }
    config.after do
      Bullet.perform_out_of_channel_notifications if Bullet.notification?
      Bullet.end_request
    end
  end

  # Time helpers (travel_to, freeze_time, etc.)
  config.include ActiveSupport::Testing::TimeHelpers

  # Optional: Clean uploaded test files
  config.after do
    FileUtils.rm_rf(Rails.root.join('tmp/storage')) if Rails.env.test?
  end
end
