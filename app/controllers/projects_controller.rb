class ProjectsController < ApplicationController
  include Pagy::Backend
  permits :title, :owner_id, model_name: 'Project'
  before_action :authenticate_user!, except: %i[index show]

  def index
    @pagy, @projects = pagy(Project.recent)
    authorize(@projects)
  end

  def show(id)
    @project = Project.includes(tracks: :owner).find(id)
    authorize(@project)
    @pagy, tracks = pagy(@project.tracks.recent)
    @tracks_by_date = tracks.group_by{ |track| track.created_at.to_date }
  end

  def new
    new_project = current_user.projects.build
    authorize(new_project)
    @form = ProjectForm.new(new_project)
  end

  def create(project)
    new_project = current_user.projects.build
    authorize(new_project)
    @form = ProjectForm.new(new_project, project)
    if @form.save
      redirect_to @form, notice: t('.success')
    else
      flash.now[:alert] = t('.failed')
      render :new
    end
  end

  def edit(id)
    project = Project.find(id)
    authorize(project)
    @form = ProjectForm.new(project)
  end

  def update(id, project)
    edit_project = Project.find(id)
    authorize(edit_project)
    form = ProjectForm.new(edit_project, project)
    if form.save
      redirect_to form, notice: t('.success')
    else
      flash[:alert] = t('.failed')
      redirect_to edit_project_path(form)
    end
  end

  def destroy(id)
    @project = Project.find(id)
    authorize(@project)
    @project.destroy!

    redirect_to projects_path, notice: t('.success')
  end
end
