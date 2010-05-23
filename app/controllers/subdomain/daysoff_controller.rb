class Subdomain::DaysoffController < ApplicationController
  before_filter :load_account

  def new
    @user   = current_user
    @dayoff = @user.daysoff.build
  end

  def create
    @user   = current_user
    @dayoff = @user.daysoff.build(params[:dayoff]) 
    respond_to do |wants|
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
