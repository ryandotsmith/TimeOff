class User < ActiveRecord::Base

  acts_as_authentic do |configure|
  end

  def generate_one_time_password!
    self.password = 'onetime'
    self.password_confirmation = 'onetime'
  end

  def name
    first_name + " " + last_name
  end

end
