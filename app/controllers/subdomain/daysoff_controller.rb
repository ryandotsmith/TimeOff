class Subdomain::DaysoffController < ApplicationController
  before_filter :load_account

  def show
    @dayoff = Dayoff.find(params[:id])
    @user   = current_user
  end

  def new
    @user   = current_user
    @dayoff = @user.daysoff.build
  end

  def create
    @user   = current_user
    @dayoff = @user.daysoff.build(params[:dayoff]) 
    respond_to do |wants|
      @dayoff.account = @account
      if @dayoff.save
        flash[:notice] = 'Request submitted! Supervisors have been notified.'
        wants.html { redirect_to subdomain_account_url(@account,@account) }
      else
        flash[:alert]  =  'something went wrong'
        wants.html { render :action => 'new' }
      end
    end
  end

end
