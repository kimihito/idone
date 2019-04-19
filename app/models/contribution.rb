# == Schema Information
#
# Table name: contributions
#
#  id         :bigint(8)        not null, primary key
#  project_id :uuid             not null
#  owner_id   :uuid             not null
#  body       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  raw_body   :text             default(""), not null
#
# Indexes
#
#  index_contributions_on_body        (body)
#  index_contributions_on_created_at  (created_at)
#  index_contributions_on_owner_id    (owner_id)
#  index_contributions_on_project_id  (project_id)
#  index_contributions_on_updated_at  (updated_at)
#

class Contribution < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :project

  scope :recent, -> { order('created_at DESC') }
end
