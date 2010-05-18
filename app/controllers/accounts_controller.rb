class AccountsController < ApplicationController

  def new
    @account = Account.new
    @account.users.build
  end

  def create
    @account = Account.new( params[:account] )
    respond_to do |wants|
      if @account.save and UserSession.create(@account.owner,true)
        wants.html { redirect_to edit_subdomain_account_url(@account,@account)}
      else
        wants.html { render :action => 'new' }
      end
    end
  end

end
