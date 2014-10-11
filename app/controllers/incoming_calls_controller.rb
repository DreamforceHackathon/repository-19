class IncomingCallsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @practice_phone_number = PracticePhoneNumber.find(params[:practice_phone_number_id])
    @user = User.find_by(phone_number: params["CallSid"])

    if @user.nil?
      response = Twilio::TwiML::Response.new do |r|
        r.Say "You are not authorized to call this number. Goodbye."
      end

      render xml: response.text and return
    else
      @incoming_call = @practice_phone_number.incoming_calls.new(twilio_sid: params["CallSid"])
      response = Twilio::TwiML::Response.new do |r|
        r.Say "Beep. Beep. Beep."
        r.Say "What would you like to do?"
      end

      render xml: resopnse.text and return
    end

  end

end
