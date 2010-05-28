require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
end

ActiveSupport::Inflector.inflections do |inflect|
 inflect.irregular 'dayoff', 'daysoff'
end

ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(:default => '%m/%d/%Y')
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(:default => '%m/%d/%Y')

require 'extended_float'
require 'extended_date'
