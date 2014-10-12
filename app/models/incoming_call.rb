class IncomingCall < ActiveRecord::Base

  belongs_to :practice_phone_number
  belongs_to :user
  has_many :responses, dependent: :destroy

  validates :practice_phone_number, presence: true
  validates :user, presence: true
  validates :twilio_sid, presence: true

end
