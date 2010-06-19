class AddDateToHireColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :date_of_hire, :datetime
  end

  def self.down
    remove_column :users, :date_of_hire
  end
end
