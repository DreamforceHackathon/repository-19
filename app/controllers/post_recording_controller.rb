class PostRecordingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @recording = Recording.find(params[:id])
    @incoming_call = @recording.recordable.incoming_call

    if params["RecordingUrl"].present?
      @recording.update(url: params["RecordingUrl"])
    end

    digits = params["Digits"]

    valid_digits = ["1","2","3"]

    response = Twilio::TwiML::Response.new do |r|
      if digits.present?
        if !valid_digits.include?(digits)
          r.Say "#{digits} is not a valid choice. Please try again."
        else
          case digits
          when "1"
            if next_prompt_url = next_recordable_url(@recording.recordable)
              r.Redirect next_prompt_url
            else
              r.Say "You're done! We're sending you back to the main menu."
              r.Redirect incoming_call_scenario_routing_path(@incoming_call)
            end
          when "2"
            body = case @recording.recordable
            when Response
              "Here's your answer to the question, '#{@recording.recordable.prompt.content}'. #{audio_recording_url(@recording)}"
            end
            twilio_client.account.messages.create(
              from: ENV["TWILIO_APP_PHONE_NUMBER"],
              to: @incoming_call.user.phone_number,
              body: body
            )
            r.Say "The text message was sent with the audio."
            r.Pause length: 1
          when "3"
            r.Say "OK. I'm sending you back the main menu."
            r.Redirect incoming_call_scenario_routing_path(@incoming_call)
          end
        end
      end
      r.Gather timeout: 10, numDigits: 1, method: "POST" do
        3.times do
          r.Say "Here's what you sounded like."
          r.Say "When you're ready to continue, press 1."
          r.Say "To have this audio sent to your phone, press 2."
          r.Say "To go back to the main menu, press 3."
          r.Play @recording.url
        end
      end
    end

    render xml: response.text
  end

private

  def next_recordable_url(recordable)
    case recordable
    when Response
      prompt = recordable.prompt
      scenario = prompt.scenario
      prompts = scenario.prompts.rank(:sequence).to_a
      return unless next_prompt = prompts[prompts.index(prompt) + 1]

      incoming_call = recordable.incoming_call
      incoming_call_prompt_pre_recording_url(incoming_call, prompt_id: next_prompt.id)
    end
  end

  def twilio_client
    Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
  end

end
