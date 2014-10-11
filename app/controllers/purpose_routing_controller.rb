class PurposeRoutingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @incoming_call = IncomingCall.find(params[:incoming_call_id])

    digits = params["Digits"]
  
    response = Twilio::TwiML::Response.new do |r|
      if digits.blank?
        r.Gather timeout: 10, numDigits: 1, method: "POST" do
          r.Say "What would you like to do?"
          3.times do
            r.Say "Press 1 to practice."
            r.Say "Press 2 to provide feedback."
            r.Pause length: 1
          end
        end
      else
        r.Say "You pressed #{params["Digits"]}."
        r.Say "I found incoming call number #{@incoming_call.id}."
      end
    end
    render xml: response.text
  end

end
