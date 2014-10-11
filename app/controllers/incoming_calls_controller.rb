class IncomingCallsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @practice_phone_number = PracticePhoneNumber.find(params[:practice_phone_number_id])
    @user = @practice_phone_number.users.find_by(phone_number: params["From"])
    response = Twilio::TwiML::Response.new do |r|
      r.Play ActionController::Base.helpers.asset_url("cash_register.mp3")
      if @user.nil?
        r.Say "You are not authorized to call for practice on this number. Goodbye."
      else
        @incoming_call = @practice_phone_number.incoming_calls.create!(twilio_sid: params["CallSid"], user: @user)
        r.Redirect incoming_call_purpose_routing_path(@incoming_call), method: "POST"
      end
    end
    render xml: response.text
  end

end
