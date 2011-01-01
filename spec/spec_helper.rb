ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec/autorun'
require 'spec/rails'

require 'capybara/rails'
require 'capybara/dsl'

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
end

class Spy

  def initialize
    @set = false
  end

  def set
    @set = true
  end

  def set?
    @set == true 
  end

  def remove
    @set = false
  end

end

def spy
  @spy ||= Spy.new
end

MONDAY_THIS_YEAR = Date.new(2010,1,4)#monday
TUESDAY          = Date.new(2010,1,5)#monday
FRIDAY           = Date.new(2010,1,8)#monday
