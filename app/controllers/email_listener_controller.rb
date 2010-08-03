class EmailListenerController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def listen
    email = Email.new(
      :to       => params[:to],
      :from     => params[:from],
      :subject  => params[:subject],
      :body     => params[:text]
    )

    if email.approved?
      dayoff.approve(manager)
    elsif email.denied?
      dayoff.deny(manager)
    end
  end

end
