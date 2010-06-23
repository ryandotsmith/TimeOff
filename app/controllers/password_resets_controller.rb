class PasswordResetsController < ApplicationController
 # Method from: http://github.com/binarylogic/authlogic_example/blob/master/app/controllers/application_controller.rb
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
    render :action => 'new', :layout => 'split'
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      redirect_to :back, :notice  => "Instructions to reset your password have been emailed" 
    else
      flash[:error] = "No user was found with email address #{params[:email]}"
      render :action => :new, :layout => 'split'
    end
  end

  def edit
    render :action => 'edit', :layout => 'user_sessions'
  end

  def update
    @user.password              = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      flash[:success] = "Your password was successfully updated"
      redirect_to @user.account
    else
      render :action => :edit, :layout => 'user_sessions'
    end
  end


  private
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:error] = "We're sorry, but we could not locate your account"
      redirect_to root_url
    end
  end

end
