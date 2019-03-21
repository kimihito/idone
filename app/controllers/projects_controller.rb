class ProjectsController < ApplicationController
  def index
    @pagy, @project = pagy(Project.recent)
  end

  def new
    @project = Project.new
  end

  def create(project)
    @project = Project.new(project.permit(:title))
    @project.owner = current_user
    @project.save!
  end
end