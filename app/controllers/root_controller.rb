class RootController < ApplicationController
  def index
    @pagy, tracks = pagy(Track.includes(:project, :owner).recent)
    authorize(tracks)
    @tracks_by_date = tracks.group_by_day(reverse: true) { |t| t.created_at }
  end
end
