class PracticePhoneNumber < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  before_validation :add_owner_to_users_if_missing, if: :owner

  after_commit :purchase_phone_number!, on: [:create]
  before_destroy :return_phone_number!

  validates :name, presence: true
  validates :owner, presence: true
  validate :users_includes_owner

  belongs_to :owner, class_name: "User"
  has_many :user_practice_phone_numbers, inverse_of: :practice_phone_number, dependent: :destroy
  has_many :users, through: :user_practice_phone_numbers, inverse_of: :practice_phone_numbers
  has_many :scenarios
  has_many :incoming_calls

  def purchase_phone_number!
    return true if phone_number.present?

    twilio_phone_number = twilio_client.account.incoming_phone_numbers.create(
      area_code: area_code,
      friendly_name: name,
      voice_url: practice_phone_number_incoming_calls_url(id, format: :xml),
      voice_method: "POST"
    )
    update(phone_number: twilio_phone_number.phone_number)
  end

  def return_phone_number!
    return true if phone_number.blank?

    twilio_phone_number = get_twilio_phone_number
    return true if twilio_phone_number.nil?

    twilio_phone_number.delete
  end

  def to_s
    "#{name}, #{phone_number}"
  end

private

  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
  end

  def get_twilio_phone_number
    twilio_client.account.incoming_phone_numbers.list(phone_number: phone_number).first
  end

  def area_code
    return "500" unless Rails.env.production? # valid in twilio's test environment
    "860"
  end

  def users_includes_owner
    return unless owner

    unless user_practice_phone_numbers.any? { |uppn| uppn.user == owner }
      errors.add :users, "must include the owner"
    end
  end

  def add_owner_to_users_if_missing
    return true unless owner
    return if user_practice_phone_numbers.any? { |uppn| uppn.user == owner }

    self.user_practice_phone_numbers.new(user: owner)
  end

end
