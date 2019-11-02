class Projects::Update < ActiveInteraction::Base
  string :title, :icon, :description, default: nil
  array :tag_names, default: [] do
    string
  end

  object :project

  validates :description, presence: true, length: { maximum: Project::DESCRIPTION_MAXIMUM }, allow_blank: true, if: :description?
  validates :title, presence: true, if: :title?
  validates :icon, presence: true, if: :icon?

  def to_model
    project
  end

  def persisted?
    true
  end

  def execute
    project.title = title if title?
    project.description = description if description?
    project.icon = icon if icon?
    tags = tag_names.map do |tag_name|
      compose(Tags::Create, name: tag_name, project: project)
    end
    project.tags = tags
    errors.merge!(project.errors) unless project.save
    project
  end
end