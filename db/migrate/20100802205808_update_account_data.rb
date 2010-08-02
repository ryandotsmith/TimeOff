class UpdateAccountData < ActiveRecord::Migration
  def self.up
    Account.all.each do |account|
      account.create_subscription!
      account.set_product_handle!
      account.generate_i_cal_token!
    end
  end

  def self.down
  end
end
