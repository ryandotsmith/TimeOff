class CreateDaysoff < ActiveRecord::Migration
  def self.up
    create_table :daysoff do |t|
      t.integer :user_id
      t.integer :state, :default => 0
      t.string :reviewed_by
      t.datetime :reviewed_on
      t.datetime :begin_time
      t.datetime :end_time
      t.string :leave_type
      t.text :description
      t.string :leave_length
      t.string :action_notes
      t.timestamps
    end
  end

  def self.down
    drop_table :daysoff
  end
end
