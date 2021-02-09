source 'https://rubygems.org'
ruby "2.7.2"

# Rails
gem 'rails', '~> 5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4'
gem 'sass-rails', '~> 6'
gem 'uglifier'
gem 'jquery-rails'

gem 'uuid'
gem 'rmagick'
gem 'httparty'
gem 'omniauth-github'
gem 'github_api'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'fog-aws'
gem 'haml'
gem 'simple_form'
gem 'carrierwave'

gem "bootsnap", ">= 1.4.6", require: false

group :production do
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2", require: false
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'test-unit'
  gem 'spin'
  gem 'mocha'
  gem 'fakeweb'
  gem 'factory_bot_rails'
  gem 'shoulda'
  gem 'shoulda-matchers'
end
