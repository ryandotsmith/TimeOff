ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec/autorun'
require 'spec/rails'

Spec::Runner.configure do |config|

  config.use_transactional_fixtures = true
  DatabaseCleaner.strategy = :transaction

  #config.before(:each) do
    #if options[:js]
      #Capybara.current_driver = :selenium
      #DatabaseCleaner.strategy = :truncation
    #else
      #DatabaseCleaner.strategy = :transaction
    #end
    #DatabaseCleaner.start
  #end

  #config.after(:each) do
    #if options[:js]
      #Capybara.use_default_driver
    #end
    #DatabaseCleaner.clean
  #end

end

MONDAY_THIS_YEAR = Date.new(2010,1,4)#monday
TUESDAY          = Date.new(2010,1,5)#monday
FRIDAY           = Date.new(2010,1,8)#monday

