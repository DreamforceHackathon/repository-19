class AuthenticationMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers

  def reset_password_instructions(record, token, opts={})
    link_to_reset_password = edit_password_url(record, reset_password_token: token)
    twilio_client.messages.create(
      from: ENV["TWILIO_APP_PHONE_NUMBER"],
      to: record.phone_number,
      body: "Call for Practice: Click on this link to set your password. #{link_to_reset_password}"
    )
  end

private

  def twilio_client
    Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
  end

end
