class ProjectsController < ApplicationController
  include Pagy::Backend
  permits :title, :owner_id, :icon, model_name: 'Project'
  before_action :authenticate_user!, except: %i[index]

  def index
    @pagy, @projects = pagy(Project.recent)
    skip_authorization
  end

  def new
    @project = authorize current_user.projects.build
    authorize(@project)
  end

  def create(project)
    @project = authorize current_user.projects.build(project)
    if @project.save
      redirect_to @project, notice: t('.success')
    else
      flash.now[:alert] = t('.failed')
      render :new
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
    @project = Project.find(id)
    authorize(@project)
    @project.destroy!
    redirect_to projects_path, notice: t('.success')
  end
end
