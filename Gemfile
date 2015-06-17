source 'https://rubygems.org'

ruby '2.2.2'

# force Bundler to use HTTPS for github repos
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

gem 'autoprefixer-rails'
gem 'bugsnag'
gem 'foreman'
gem 'gaffe'
gem 'govuk_admin_template', github: 'andrewgarner/govuk_admin_template', branch: 'configurable-analytics'
gem 'jc-validates_timeliness'
gem 'meta-tags'
gem 'output-templates', '~> 1.0', github: 'guidance-guarantee-programme/output-templates'
gem 'princely'
gem 'puma'
gem 'rails', '4.2.2'
gem 'rails-i18n', '~> 4.0.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'launchy'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'scss-lint'
  gem 'web-console', '~> 2.0'
end

group :development do
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'pdf-inspector', require: 'pdf/inspector'
  gem 'shoulda-matchers'
  gem 'site_prism'
end

group :staging, :production do
  gem 'rails_12factor'
end
