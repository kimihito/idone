class My::ProjectsController < MyController
  def index
    projects = current_user.projects.search(title: params[:q]).recent
    authorize(projects)
    render json: ProjectSerializer.new(projects).serialized_json
  end
end