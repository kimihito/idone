class Projects::Show::Navigation < ActionView::Component::Base
  validates :project, presence: true

  def initialize(project:)
    @project = project
    @track_size = project.tracks.size
    @member_size = [project.owner].size
  end

  private

  attr_reader :project, :track_size, :member_size, :line_nav_item

  def line_nav_item(type:)
    capture do
      concat(t("components.projects.show.navigation.#{type}"))
      concat(content_tag(:span, send("#{type}_size"), class: 'Counter'))
    end
  end
end