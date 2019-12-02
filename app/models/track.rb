# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  raw_body   :text             default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :uuid             not null
#  tag_id     :integer          not null
#
# Indexes
#
#  index_tracks_on_created_at  (created_at)
#  index_tracks_on_owner_id    (owner_id)
#  index_tracks_on_tag_id      (tag_id)
#  index_tracks_on_updated_at  (updated_at)
#

class Track < ApplicationRecord
  include PublicActivity::Common

  belongs_to :owner, class_name: 'User', inverse_of: :tracks, touch: true
  belongs_to :tag, inverse_of: :track
  has_one :project, through: :tag

  scope :recent, -> { order('created_at DESC') }
  scope :in_project, -> (project) { joins(:project).where(projects: { id: project.id }) }
end
