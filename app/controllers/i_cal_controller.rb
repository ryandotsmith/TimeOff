class ICalController < ApplicationController

  def index
  end

  def show
    @account = Account.find_by_i_cal_token(params[:id], :include => :daysoff)
    @cal     = Icalendar::Calendar.new
    @daysoff = @account.daysoff.map {|d| d.to_icalendar_format(@cal)}
    @cal.publish

    respond_to do |format|
      format.ics { render :text => @cal.to_ical , :mime_type => 'text/calendar'}
    end
  end
end
