class Subdomain::AccountsController < ApplicationController

  before_filter :require_user, :only => [:update,:edit,:show,:destroy]

  def show
    @account = current_account
  end

  def edit
    @account = current_account
  end

end
