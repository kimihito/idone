class My::ProjectsController < ApplicationController
  def index
    projects = current_user.projects.search(title: params[:q]).recent
    render json: ProjectSerializer.new(projects).serialized_json
  end
end
