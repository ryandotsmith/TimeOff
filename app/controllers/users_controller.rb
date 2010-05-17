class UsersController < ApplicationController
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = current_account.users.build
  end
  
  def create
    @user = current_account.users.build( params[:user] )
    @user.generate_one_time_password!

    if @user.save
      flash[:notice] = "a new user was added to your account"
      redirect_to edit_subdomain_account_url(current_account,current_account)
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
end
