class CreateBlackOutDays < ActiveRecord::Migration
  def self.up
    create_table :black_out_days do |t|
      t.date :date
      t.string :description
      t.belongs_to :account
      t.timestamps
    end
  end

  def self.down
    drop_table :black_out_days
  end
end
