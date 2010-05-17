class AccountsController < ApplicationController

  before_filter :require_user, :only => [:update,:edit,:show,:destroy]

  def show
    @account = current_account
  end

  def new
    @account = Account.new
    @account.users.build
  end

  def create
    @account = Account.new( params[:account] )
    respond_to do |wants|
      if @account.save
        wants.html { redirect_to edit_subdomain_account_path(@account,@account)}
      else
        wants.html { render :action => 'new' }
      end
    end
  end

  def edit
    @account = current_account
  end

end
