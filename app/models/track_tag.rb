class TrackTag < ApplicationRecord
  belongs_to :track
  belongs_to :tag
end
