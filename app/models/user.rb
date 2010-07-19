class User < ActiveRecord::Base

  attr_accessible   :email, :first_name, :last_name,:password,
                    :password_confirmation, :openid_identifier,
                    :max_vacation, :max_personal, :manager

  include DayoffUserMethods
  acts_as_authentic

  belongs_to :account
  has_many :daysoff

  def deliver_activation_link
    reset_perishable_token!
    UserMailer.deliver_activation_link(self)
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Delayed::Job.enqueue(PasswordResetMailJob.new(self.id))
  end

  def active?
    active
  end

  def activate!
    self.active = true
    save
  end

  def generate_one_time_password!
    self.password = 'onetime'
    self.password_confirmation = 'onetime'
  end

  def name
    first_name + " " + last_name
  end

  def to_s
    return name + " (manager)" if manager?
    name
  end

  def account_owner?
    self.account.owner == self
  end

  def manager?
    root? || account_owner? || manager
  end

  def root?
    email == "this.ryansmith@gmail.com"
  end

end
