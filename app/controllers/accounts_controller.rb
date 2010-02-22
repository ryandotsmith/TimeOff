class AccountsController < ApplicationController

  def edit
    @account = current_user.account
  end
end
