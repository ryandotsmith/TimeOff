class ApplicationController < ActionController::Base

  helper :all
  protect_from_forgery

  filter_parameter_logging :password, :password_confirmation

  helper_method :current_user_session, :current_user
  helper_method :current_account
  helper_method :current_account_from_subdomain
  helper_method :load_account


  private

    def current_account
      @account ||= Account.find_by_company_name(params[:id])
    end

    def current_account_from_subdomain
      subdomain = request.subdomains.first
      subdomain && Account.find_by_subdomain(subdomain)
    end

    def load_account
      @account = current_user.account if current_user
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to current_user.account
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def sign_out
      reset_session
      @current_user = nil
    end

end
