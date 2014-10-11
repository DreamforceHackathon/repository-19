class Scenario < ActiveRecord::Base
  include RankedModel
  ranks :sequence

  belongs_to :practice_phone_number

  validates :practice_phone_number, presence: true
  validates :name, presence: true

  def to_s
    name
  end

end
