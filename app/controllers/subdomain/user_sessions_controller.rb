class Subdomain::UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  before_filter :require_account
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to subdomain_account_url(current_account,current_account)
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = 'Goodbye'
    redirect_to new_subdomain_user_session_url(current_account)
  end

  private
  def require_account
    redirect_to new_system_account_url if current_account.nil?
  end

end

