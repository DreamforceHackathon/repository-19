class PostRecordingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @recording = Recording.find(params[:id])

    @recording.update(url: params["RecordingUrl"])

    response = Twilio::TwiML::Response.new do |r|
      r.Say "Here's what you said."
      r.Pause length: 2
      r.Play @recording.url
    end

    render xml: response.text
  end

end
