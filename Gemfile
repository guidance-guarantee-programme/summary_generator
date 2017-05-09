# frozen_string_literal: true
source 'https://rubygems.org'

ruby IO.read('.ruby-version').strip

# force Bundler to use HTTPS for github repos
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

gem 'autoprefixer-rails'
gem 'bootstrap-kaminari-views'
gem 'bugsnag'
gem 'deprecated_columns'
gem 'foreman'
gem 'gaffe'
gem 'gds-sso'
gem 'govuk_admin_template'
gem 'jc-validates_timeliness'
gem 'kaminari'
gem 'meta-tags'
gem 'newrelic_rpm'
gem 'output-templates', '~> 4.6.0', github: 'guidance-guarantee-programme/output-templates'
gem 'pg'
gem 'plek'
gem 'princely', github: 'guidance-guarantee-programme/princely', branch: 'remove-alias-method-chain'
gem 'puma'
gem 'rails', '~> 5.0.2'
gem 'rails-i18n', '~> 5.0.4'
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'scss-lint'
end

group :development do
  gem 'rubocop', '~> 0.42.0', require: false
  gem 'spring'
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'pdf-inspector', require: 'pdf/inspector'
  gem 'shoulda-matchers', '~> 3.0'
  gem 'site_prism'
end

group :staging, :production do
  gem 'rails_12factor'
end
