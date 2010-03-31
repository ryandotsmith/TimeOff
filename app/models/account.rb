class Account < ActiveRecord::Base

  has_many :users
  accepts_nested_attributes_for :users

  validates_uniqueness_of :subdomain,
    :message => Proc.new { |account|
      "^An account with name #{account.subdomain} already exists."
    }

  after_create :set_owner!

  def set_owner!
    self.owner_id = self.users.first.id  
    self.save
  end

  def owner
    User.find(self.owner_id) 
  end


end
