class UserMailer < ActionMailer::Base
  def activation_link(user)
    subject       "Activate your Time Off Account"
    from          "Time Off System <noreply@timeoffhq.com>"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token)
  end
end
