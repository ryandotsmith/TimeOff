class AddDomainColumnsToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :google_apps_domain, :text
    add_column :accounts, :subdomain, :string
  end

  def self.down
    remove_column :accounts, :subdomain
    remove_column :accounts, :google_apps_domain
  end
end
