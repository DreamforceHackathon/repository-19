class RecordingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @incoming_call = IncomingCall.find(params[:incoming_call_id])
    @recordable = params[:recordable_type].to_s.constantize.find(params[:recordable_id])

    stub_url = "http://soundbible.com/grab.php?id=2080&type=mp3"

    response = Twilio::TwiML::Response.new do |r|
      r.Play ActionController::Base.helpers.asset_url("short_beep.mp3")
    end

    render xml: response.text
  end

end
