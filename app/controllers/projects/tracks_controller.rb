class Projects::TracksController < ApplicationController
  def index(project_id:)
    @project = Project.includes(:tracks).find(project_id)
    @pagy, tracks = pagy(@project.tracks.recent)
    authorize(tracks)
    @tracks_by_date = tracks.group_by { |track| track.created_at.to_date }
  end

  private

  def authorize(record, query = nil)
    super([:projects, record], query)
  end
end