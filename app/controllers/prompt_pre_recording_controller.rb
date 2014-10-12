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
        r.Play ActionController::Base.helpers.asset_url("say_heres_next_question.mp3")
        r.Pause length: 1
        r.Say @prompt.content
        r.Pause length: 2
        r.Redirect incoming_call_recordings_path(@incoming_call, recordable_type: @response.class.to_s, recordable_id: @response.id)
      else
        r.Play ActionController::Base.helpers.asset_url("say_problem_with_request.mp3")
      end
    end

    render xml: response.text
  end


end
