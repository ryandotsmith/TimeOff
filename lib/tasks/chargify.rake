require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

namespace :chargify do
  task :import do
    Account.all.each do |account|
      account.create_subscription!
      account.set_product_handle!
      account.generate_i_cal_token!
    end
  end
end
