class ChangeColumnTypeOnUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :date_of_hire
    add_column :users, :date_of_hire, :date
  end

  def self.down
  end
end
