class AccountsController < ApplicationController
  before_filter :require_user, :only => [:update,:edit,:show,:destroy]

  def show
    @account = Account.find(params[:id])
  end

  def edit
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
    @account.users.build
    render :new, :layout => 'split'
  end

  def create
    @account = Account.new( params[:account] )
    respond_to do |wants|
      if @account.save 
        UserSession.create(@account.owner,true)
        wants.html { redirect_to edit_account_url(@account)}
      else
        wants.html { render :action => 'new',:layout => 'split' }
      end
    end
  end

end
