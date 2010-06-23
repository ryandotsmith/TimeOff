class PasswordResetMailJob < Struct.new(:user_id)
  def perform 
    UserMailer.deliver_password_reset_instructions(User.find(user_id))
  end
end
