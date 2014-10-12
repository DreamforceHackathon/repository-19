FactoryGirl.define do
  factory :incoming_call do
    association :user, strategy: :build
    association :practice_phone_number, strategy: :build
    twilio_sid "ABC123"
  end
end
