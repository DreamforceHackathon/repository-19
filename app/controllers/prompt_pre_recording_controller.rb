class PromptPreRecordingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @incoming_call = IncomingCall.find(params[:incoming_call_id])
    @prompt = Prompt.find(params[:prompt_id])

    prompt_sequence = @prompt.scenario.prompts.rank(:sequence).pluck(:id).index(@prompt.id) + 1

    @response = Response.create(prompt: @prompt, incoming_call: @incoming_call)

    response = Twilio::TwiML::Response.new do |r|
      r.Say "Question number #{prompt_sequence}."
      r.Say @prompt.content
      r.Pause length: 2
      r.Redirect incoming_call_recordings_path(@incoming_call, recordable_type: @response.class.to_s, recordable_id: @response.id)
    end

    render xml: response.text
  end


end
