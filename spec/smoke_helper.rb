require 'rails_helper'

RSpec.configure do |config|
  config.use_transactional_fixtures = false
end

DatabaseCleaner.strategy = :truncation