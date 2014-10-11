class RecordingDummyController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    response = Twilio::TwiML::Response.new do |r|
      r.Say ""
      r.Pause length: 600
    end
  end

end
