class AddAccountColumnsToDayoff < ActiveRecord::Migration
  def self.up
    add_column :daysoff, :account_id, :integer
  end

  def self.down
    remove_column :daysoff, :account_id
  end
end
