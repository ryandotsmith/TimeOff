class AddICalTokenToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :i_cal_token, :string
  end

  def self.down
    remove_column :accounts, :i_cal_token
  end
end
