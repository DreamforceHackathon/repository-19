FactoryGirl.define do
  factory :user do
    first_name "Sean"
    last_name "Devine"
    phone_number "+18885551212"
    password "12345678"
    after(:build) do |user|
      user.skip_confirmation!
    end
  end
end
