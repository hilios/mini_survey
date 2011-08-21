# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# Switch off the processors
CarrierWave.configure do |config|
  config.enable_processing = false
end

RSpec.configure do |config|
  config.mock_with :rspec
  
  config.use_transactional_fixtures = true
  
  config.include CarrierWave::Test::Matchers
  
  config.after(:suite) do
    user = FactoryGirl.build(:user)
    store_path = File.dirname File.dirname(user.avatar.store_path)
    FileUtils.rm_rf(store_path)
  end
end
