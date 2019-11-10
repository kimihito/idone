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
end
