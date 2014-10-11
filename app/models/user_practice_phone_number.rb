class UserPracticePhoneNumber < ActiveRecord::Base

  belongs_to :user, inverse_of: :user_practice_phone_numbers
  accepts_nested_attributes_for :user

  belongs_to :practice_phone_number, inverse_of: :user_practice_phone_numbers

  validates :user, presence: true
  validates :practice_phone_number, presence: true
  validates :user_id, uniqueness: { scope: :practice_phone_number_id }

end
