ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec/autorun'
require 'spec/rails'

require 'capybara/rails'
require 'capybara/dsl'

Spec::Runner.configure do |config|
end

MONDAY_THIS_YEAR = Date.new(2010,1,4)#monday
TUESDAY          = Date.new(2010,1,5)#monday
FRIDAY           = Date.new(2010,1,8)#monday

