class AddColumnsToUsersTable < ActiveRecord::Migration
  def self.up
    add_column :users, :max_etc,      :integer, :default => 10
    add_column :users, :max_personal, :integer, :default => 10
    add_column :users, :max_vacation, :integer, :default => 10
  end

  def self.down
  end
end
