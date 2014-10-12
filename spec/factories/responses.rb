FactoryGirl.define do
  factory :response do
    association :prompt, strategy: :build
    association :incoming_call, strategy: :build
  end
end
