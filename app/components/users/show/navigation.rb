class Users::Show::Navigation < ActionView::Component::Base
  validates :user, :current_path, presence: true

  def initialize(user:, current_path:, project_size: 0)
    @user = user
    @project_size = project_size
    @current_path = current_path
  end

  private

  attr_reader :user, :project_size, :current_path
end
