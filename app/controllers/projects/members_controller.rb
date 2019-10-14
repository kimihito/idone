class Projects::MembersController < ApplicationController
  before_action :authenticate_user!, only: %w[edit]

  def edit(project_id:)
    @project = authorize Project.find(project_id)
  end
end