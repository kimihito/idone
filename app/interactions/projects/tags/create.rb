class Projects::Tags::Create < ActiveInteraction::Base
  object :project, default: nil
  string :name, default: nil

  validates :name, :project, presence: true

  def execute
    tag = Tag.find_or_initialize_by(name: name, projects: [project])
    errors.merge!(tag.errors) unless tag.save
    tag
  end
end