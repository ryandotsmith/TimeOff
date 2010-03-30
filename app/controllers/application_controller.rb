class ApplicationController < ActionController::Base

  helper :all
  protect_from_forgery 

  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  include UserMethods
  include AccountMethods

end
