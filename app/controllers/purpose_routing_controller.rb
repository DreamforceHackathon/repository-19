class PurposeRoutingController < ApplicationController

  def create
    @incoming_call = IncomingCall.find(params[:incoming_call_id])
    response = Twilio::TwiML::Response.new do |r|
      r.Say "You pressed #{params["Digits"]}."
      r.Say "I found incoming call number #{@incoming_call.id}."
    end
    render xml: response.text
  end

end
