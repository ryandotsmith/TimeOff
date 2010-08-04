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
      email.dayoff.approve(manager)
    elsif email.denied?
      email.dayoff.deny(manager)
    end
  end

end
