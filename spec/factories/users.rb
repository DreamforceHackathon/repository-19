FactoryGirl.define do
  factory :user do
    first_name "Billy"
    last_name "Bean"
    phone_number "+18108443757"
    password "12345678"
    after(:build) do |user|
      user.skip_confirmation!
    end
  end
end
