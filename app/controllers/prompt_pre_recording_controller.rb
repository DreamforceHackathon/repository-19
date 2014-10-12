class PromptPreRecordingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @incoming_call = IncomingCall.find_by(id: params[:incoming_call_id])
    @prompt = Prompt.find_by(id: params[:prompt_id])

    if @incoming_call && @prompt
      prompt_sequence = @prompt.scenario.prompts.rank(:sequence).pluck(:id).index(@prompt.id) + 1
      @response = Response.create(prompt: @prompt, incoming_call: @incoming_call)
    end

    response = Twilio::TwiML::Response.new do |r|
      if @response
        r.Say "Question number #{prompt_sequence}."
        r.Say @prompt.content
        r.Pause length: 2
        r.Redirect incoming_call_recordings_path(@incoming_call, recordable_type: @response.class.to_s, recordable_id: @response.id)
      else
        r.Say "There was a problem with the request."
      end
    end

    render xml: response.text
  end


end
