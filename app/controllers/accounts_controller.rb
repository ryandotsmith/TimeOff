class AccountsController < ApplicationController

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
        UserSession.create(@account.owner)
        wants.html { redirect_to edit_account_url( :subdomain => @account.subdomain )}
      else
        wants.html { render :action => 'new' }
      end
    end
  end

  def edit
    @account = current_account
  end

end
