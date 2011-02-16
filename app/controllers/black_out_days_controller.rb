class BlackOutDaysController < ApplicationController
  before_filter :load_account

  def new
    @black_out_day = @account.black_out_days.build
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def create
    @black_out_day = @account.black_out_days.build(params[:black_out_day])
    @black_out_day.save
    respond_to do |format|
      format.js { render :action => 'create.js.erb', :layout => false }
    end
  end

  def destroy
    @black_out_day = BlackOutDay.find(params[:id]).destroy
    respond_to do |format|
      format.js { render :action => 'destroy.js.erb', :layout => false }
    end
  end

end
