FactoryGirl.define do
  factory :prompt do
    association :scenario, strategy: :build
    content "What is the meaning of life?"
  end
end
