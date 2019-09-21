class TracksController < ApplicationController
  include Pagy::Backend
  permits :raw_body, :owner_id, :project_id, model_name: 'Track'
  before_action :authenticate_user!, except: %i[index]

  def index
    @pagy, tracks = pagy(Track.includes(:project).recent)
    authorize(tracks)
    @tracks_by_date = tracks.group_by_day(reverse: true) { |t| t.created_at }
    render layout: false
  end

  def create(track)
    new_track = current_user.tracks.build
    authorize(new_track)
    @form = TrackForm.new(new_track, track.merge({ action_name: action_name })).as(current_user)
    if @form.save
    else
      render partial: 'layouts/shared/error_messages', locals: { resource: @form }, status: :unprocessable_entity, turbolinks: false
    end
  end

  def edit(id)
    track = Track.find(id)
    authorize(track)
    @form = TrackForm.new(track)

    render layout: false
  end
end
