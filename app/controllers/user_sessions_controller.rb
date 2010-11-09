class UserSessionsController < ApplicationController
  layout 'user_sessions'
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    authenticate_with_google_apps "wonderset.com" do |profile|
      @user = User.find_by_email!(profile[:email])
      @user_session = UserSession.create!(@user)
      @account = Account.find(@user.account_id)
      redirect_to account_path @account
    end
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      user = @user_session.user
      @account = Account.find(user.account_id)
      redirect_to @account
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to new_user_session_url, :notice => 'Goodbye'
  end

end
