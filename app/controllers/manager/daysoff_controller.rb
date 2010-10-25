class Manager::DaysoffController < ApplicationController

  before_filter :load_account

  def create
    @user   = User.find(params[:user_id])
    @dayoff = @user.daysoff.build(params[:dayoff])
    respond_to do |format|
      @dayoff.account = @account
      if @dayoff.save
        Delayed::Job.enqueue(NewApprovedDayoffMailJob.new(@dayoff.id))
        format.html { redirect_to edit_account_path(@account),:notice => 'TimeOff was added for the employee.' }
      else
        flash[:error] = 'Unable to add timeoff for his employee' 
        format.html { redirect_to edit_account_path(@account) }
      end
    end
  end

end
