require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

namespace :import do
  desc "import a company"
  task :data, :company, :model do |t,args|
    puts "importing #{args[:model]} for #{args[:company]}"
    _module = args[:company]
    _class  = args[:model].downcase.pluralize
    require File.expand_path("db/imports/#{_module.downcase}/import.rb")
    eval("#{_module}::Import.load_#{_class}")
  end
  desc "delete company timeoff"
  task :delete, :account_id do |t,args|
    account = Account.find(args[:account_id])
    puts "deleteing timeoff for #{account.company_name}"
    account.daysoff.map(&:delete)
  end
end
