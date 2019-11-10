class Projects::Create < ActiveInteraction::Base
  string :title, :icon, default: nil
  string :description, default: ''
  array :tag_names, default: [] do
    string
  end

  object :owner, class: User

  validates :title, :owner, presence: true
  validates :description, presence: true, length: { maximum: Project::DESCRIPTION_MAXIMUM }, allow_blank: true

  def execute
    project = Project.new(inputs.except(:tag_names))
    tags = tag_names.map do |tag_name|
      compose(Tags::Create, name: tag_name, owner: project.owner)
    end
    project.tags = tags
    errors.merge!(project.errors) unless project.save
    project
  end

  def to_model
    Project.new
  end
end