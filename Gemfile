# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in gemtest.gemspec
gemspec

rails_min_version = ENV.fetch('EARTHLY_RAILS_VERSION')
rails_max_version = (rails_min_version.split('.').first.to_i + 1).to_s

# ORMs
gem 'activerecord', "~> #{rails_min_version}", "< #{rails_max_version}"
# gem 'bson_ext', '~> 1.3'

# Tests
gem 'capybara'
gem 'capybara-screenshot'
gem 'database_cleaner-active_record'
gem 'factory_girl_rails'
gem 'mocha', '~> 0.13.0'
gem 'nokogiri', '~> 1.12.0' # Version 1.12.0 fixes error "uninitialized constant Nokogiri::HTML4"
gem 'responders'
gem 'rubocop'
gem 'shoulda'
if Gem::Version.new(rails_min_version) >= Gem::Version.new('6.0.0')
  gem 'sqlite3', '~> 1.4'
else
  gem 'sqlite3', '~> 1.3.13'
end
gem 'test-unit'
gem 'timecop'
# gem 'debugger'
