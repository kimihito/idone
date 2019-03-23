class ProjectsController < ApplicationController
  include Pagy::Backend
  permits :title, :owner_id, model_name: 'Project'

  before_action :authenticate_user!, except: [:index]

  def index
    @pagy, @projects = pagy(Project.recent)
  end

  def show(id)
    @project = Project.find(id)
  end

  def new
    @form = ProjectForm.new(Project.new)
  end

  def create(project)
    form = ProjectForm.new(Project.new(owner: current_user), project)
    if form.save
      redirect_to form, notice: t('.success')
    else
      @form = ProjectForm.new(Project.new(owner: current_user), project)
      flash.now[:alert] = t('.failed')
      render :new
    end
  end

  def edit(id)
    @form = ProjectForm.new(Project.find(id))
  end

  def update(id, project)
    form = ProjectForm.new(Project.find(id), project)
    if form.save
      redirect_to form, notice: t('.success')
    else
      flash[:alert] = t('.failed')
      redirect_to edit_project_path(form)
    end
  end
end