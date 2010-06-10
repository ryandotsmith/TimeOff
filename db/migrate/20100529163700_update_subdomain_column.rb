class UpdateSubdomainColumn < ActiveRecord::Migration
  def self.up
    rename_column :accounts, :subdomain, :company_name
  end

  def self.down
  end
end
