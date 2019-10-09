# == Schema Information
#
# Table name: projects
#
#  id         :uuid             not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :uuid             not null
#
# Indexes
#
#  index_projects_on_created_at  (created_at)
#  index_projects_on_owner_id    (owner_id)
#  index_projects_on_title       (title)
#  index_projects_on_updated_at  (updated_at)
#

class ProjectSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  set_type :project
  attributes :title, :created_at

  link :self, :url do |object|
    Rails.application.routes.url_helpers.project_url(object)
  end
end
