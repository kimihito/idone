class ProjectTags::Create < ActiveInteraction::Base
  string :name, default: nil
  object :track, default: nil
  object :project, default: nil
  validates :name, presence: true

  def execute
    project_tag = ProjectTag.find_or_initialize_by(name: name) do |tag|
      tag.track = track
      tag.project = project
    end

    errors.merge!(project_tag.errors) unless project_tag.save
    project_tag
  end

  def to_model
    ProjectTag.new
  end
end