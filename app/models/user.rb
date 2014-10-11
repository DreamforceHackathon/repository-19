class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :lockable

  validates :phone_number, phone_number: true
end
