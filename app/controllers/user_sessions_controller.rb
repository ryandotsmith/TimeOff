class UserSessionsController < ApplicationController
  layout 'user_sessions'
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      user    = @user_session.user
      @account = Account.find(user.account_id)
      if @account.has_active_subscription?
        redirect_to @account
      else
        if user.account_owner?
          redirect_to edit_account_billing_path(@account)
        else
          redirect_to request_activation_account_billing_path(@account)
        end
      end
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to new_user_session_url, :notice => 'Goodbye'
  end

end
