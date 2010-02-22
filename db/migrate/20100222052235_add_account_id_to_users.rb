class AddAccountIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :account_id, :integer
  end

  def self.down
  end
end
