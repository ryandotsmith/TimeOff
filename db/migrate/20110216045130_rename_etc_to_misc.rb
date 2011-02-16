class RenameEtcToMisc < ActiveRecord::Migration
  def self.up
    rename_column :users, :max_etc, :max_misc
  end

  def self.down
    rename_column :users, :max_misc, :max_etc
  end
end
