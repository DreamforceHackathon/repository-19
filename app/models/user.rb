class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :lockable, :confirmable

  attr_accessor :password_required

  validates :phone_number, presence: true
  validates :phone_number, phone_number: true, if: -> (u) { u.phone_number.present? }
  validates :phone_number, uniqueness: true
  validates :password, presence: true, if: :password_required

  has_many :user_practice_phone_numbers, inverse_of: :user
  has_many :practice_phone_numbers, through: :user_practice_phone_numbers, inverse_of: :users

  before_create :skip_confirmation!, unless: -> { Rails.env.production? }

  def send_confirmation_notification?
    confirmation_required? && !@skip_confirmation_notification && self.phone_number.present?
  end

  def to_s
    [name, phone_number].compact.join(", ")
  end

  def name
    return [first_name, last_name].join(" ") if first_name.present? && last_name.present?
    return first_name if first_name.present?
    return last_name if last_name.present?
  end

  def phone_number=(value)
    write_attribute :phone_number, clean_phone_number(value)
  end

  def signature
    verifier.generate id
  end

  delegate :verifier, to: :class

  class << self
    def verifier
      Rails.application.message_verifier(:user_signature)
    end

    def find_by_signature(signature)
      find_by id: verifier.verify(signature)
    end
  end

private

  def clean_phone_number(value)
    return unless value.present?

    digits = value.gsub(/\D/,"")

    case digits
    when /\A\d{10}\z/ then "+1" + digits
    when /\A\d{11,}\z/ then "+" + digits
    end
  end

end
