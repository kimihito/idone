class Users::Show::Navigation < ActionView::Component::Base
  validates :user, :current_path, presence: true

  def initialize(user:, current_path:)
    @user = user
    @project_size = user.projects.size
    @track_size = user.tracks.size
    @current_path = current_path
  end

  private

  attr_reader :user, :project_size, :line_nav_item, :track_size, :current_path

  def line_nav_item(type:)
    capture do
      concat(t("components.users.show.navigation.#{type}"))
      concat(content_tag(:span, send("#{type}_size"), class: 'Counter'))
    end
  end
end
