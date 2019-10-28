class ProjectsController < ApplicationController
  include Pagy::Backend
  permits :title, :icon, :description, model_name: 'Project'
  before_action :authenticate_user!, except: %i[index]

  def index
    @pagy, @projects = pagy(Project.recent)
    skip_authorization
  end

  def new
    @project = authorize Projects::Create.new(owner: current_user)
  end

  def create(project)
    @project = authorize Projects::Create.run(project.merge(owner: current_user))
    if @project.valid?
      redirect_to @project.result, notice: t('.success')
    else
      render partial: 'layouts/shared/error_messages', locals: { resource: @project }, status: :unprocessable_entity, turbolinks: false
    end
  end

  def edit(id)
    @project = authorize Project.find(id)
  end

  def update(id, project)
    @project = authorize Project.find(id)
    if @project.update(project)
      redirect_to @project, notice: t('.success')
    else
      render partial: 'layouts/shared/error_messages', locals: { resource: @project }, status: :unprocessable_entity, turbolinks: false
    end
  end

  def destroy(id)
    @project = authorize Project.find(id)
    @project.destroy!
    redirect_to projects_path, notice: t('.success')
  end
end
