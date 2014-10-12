class Response < ActiveRecord::Base

  belongs_to :prompt
  belongs_to :incoming_call
  has_one :recording, as: :recordable

  validates :prompt, presence: true
  validates :incoming_call, presence: true

  delegate :user, to: :incoming_call

  def recording_mp3_url
    return unless recording
    return unless recording.url.present?

    recording.url
  end

end
