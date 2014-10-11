class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :lockable, :confirmable

  validates :phone_number, presence: true
  validates :phone_number, phone_number: true, if: -> (u) { u.phone_number.present? }

  def send_confirmation_notification?
    confirmation_required? && !@skip_confirmation_notification && self.phone_number.present?
  end

end
