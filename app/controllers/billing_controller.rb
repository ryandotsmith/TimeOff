class BillingController < ApplicationController

  def edit
    @account     = Account.find(params[:account_id])
    @credit_card = CreditCard.new
    @products    = Account.available_products
    respond_to do |format|
      format.html
      format.js   { render :action => 'new.js.haml', :layout => false }
    end
  end

  def update
    @account     = Account.find(params[:account_id],:readonly => false)
    @credit_card = CreditCard.new(params[:credit_card])
    respond_to do |format|
      if @account.update_credit_card!(@credit_card)
        flash[:notice] = "Account Subscription Successfully Updated"
        format.html { redirect_to edit_account_billing_url(@account) }
      else
        flash[:error] = @account.errors.full_messages.join("<br />")
        format.html { redirect_to edit_account_billing_url(@account) }
      end
    end
  end

end
