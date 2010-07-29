class AddSubscriptionColumnsToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :customer_id,     :integer
    add_column :accounts, :subscription_id, :integer
    add_column :accounts, :product_handle,  :string
  end

  def self.down
    remove_column :accounts, :product_handle
    remove_column :accounts, :subscription_id
    remove_column :accounts, :customer_id
  end
end
