class ScenarioRoutingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @incoming_call = IncomingCall.find(params[:incoming_call_id])

    response = Twilio::TwiML::Response.new do |r|
      r.Say "What scenario would you like to practice?"
      r.Pause length: 1
      r.Gather timeout: 10, numDigits: 1, method: "POST" do
        3.times do
          @incoming_call.practice_phone_number.scenarios.rank(:sequence).each_with_index do |scenario, index|
            r.Say "Press #{index + 1} for #{scenario.name}."
          end
        end
      end
    end
  end

end
