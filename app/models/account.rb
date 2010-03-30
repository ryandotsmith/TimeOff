class Account < ActiveRecord::Base
  has_many :users
  accepts_nested_attributes_for :users
  validates_uniqueness_of :subdomain,
    :message => Proc.new { |account|
      "^An account with name #{account.subdomain} already exists."
    }
end
