class MissingTwilioConfigError < ArgumentError
end

if ENV["TWILIO_ACCOUNT_SID"].blank?
  raise MissingTwilioConfigError, "you must add a TWILIO_ACCOUNT_SID environment variable"
end

if ENV["TWILIO_AUTH_TOKEN"].blank?
  raise MissingTwilioConfigError, "you must add a TWILIO_AUTH_TOKEN environment variable"
end

if ENV["TWILIO_APP_PHONE_NUMBER"].blank?
  raise MissingTwilioConfigError, "you must add a TWILIO_APP_PHONE_NUMBER environment variable"
end

if ENV["TWILIO_RECORDING_PHONE_NUMBER"].blank?
  raise MissingTwilioConfigError, "you must add a TWILIO_RECORDING_PHONE_NUMBER environment variable"
end
