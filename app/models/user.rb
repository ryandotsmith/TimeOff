class User < ActiveRecord::Base

  acts_as_authentic

  belongs_to :account

  def generate_one_time_password!
    self.password = 'onetime'
    self.password_confirmation = 'onetime'
  end

  def name
    name = first_name + " " + last_name
  end

  def to_s
    return name + " (account owner)" if account_owner? 
    name
  end

  def account_owner?
    !Account.find_by_owner_id(self.id).nil? 
  end

end
