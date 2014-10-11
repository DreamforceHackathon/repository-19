class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :lockable, :confirmable

  validates :phone_number, phone_number: true

  def send_confirmation_notification?
    confirmation_required? && !@skip_confirmation_notification && self.phone_number.present?
  end

end
