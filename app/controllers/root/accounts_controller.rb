class Root::AccountsController < ApplicationController
  before_filter :require_user
  before_filter :authenticate
  def index
    @accounts = Account.all(:include => [{:users => :daysoff}])
    @jobs     = Delayed::Job.all
  end
  private
  def authenticate
    redirect_to root_url unless current_user.email == "this.ryansmith@gmail.com"
  end
end
