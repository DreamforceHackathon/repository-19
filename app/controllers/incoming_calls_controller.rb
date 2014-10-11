class IncomingCallsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @practice_phone_number = PracticePhoneNumber.find(params[:practice_phone_number_id])
    @user = @practice_phone_number.users.find_by(phone_number: params["From"])

    if @user.nil?
      response = Twilio::TwiML::Response.new do |r|
        r.Say "You are not authorized to call for practice on this number. Goodbye."
      end

      render xml: response.text and return
    else
      @incoming_call = @practice_phone_number.incoming_calls.new(twilio_sid: params["CallSid"])
      response = Twilio::TwiML::Response.new do |r|
        r.Say "Beep. Beep. Beep."
        r.Gather timeout: 60, numDigits: 1, method: "GET" do
          r.Say "What would you like to do?"
          3.times do
            r.Say "Press 1 to practice."
            r.Say "Press 2 to provide feedback."
            r.Pause length: 1
          end
        end
      end

      render xml: response.text and return
    end

  end

end
