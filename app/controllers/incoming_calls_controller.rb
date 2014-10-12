class IncomingCallsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :redirect_to_root_unless_user_signed_in, except: [:create]

  def index
    @incoming_calls = policy_scope(IncomingCall).order(created_at: :desc)
  end

  def show
    @incoming_call = IncomingCall.find(params[:id])
    authorize @incoming_call
  end

  def create
    @practice_phone_number = PracticePhoneNumber.find_by(id: params[:practice_phone_number_id])
    @user = @practice_phone_number.users.find_by(phone_number: params["From"])

    response = Twilio::TwiML::Response.new do |r|
      r.Play ActionController::Base.helpers.asset_url("welcome_tones.mp3")
      if @user.nil?
        r.Play ActionController::Base.helpers.asset_url("say_not_authorized_from_number.mp3")
      elsif @practice_phone_number.nil?
        r.Play ActionController::Base.helpers.asset_url("say_problem_with_request.mp3")
      else
        @incoming_call = @practice_phone_number.incoming_calls.create!(twilio_sid: params["CallSid"], user: @user)
        r.Redirect incoming_call_scenario_routing_path(@incoming_call), method: "POST"
      end
    end
    render xml: response.text
  end

end
