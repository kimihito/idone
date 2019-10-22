# == Schema Information
#
# Table name: project_tags
#
#  id         :integer          not null, primary key
#  project_id :uuid
#  track_id   :integer          not null
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_project_tags_on_project_id  (project_id)
#  index_project_tags_on_track_id    (track_id)
#

class ProjectTag < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :track

  validates :name, presence: true
end
