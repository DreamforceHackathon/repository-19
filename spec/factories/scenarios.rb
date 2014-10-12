FactoryGirl.define do
  factory :scenario do
    association :practice_phone_number, strategy: :build
    name "Monty Python Trivia"
  end
end
