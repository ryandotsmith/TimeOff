class ActivationsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]

  def new
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?
  end

  def create
    @user = User.find(params[:id])
    raise Exception if @user.active?
    if @user.activate!
      redirect_to @user.account
    else
      render :action => :new
    end
  end

end
