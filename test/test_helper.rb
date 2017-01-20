ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end

CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end

Minitest.after_run {
  FileUtils.rm_rf(ImageUploader.new.store_dir)
}