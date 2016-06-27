# frozen_string_literal: true
require 'capybara'
require 'capybara/cucumber'
require 'cucumber/rails'
require 'database_cleaner'
require 'database_cleaner/cucumber'
require 'site_prism'

ActionController::Base.allow_rescue = false

DatabaseCleaner.strategy = :truncation

Around do |_scenario, block|
  DatabaseCleaner.cleaning(&block)
end

World(FactoryGirl::Syntax::Methods)
