class Prompt < ActiveRecord::Base
  include RankedModel
  ranks :sequence, with_same: :scenario_id

  belongs_to :scenario
  validates :scenario, presence: true
  validates :content, presence: true

  delegate :practice_phone_number, to: :scenario, allow_nil: true

  def to_s
    content
  end

end
