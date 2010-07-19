#require File.dirname(__FILE__) + "/../spec_helper"
#require "steak"
#require 'capybara/rails'

#Spec::Runner.configure do |config|
  #config.include Capybara
  #config.use_transactional_fixtures = false

  #config.before(:each) do
    #if options[:js]
      #Capybara.current_driver = :selenium if options[:js]
      #DatabaseCleaner.strategy = :truncation
    #else
      #DatabaseCleaner.strategy = :transaction
    #end
    #DatabaseCleaner.start
  #end

  #config.after(:each) do
    #Capybara.use_default_driver if options[:js]
    #DatabaseCleaner.clean
  #end

#end

## Put your acceptance spec helpers inside /spec/acceptance/support
#Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
