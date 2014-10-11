class AuthenticationMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers

  def reset_password_instructions(record, token, opts={})
    link_to_reset_password = edit_password_url(record, reset_password_token: token)
    twilio_client.messages.create(
      from: ENV["TWILIO_APP_PHONE_NUMBER"],
      to: record.phone_number,
      body: "Call for Practice: Click to set your password. #{link_to_reset_password}"
    )
  end

  def confirmation_instructions(record, token, opts={})
    link_to_confirm = confirmation_url(record, confirmation_token: token)
    twilio_client.messages.create(
      from: ENV["TWILIO_APP_PHONE_NUMBER"],
      to: record.phone_number,
      body: "Call for Practice: Click to confirm your phone number. #{link_to_confirm}"
    )
  end

  def unlock_instructions(record, token, opts={})
    link_to_unlock = unlock_url(record, unlock_token: token)
    twilio_client.messages.create(
      from: ENV["TWILIO_APP_PHONE_NUMBER"],
      to: record.phone_number,
      body: "Call for Practice: Click to unlock your account. #{link_to_unlock}"
    )
  end

private

  def twilio_client
    Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
  end

end
