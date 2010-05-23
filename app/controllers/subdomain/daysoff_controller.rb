class Subdomain::DaysoffController < ApplicationController
  before_filter :load_account
  def new
    @user   = current_user
    @dayoff = @user.daysoff.build
  end
end
