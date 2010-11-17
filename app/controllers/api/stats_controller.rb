class Api::StatsController < ApplicationController
  def counts
    data = {
      :accounts => Account.count, 
      :users    => User.count, 
      :daysoff  => Dayoff.count ,
      :last_account => {:name => Account.last.company_name, :email => Account.last.owner.email}
    }.to_json
    respond_to do |format|
      format.json { render :json => data } 
    end
  end
end
