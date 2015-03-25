require 'capybara'
require 'capybara/cucumber'
require 'cucumber/rails'
require 'site_prism'

ActionController::Base.allow_rescue = false

Before { DigestAuthentication.reset }
