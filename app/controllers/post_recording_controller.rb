class PostRecordingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if @recording = Recording.find_by(id: params[:id])
      @incoming_call = @recording.recordable.incoming_call

      if params["RecordingUrl"].present?
        @recording.update(url: params["RecordingUrl"])
      end
    end

    digits = params["Digits"]
    valid_digits = ["1","3"]

    response = Twilio::TwiML::Response.new do |r|
      if @recording.present?
        if digits.present?
          if !valid_digits.include?(digits)
            r.Play ActionController::Base.helpers.asset_url("say_not_valid_choice.mp3")
          else
            case digits
            when "1"
              if next_prompt_url = next_recordable_url(@recording.recordable)
                r.Redirect next_prompt_url
              else
                r.Play ActionController::Base.helpers.asset_url("say_done_with_situation.mp3")
                r.Redirect incoming_call_scenario_routing_path(@incoming_call)
              end
            when "3"
              r.Play ActionController::Base.helpers.asset_url("say_ok_back_to_main_menu.mp3")
              r.Redirect incoming_call_scenario_routing_path(@incoming_call)
            end
          end
        end
        r.Gather timeout: 10, numDigits: 1, method: "POST" do
          3.times do
            r.Play ActionController::Base.helpers.asset_url("say_ready_to_continue_press_1.mp3")
            r.Play ActionController::Base.helpers.asset_url("say_main_menu_press_3.mp3")
            r.Play ActionController::Base.helpers.asset_url("say_play_your_response_back.mp3")
            r.Play @recording.url
          end
        end
      else
        r.Play ActionController::Base.helpers.asset_url("say_problem_with_request.mp3")
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
