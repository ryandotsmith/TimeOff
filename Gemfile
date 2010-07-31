source :gemcutter

gem "rails", "~> 2.3.5"
gem "pg"
gem 'haml', '>=2.2.17'

gem 'chargify'
gem 'authlogic'
gem 'friendly_id'
gem 'sanitize'
gem 'facets','2.5.0', :require => 'facets/dictionary'

gem 'hoptoad_notifier', '2.2.6'
gem 'delayed_job',                 :require => 'delayed_job'
#gem 'logworm_client'

group :test,:cucumber,:development do
  gem 'mongrel'
  gem 'heroku'
  gem 'taps'
  gem 'ruby-debug'
  gem 'autotest-fsevent'
  gem 'autotest-growl'
end

group :test,:cucumber do
  gem 'email_spec', '0.6.3'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'factory_girl'
  gem 'rspec','1.3.0'
  gem 'rspec-rails', '1.3.2'
  gem 'fakeweb'
end
