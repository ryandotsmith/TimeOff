class Account < ActiveRecord::Base

  DEFAULT_PRODUCT = '0-5-users'

  include DayoffUserMethods

  has_friendly_id :company_name, :use_slug => true

  has_many :users, :dependent => :destroy
  has_many :daysoff
  has_many :black_out_days, :dependent => :destroy
  has_one  :owner, :class_name => "User"

  accepts_nested_attributes_for :users

  after_create :set_product_handle!, :generate_i_cal_token!

  def generate_i_cal_token!
    self.update_attributes(:i_cal_token => Authlogic::Random.friendly_token)
  end

  def dayoff_types
    [:vacation, :personal, :misc]
  end

  def owner=(user)
    user.update_attribute :manager, true
    update_attribute :owner_id, user.id
  end

  def set_product_handle!
    update_attributes(:product_handle => DEFAULT_PRODUCT)
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

end
