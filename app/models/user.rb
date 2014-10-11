class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :lockable, :confirmable

  validates :phone_number, presence: true
  validates :phone_number, phone_number: true, if: -> (u) { u.phone_number.present? }
  validates :phone_number, uniqueness: true
  validates :password, presence: true, if: -> (u) { u.encrypted_password.blank? }

  def send_confirmation_notification?
    confirmation_required? && !@skip_confirmation_notification && self.phone_number.present?
  end

end
