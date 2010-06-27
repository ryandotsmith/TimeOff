class UsersController < ApplicationController
  before_filter :load_account
  before_filter :require_user, :only => [:show, :edit, :update]

  layout 'split', :only => [:new]

  def new
    @user = @account.users.build
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = @account.users.build( params[:user] )
    @user.generate_one_time_password!
    if @user.save
      @user.deliver_activation_link
      flash[:notice] = "The new user will receieve an activation email."
      redirect_to edit_account_url(@account)
    else
      render :action => :new
    end
  end

  def update
    @user = User.find(params[:id])# makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      redirect_to edit_account_url(current_user.account), :notice => "employee has been updated"
    else
      render :action => :edit
    end
  end

end
