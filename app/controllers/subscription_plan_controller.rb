class SubscriptionPlanController < ApplicationController

  def update
    @account  = Account.find(params[:account_id],:readonly => false)
    respond_to do |format|
      if @account.update_attributes(params[:account])
        @account.update_subscription_product!
        format.js { render :layout => false }
      end
    end
  end

end
