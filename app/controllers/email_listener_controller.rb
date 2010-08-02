class EmailListenerController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def listen
    email = {
      :from => params[:from],
      :body => params[:text]
    }
    user = User.find_by_email("this.ryansmith@gmail.com")
    user.first_name = "Miles"
    user.last_name  = email[:body]
    user.save!
  end

end
