class EmailListenerController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def listen
    Email.new(
      :to       => params[:to],
      :from     => params[:from],
      :subject  => params[:subject],
      :body     => params[:text]
    ).act!
    render :nothing => true, :status => :ok
  end

end
