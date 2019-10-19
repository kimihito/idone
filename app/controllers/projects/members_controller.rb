class Projects::MembersController < ApplicationController
  before_action :authenticate_user!, only: %w[edit]

  def show(project_id:)
    @project = Project.find(project_id)
    @members = [@project.owner]
    skip_authorization
  end

  def edit(project_id:)
    @project = authorize Project.find(project_id)
    @members = [@project.owner]
  end
end