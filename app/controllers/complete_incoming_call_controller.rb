class CompleteIncomingCallController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @incoming_call = IncomingCall.find_by(twilio_sid: params["CallSid"])
    responses = @incoming_call.responses.to_a
    recorded_response_count = responses.select { |r| r.recording.url.present? }.count
    if recorded_response_count > 0
      twilio_client.messages.create(
        from: @incoming_call.practice_phone_number.phone_number,
        to: @incoming_call.user.phone_number,
        body: "You recorded #{pluralize(recorded_response_count, "response")} during this practice session. http://www.callforpractice.com"
      )
    end
    head :ok
  end

private

  def twilio_client
    Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
  end

end
