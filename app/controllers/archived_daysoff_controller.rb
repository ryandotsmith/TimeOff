class ArchivedDaysoffController < ApplicationController
  def index
    @archived_daysoff = Dayoff.paginate_by_creation_date(params.dup) 
    respond_to do |format|
      format.js { render :partial => 'daysoff', :locals => {:daysoff => @archived_daysoff}, :layout => false }
    end
  end
end
