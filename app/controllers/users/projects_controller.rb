class Users::ProjectsController < ApplicationController
  def index(user_name:)
    user = User.include(:projects).find_by!(name: user_name)
    @projects = user.projects
  end
end
