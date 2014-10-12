class PostRecordingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @recording = Recording.find(params[:id])
    @incoming_call = @recording.recordable.incoming_call

    @recording.update(url: params["RecordingUrl"])

    digits = params["Digits"]

    valid_digits = ["1","2"]

    response = Twilio::TwiML::Response.new do |r|
      if digits.present?
        if !valid_digits.include?(digits)
          r.Say "#{digits} is not a valid choice. Please try again."
        else
          case digits
          when "1"
            if next_url = next_recordable_url(@recording.recordable)
              r.Redirect next_url
            else
              r.Say "You're done! We're sending you back to the main menu."
              r.Redirect incoming_call_purpose_routing_path(@incoming_call)
            end
          when "2"
            r.Redirect incoming_call_purpose_routing_path(@incoming_call)
          end
        end
      end
      r.Gather timeout: 10, numDigits: 1, method: "POST" do
        3.times do
          r.Say "Here's your pitch."
          r.Say "When you're ready to continue, press 1."
          r.Say "To to back to the main menu, press 2."
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

end
