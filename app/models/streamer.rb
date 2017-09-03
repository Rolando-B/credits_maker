class Streamer < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :twitch, presence: true, unless: ->(streamer){streamer.youtube.present?}
  validates :youtube, presence: true, unless: ->(streamer){streamer.twitch.present?}

end
