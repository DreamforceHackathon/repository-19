class Scenario < ActiveRecord::Base
  include RankedModel
  ranks :sequence, with_same: :practice_phone_number_id

  belongs_to :practice_phone_number
  has_many :prompts, dependent: :destroy

  validates :practice_phone_number, presence: true
  validates :name, presence: true

  def to_s
    name
  end

end
