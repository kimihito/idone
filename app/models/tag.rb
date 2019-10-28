class Tag < ApplicationRecord
  has_many :project_tags
  has_many :projects, through: :project_tags

  has_one :track_tag
  has_one :track, through: :track_tag
end
