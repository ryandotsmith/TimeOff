class DaysoffController < ApplicationController
  before_filter :load_account
  layout 'split', :only => [:new]

  def index
    user = User.find_by_id(params[:user_id])
    if user
      @daysoff = user.daysoff
    else
      @daysoff = @account.daysoff
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
    respond_to do |format|
      format.html 
    end
  end

  def create
    @user   = current_user
    @dayoff = @user.daysoff.build(params[:dayoff]) 
    respond_to do |format|
      @dayoff.account = @account
      if @dayoff.save
        format.html { redirect_to @account,:notice => 'Request submitted! Supervisors have been notified.'  }
      else
        format.html { render :action => 'new', :layout => 'split' }
      end
    end
  end

  def update
    @dayoff = Dayoff.find(params[:id])    
    respond_to do |wants|
      if @dayoff.update_attributes(params[:dayoff])
        if params[:commit] == 'approve'
          @dayoff.approve(current_user)
          flash[:notice] = "Request approved. An email has been sent to the employee."
        elsif params[:commit] == 'deny'
          @dayoff.deny(current_user)
          flash[:notice] = "Request denied. An email has been sent to the employee."
        end
        wants.html { redirect_to @account }
      else
        wants.html { render :action => 'show' }
      end
    end
  end

  def destroy
    @dayoff = Dayoff.find(params[:id])
    DayoffMailer.deliver_deleted_message(@dayoff) if @dayoff.delete
    redirect_to @account
  end

end
