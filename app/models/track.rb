# == Schema Information
#
# Table name: tracks
#
#  id         :bigint(8)        not null, primary key
#  project_id :uuid             not null
#  owner_id   :uuid             not null
#  raw_body   :text             default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tracks_on_created_at  (created_at)
#  index_tracks_on_owner_id    (owner_id)
#  index_tracks_on_project_id  (project_id)
#  index_tracks_on_updated_at  (updated_at)
#

class Track < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :project

  scope :recent, -> { order('created_at DESC') }
end
