module TwilioHelper
  def environment_variables_present?
    [
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_AUTH_TOKEN"],
      ENV["TWILIO_APP_PHONE_NUMBER"],
      ENV["TWILIO_RECORDING_PHONE_NUMBER"]
    ].all?(&:present?)
  end
end
