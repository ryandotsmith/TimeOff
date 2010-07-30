class Account < ActiveRecord::Base

  DEFAULT_PRODUCT = '0-5-users'

  include DayoffUserMethods
  include SubscriptionHelper::InstanceMethods
  extend  SubscriptionHelper::ClassMethods

  has_friendly_id :company_name, :use_slug => true

  has_many :users
  has_many :daysoff

  accepts_nested_attributes_for :users

  after_create :set_owner!, :set_product_handle!, :generate_i_cal_token!

  def set_owner!
    update_attributes(:owner_id => users.first.id)
  end

  def set_product_handle!
    update_attributes(:product_handle => DEFAULT_PRODUCT)
  end

  def owner
    User.find(self.owner_id)
  end

  def name
    company_name
  end

  def managers
    users.select {|u| u.manager?}
  end

  def can_add_more_users?
    users.count < max_users
  end

  def max_users
    case product_handle
    when "0-5-users"
      5
    when "6-25-users"
      25
    end
  end

  def generate_i_cal_token!
    self.update_attributes(:i_cal_token => Authlogic::Random.friendly_token)
  end

end
