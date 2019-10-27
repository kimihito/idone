class Projects::Create < ActiveInteraction::Base
  string :title, :description, default: ''
  array :tag_names, default: [] do
    string
  end

  object :owner, class: User

  validates :title, :owner, presence: true
  validates :description, presence: true, length: { maximum: Project::DESCRIPTION_MAXIMUM }, allow_blank: true

  def execute
    # FIXME: error i18n
    project = Project.new(inputs.except(:tag_names))
    tag_names.each do |tag_name|
      compose(ProjectTags::Create, name: tag_name, project: project)
    end
    errors.merge!(project.errors) unless project.save
    project
  end

  def to_model
    Project.new
  end
end