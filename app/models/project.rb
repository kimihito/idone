# == Schema Information
#
# Table name: projects
#
#  id         :uuid             not null, primary key
#  owner_id   :uuid             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_projects_on_created_at  (created_at)
#  index_projects_on_owner_id    (owner_id)
#  index_projects_on_title       (title)
#  index_projects_on_updated_at  (updated_at)
#

class Project < ApplicationRecord
  include SearchCop

  search_scope :search do
    attributes :title
    options :title, left_wildcard: false
  end

  belongs_to :owner, class_name: 'User'

  has_many :tracks, dependent: :destroy

  has_one_attached :icon
  validates :title, presence: true
  validates :icon, content_type: /\Aimage\/.*\z/

  scope :recent, -> { order('created_at DESC') }
end
