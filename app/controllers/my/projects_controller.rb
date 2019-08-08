class My::ProjectsController < MyController
  def index
    queries = params[:q]&.split
    tags = queries.blank? ? [{title: ''}] : queries.map { |p| { title: p } }
    projects = current_user.projects.search(or: tags).recent
    authorize(projects)
    render json: ProjectSerializer.new(projects).serialized_json
  end
end