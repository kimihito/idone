class Projects::Show::Layout < ActionView::Component::Base
  validates :project, presence: true

  def initialize(project:)
    @project = project
  end

  private

  attr_reader :content, :project, :updatable
end