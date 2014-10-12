class UserPracticePhoneNumber < ActiveRecord::Base

  belongs_to :user, inverse_of: :user_practice_phone_numbers
  accepts_nested_attributes_for :user

  belongs_to :practice_phone_number, inverse_of: :user_practice_phone_numbers

  validates :user, presence: true
  validates :practice_phone_number, presence: true
  validates :user_id, uniqueness: { scope: :practice_phone_number_id }

  after_commit :send_txt_message_invite, on: [:create]

  def send_txt_message_invite
    twilio_client.messages.create(
      from: practice_phone_number.phone_number,
      to: user.phone_number,
      body: "You've been invited to Call for Practice. Just call back this number to get started."
    )
  end

private

  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
  end

end
