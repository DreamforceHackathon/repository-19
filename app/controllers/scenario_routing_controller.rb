class ScenarioRoutingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @incoming_call = IncomingCall.find_by(id: params[:incoming_call_id])

    if @incoming_call
      digits = params["Digits"]
      scenarios = @incoming_call.practice_phone_number.scenarios.rank(:sequence).to_a
      valid_digits = (1..(scenarios.count)).to_a.collect(&:to_s)
    end

    response = Twilio::TwiML::Response.new do |r|
      if @incoming_call
        if digits.present?
          if !valid_digits.include?(digits)
            r.Play ActionController::Base.helpers.asset_url("say_not_valid_choice.mp3")
          else
            scenario = scenarios[digits.to_i - 1]
            r.Play ActionController::Base.helpers.asset_url("say_record_after_beeps.mp3")
            prompt = scenario.prompts.rank(:sequence).first
            r.Pause length: 2
            r.Redirect incoming_call_prompt_pre_recording_path(@incoming_call, prompt_id: prompt.id)
          end
        end

        r.Play ActionController::Base.helpers.asset_url("say1_what_situation.mp3")

        r.Pause length: 1

        r.Gather timeout: 10, numDigits: 1, method: "POST" do
          3.times do
            scenarios.each_with_index do |scenario, index|
              r.Play ActionController::Base.helpers.asset_url("say_press_#{index + 1}_for.mp3")
              r.Say scenario.name
              r.Pause length: 1
            end
          end
        end
      else
        r.Play ActionController::Base.helpers.asset_url("say_problem_with_request.mp3")
      end
    end
    render xml: response.text
  end

end
