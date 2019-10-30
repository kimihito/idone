class Projects::Update < ActiveInteraction::Base
  string :title, :icon, default: nil
  string :description, default: ''
  array :tag_names, default: [] do
    string
  end

  object :owner, class: User
  object :project

  validates :title, :owner, presence: true
  validates :description, presence: true, length: { maximum: Project::DESCRIPTION_MAXIMUM }, allow_blank: true

  def to_model
    project
  end

  def execute
    project.assign_attributes(inputs.except(:project, :tag_names))
    tag_names.each do |tag_name|
      compose(Projects::Tags::Create, name: tag_name, project: project)
    end
    error.merge!(project.errors) unless project.save
    project.reload # need it?
    project
  end
end