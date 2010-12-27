class UsersController < ApplicationController
  before_filter :load_account
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :ensure_correct_manager, :only => [:show]

  def new
    @user = @account.users.build
    respond_to do |format|
      format.html { render :layout => 'split' }
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.js   { render :action => 'show.js',  :layout => false }
    end
  end

  def create
    @user = @account.users.build( params[:user] )
    @user.generate_one_time_password!
    if @user.save
      @user.deliver_activation_link
      flash[:notice] = "The new user will receieve an activation email."
      redirect_to edit_account_url(@account)
    else
      render :action => :new, :layout => 'split'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to edit_account_url(current_user.account), :notice => "employee has been updated"
    else
      render :action => :edit
    end
  end

  def destroy
    @user    = User.find(params[:id])
    @account = @user.account
    if @user.destroy
      redirect_to edit_account_path(@account), :notice => "employee was deleted!"
    else
      flash[:error] = "Can not delete owner of account"
      redirect_to :back
    end
  end

  private

  def ensure_correct_manager
    @user = User.find(params[:id])
    unless current_user.manages(@user)
      flash[:notice] = "This user does not belong to your account"
      redirect_to @account
    end
  end

end
