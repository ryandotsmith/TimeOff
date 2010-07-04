class Account < ActiveRecord::Base

  include DayoffUserMethods

  has_friendly_id :company_name, :use_slug => true

  has_many :users
  has_many :daysoff

  accepts_nested_attributes_for :users

  after_create :set_owner!

  def set_owner!
    self.owner_id = self.users.first.id  
    self.save
  end

  def owner
    User.find(self.owner_id)
  end

  def name
    company_name
  end

end
