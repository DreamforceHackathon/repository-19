class RecordingDummyController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    response = Twilio::TwiML::Response.new do |r|
      r.Play ActionController::Base.helpers.asset_url("short_beep.mp3")
      r.Pause length: 600
    end
  end

end
