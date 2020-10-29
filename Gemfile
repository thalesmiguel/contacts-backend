# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'sqlite3', '~> 1.4'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-byebug', '~> 3.9'
  gem 'rspec-rails', '~> 4.0'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'reek', '~> 6.0.0'
  gem 'rubocop', '~> 0.93'
  gem 'rubocop-rails', '~> 2.8'
  gem 'spring', '~> 2.1'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
