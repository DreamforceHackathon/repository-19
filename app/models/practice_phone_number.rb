class PracticePhoneNumber < ActiveRecord::Base

  before_create :purchase_phone_number!
  before_destroy :return_phone_number!

  validates :name, presence: true
  validates :owner, presence: true
  validate :users_includes_owner

  belongs_to :owner, class_name: "User"
  has_many :user_practice_phone_numbers, inverse_of: :practice_phone_number
  has_many :users, through: :user_practice_phone_numbers, inverse_of: :practice_phone_numbers
  has_many :scenarios

  def purchase_phone_number!
    return true if phone_number.present?

    twilio_phone_number = twilio_client.account.incoming_phone_numbers.create(area_code: area_code)
    update(phone_number: twilio_phone_number.phone_number)
  end

  def return_phone_number!
    return true if phone_number.blank?

    twilio_phone_number = twilio_client.account.incoming_phone_numbers.list(phone_number: phone_number).first
    return true if twilio_phone_number.nil?

    twilio_phone_number.delete
  end

  def owner=(value)
    unless user_practice_phone_numbers.any? { |uppn| uppn.user == value }
      user_practice_phone_numbers.new(user: value)
    end
    association(:owner).replace(value)
  end

  def to_s
    name + "(#{phone_number})"
  end

private

  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
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

end
