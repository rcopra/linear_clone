# frozen_string_literal: true

if ENV['CI']
  require 'simplecov'

  unless SimpleCov.running
    SimpleCov.start('rails') do
      add_filter '/lib/tasks/'
      add_group 'Models',      'app/models'
      add_group 'Controllers', 'app/controllers'
      add_group 'Operations',  'app/operations'
      add_group 'Blueprints',  'app/blueprints'
      add_group 'Decorators',  'app/decorators'
    end
  end
end

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'shoulda/matchers'

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

# Load all files in spec/support (e.g., helpers like parsed_response)
Rails.root.glob('spec/support/**/*.rb').each { |f| require f }

# Maintain test schema
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Use transactional fixtures
  config.use_transactional_fixtures = true

  # Enable Time helpers (e.g. travel_to, freeze_time)
  config.include ActiveSupport::Testing::TimeHelpers

  # Include custom test helpers
  config.include JsonResponseHelper
  config.include OperationResultHelper if defined?(OperationResultHelper)

  # Clean up uploaded files (if applicable)
  config.after do
    FileUtils.rm_rf(Rails.root.join('tmp/storage')) if Rails.env.test?
  end

  # Bullet (N+1 query detector)
  if defined?(Bullet) && Bullet.enable?
    config.before { Bullet.start_request }
    config.after do
      Bullet.perform_out_of_channel_notifications if Bullet.notification?
      Bullet.end_request
    end
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
