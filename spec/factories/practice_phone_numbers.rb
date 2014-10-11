FactoryGirl.define do
  factory :practice_phone_number do
    name "Standard Sales Pitch"
    association :owner, factory: :user, strategy: :build
  end
end
