class ScenarioRoutingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @incoming_call = IncomingCall.find(params[:incoming_call_id])

    digits = params["Digits"]
    scenarios = @incoming_call.practice_phone_number.scenarios.rank(:sequence).to_a
    valid_digits = (1..(scenarios.count)).to_a.collect(&:to_s)

    response = Twilio::TwiML::Response.new do |r|

      if digits.present?
        if !valid_digits.include?(digits)
          r.Say "#{digits} is not a valid choice. Please try again."
        else
          scenario = scenarios[digits.to_i - 1]
          r.Say "Reekord after the beeps. When you're done with each recording, press hashtag."
          prompt = scenario.prompts.rank(:sequence).first
          r.Redirect incoming_call_prompt_pre_recording_path(@incoming_call, prompt_id: prompt.id)
        end
      end

      r.Say "What scenario would you like to practice?"
      r.Pause length: 1
      r.Gather timeout: 10, numDigits: 1, method: "POST" do
        3.times do
          scenarios.each_with_index do |scenario, index|
            r.Say "Press #{index + 1} for #{scenario.name}."
            r.Pause length: 1
          end
        end
      end
    end
    render xml: response.text
  end

end
