source :gemcutter

gem "rails", "~> 2.3.5"
gem "sqlite3-ruby", :require => "sqlite3"
gem 'haml',               '>=2.2.17'
gem 'formtastic',         '>= 0.9.7'
gem 'authlogic'
gem "subdomain_routes",   '>= 0.3.1'
gem 'friendly_id',        '>= 2.2.7'

group :development do
  # bundler requires these gems in development
  # gem "rails-footnotes"
end

group :test do
  gem 'factory_girl',      '1.2.4'
  gem 'rspec',             '1.3.0' 
  gem 'rspec-rails',       '1.3.2' 
end

group :cucumber do
  gem 'factory_girl',      '1.2.4'
  gem 'cucumber-rails',    '0.3.0' 
  gem 'database_cleaner',  '0.5.0' 
  gem 'webrat',            '0.7.0' 
  gem 'rspec',             '1.3.0' 
  gem 'rspec-rails',       '1.3.2' 
end
