class DaysoffController < ApplicationController
  before_filter :load_account
  layout 'split', :only => [:new]

  def index
    user = User.find_by_id(params[:user_id])
    if user
      @daysoff = user.daysoff.approved  
    else
      @daysoff = @account.daysoff.approved  
    end
    respond_to do |wants|
      @daysoff.map!(&:to_fullcalendar_format)
      wants.js { render :text =>  @daysoff.to_json}
    end
  end

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
        wants.html { redirect_to @account,:notice => 'Request submitted! Supervisors have been notified.'  }
      else
        flash[:alert]  =  'something went wrong'
        wants.html { render :action => 'new' }
      end
    end
  end

  def update
    @dayoff = Dayoff.find(params[:id])    
    respond_to do |wants|
      if @dayoff.update_attributes(params[:dayoff])
        @dayoff.approve(current_user) if params[:approved] == 'true'
        wants.html { redirect_to @account,:notice => 'request updated' }
      else
        wants.html { render :action => 'show' }
      end
    end
  end

end
