class EmailListenerController < ApplicationController
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
