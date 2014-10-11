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
      @incoming_call = @practice_phone_number.incoming_calls.create!(twilio_sid: params["CallSid"], user: @user)
      response = Twilio::TwiML::Response.new do |r|
        r.Play ActionController::Base.helpers.asset_url("cash_register.mp3")
        r.Gather timeout: 10, numDigits: 1, action: incoming_call_purpose_routing_path(@incoming_call), method: "POST" do
          r.Say "What would you like to do?"
          3.times do
            r.Say "Press 1 to practice."
            r.Say "Press 2 to provide feedback."
            r.Pause length: 1
          end
        end
      end

      puts response.text

      render xml: response.text and return
    end

  end

end
