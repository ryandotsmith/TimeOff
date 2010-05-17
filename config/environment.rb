RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.gem 'haml',              :version => '>=2.2.17', :lib => 'haml'
  config.gem 'formtastic',        :version => '>= 0.9.7'
  config.gem 'authlogic'
  config.gem "subdomain_routes",  :version => '>= 0.3.1'
  config.gem 'friendly_id',       :version => '>= 2.2.7'
end
