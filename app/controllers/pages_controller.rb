class PagesController < HighVoltage::PagesController
 before_filter :redirect_to_account
  private
  def redirect_to_account
    redirect_to current_user.account if current_user
  end
end
