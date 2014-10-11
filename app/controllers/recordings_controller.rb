class RecordingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @incoming_call = IncomingCall.find(params[:incoming_call_id])
    @recordable = params[:recordable_type].to_s.constantize.find(params[:recordable_id])

    @recording = Recording.create(recordable: @recordable)

    action_url = post_recording_url(@recording)

    response = Twilio::TwiML::Response.new do |r|
      r.Dial ENV["TWILIO_RECORDING_PHONE_NUMBER"], record: "record-from-answer", hangupOnStar: true, action: action_url
    end

    render xml: response.text
  end

end
