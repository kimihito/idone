class Users::ProjectsController < ApplicationController
  def index(user_name:)
    @user = User.includes(:projects).find_by!(name: user_name)
    @pagy, @projects = pagy(@user.projects.order(updated_at: :desc))
    skip_authorization
  end
end
