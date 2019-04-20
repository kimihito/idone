class RootController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, tracks = pagy(Track.includes(:project).recent)
    authorize(tracks)
    @tracks_by_date = tracks.group_by { |track| track.created_at.to_date }
  end
end
