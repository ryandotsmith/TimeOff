class Account < ActiveRecord::Base
  include DayoffUserMethods
  has_friendly_id :company_name
  has_many :users
  has_many :daysoff
  accepts_nested_attributes_for :users

  validates_uniqueness_of :company_name,
    :message => Proc.new { |account|
      "^An account with name #{account.company_name} already exists."
    }

  after_create :set_owner!

  def set_owner!
    self.owner_id = self.users.first.id  
    self.save
  end

  def owner
    User.find(self.owner_id) 
  end

  def to_param
    company_name 
  end

  def name
    company_name
  end

end
