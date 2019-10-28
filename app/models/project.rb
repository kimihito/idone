# == Schema Information
#
# Table name: projects
#
#  id          :uuid             not null, primary key
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :uuid             not null
#  description :text             default(""), not null
#
# Indexes
#
#  index_projects_on_created_at  (created_at)
#  index_projects_on_owner_id    (owner_id)
#  index_projects_on_title       (title)
#  index_projects_on_updated_at  (updated_at)
#

class Project < ApplicationRecord
  DESCRIPTION_MAXIMUM = 300.freeze
  include SearchCop

  search_scope :search do
    attributes :title
    options :title, left_wildcard: false
  end

  belongs_to :owner, class_name: 'User', touch: true

  has_many :tracks
  has_many :project_tags, dependent: :destroy
  has_many :tags, through: :project_tags

  has_one_attached :icon
  validates :title, presence: true
  validates :icon, content_type: /\Aimage\/.*\z/
  validates :description, length: { maximum: 300 }, allow_blank: true

  scope :recent, -> { order('created_at DESC') }
end
