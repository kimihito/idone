# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  project_id :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_name        (name)
#  index_tags_on_project_id  (project_id)
#

class Tag < ApplicationRecord
  belongs_to :project, optional: true, inverse_of: :tags
  has_one :track, inverse_of: :tag

  scope :used_by, -> (owner:) do
    union(used_in_track_by(owner: owner), used_in_project_by(owner: owner))
  end

  scope :used_in_track_by, -> (owner:) do
    joins(:track).where(tracks: { owner: owner })
  end

  scope :used_in_project_by, -> (owner:) do
    joins(:project).where(projects: { owner: owner })
  end

  scope :unused, -> { where(project: nil, track:nil) }
end
