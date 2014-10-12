class RecordingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @incoming_call = IncomingCall.find_by(id: params[:incoming_call_id])

    recordable_type, recordable_id = params[:recordable_type], params[:recordable_id]

    if recordable_type && recordable_id
      @recordable = recordable_type.to_s.constantize.find_by(id: recordable_id)
    end

    response = Twilio::TwiML::Response.new do |r|
      if @recordable
        @recording = Recording.create(recordable: @recordable)
        action_url = post_recording_url(@recording)
        r.Dial ENV["TWILIO_RECORDING_PHONE_NUMBER"], record: "record-from-answer", hangupOnStar: true, action: action_url
      else
        r.Play ActionController::Base.helpers.asset_url("say_problem_with_request.mp3")
      end
    end

    render xml: response.text
  end

end
