class PromptPreRecordingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @incoming_call = IncomingCall.find(params[:incoming_call_id])
    @prompt = Prompt.find(params[:prompt_id])

    response = Twilio::TwiML::Response.new do |r|
      r.Say @prompt.content
      r.Pause length: 2
      r.Redirect incoming_calls_recordings_path(@incoming_call, recordable_type: @prompt.class.to_s, recordable_id: @prompt.id)
    end

    render xml: response.text
  end


end
