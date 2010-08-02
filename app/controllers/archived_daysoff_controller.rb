class ArchivedDaysoffController < ApplicationController
  def index
    @account = Account.find(params[:account_id])
    @archived_daysoff = Dayoff.paginate_by_creation_date(@account,params.dup)
    respond_to do |format|
      format.js { render :partial => 'daysoff', :locals => {:daysoff => @archived_daysoff}, :layout => false }
    end
  end
end
