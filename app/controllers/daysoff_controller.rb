class DaysoffController < ApplicationController
  before_filter :load_account
  before_filter :redirect_if_user_not_in_account, :only => [:new,:create]
  layout 'split', :only => [:new]

  def index
    user = User.find_by_id(params[:user_id])
    if user
      @daysoff =  user.daysoff.pending
      @daysoff << user.daysoff.approved
      @daysoff.flatten!
    else
      @daysoff = @account.daysoff
    end
    respond_to do |wants|
      @daysoff.map! {|d| d.to_fullcalendar_format(current_user) }
      wants.js { render :text =>  @daysoff.to_json}
    end
  end

  def show
    @dayoff = Dayoff.find(params[:id])
    @user   = current_user
    respond_to do |format|
      format.html
      format.js   { render :action => 'show.js.haml', :layout => false }
    end
  end

  def new
    @user   = User.find(params[:user_id])
    @dayoff = @user.daysoff.build
    respond_to do |format|
      format.html
      format.js { render :action => 'new.js.haml', :layout => false}
    end
  end

  def create
    @user   = User.find(params[:user_id])
    @dayoff = @user.daysoff.build(params[:dayoff])
    respond_to do |format|
      @dayoff.account = @account
      if @dayoff.save
        Delayed::Job.enqueue(NewDayoffMailJob.new(@dayoff.id))
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
    @user   = @dayoff.user
    DayoffMailer.deliver_deleted_message(@dayoff) if @dayoff.delete
    redirect_to @user, :notice => "Deleted!"
  end

  private
  def redirect_if_user_not_in_account
    unless @account.users.include?(User.find(params[:user_id]))
      flash[:notice] = "User is not in your account"
      redirect_to new_user_dayoff_path(current_user)
    end
  end

end
