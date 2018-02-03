source 'https://rubygems.org'

ruby "2.5.0"

# Rails
gem 'rails', '4.2.10'
gem 'jquery-rails'
gem 'coffee-script'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'protected_attributes'

# Web server (see Procfile)
gem 'puma'

# App dependencies
gem 'firehose'
gem 'uuid'
gem "rmagick", "2.16.0", :require => 'RMagick'
gem 'httparty'
gem 'omniauth-github'
gem 'github_api'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'fog'
gem 'haml'
gem 'simple_form'
gem 'carrierwave'
gem 'pg', '~> 0.21.0'

group :production do
  # heroku
  gem 'rails_12factor'
  # monitoring
  gem 'newrelic_rpm'
end

gem 'dotenv-rails', groups: [:development, :test]

group :development do
  # running Procfile
  gem 'foreman'
  gem 'pry-remote'
end

group :test do
  gem 'test-unit'
  gem 'spin'
  gem 'mocha', :require => false
  gem 'fakeweb'
  gem 'factory_bot_rails'
  gem 'shoulda', :require => false
  gem 'shoulda-matchers', :require => false
end
