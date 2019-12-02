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
    @outcome = Tracks::BulkCreate.run(track.merge({ owner: current_user }))
    if @outcome.valid?
      redirect_to root_path, notice: t('.success')
    else
      render partial: 'layouts/shared/error_messages', locals: { resource: @outcome }, status: :unprocessable_entity, turbolinks: false
    end
  end

  def edit(id)
    track = authorize Track.find(id)
    @outcome = Tracks::Update.new(track.attributes.merge(track: track))

    render layout: false
  end

  def update(id, track)
    @outcome = Tracks::Update.run(track.merge(track: authorize(Track.find(id))))
    if @outcome.valid?
      redirect_to root_path, notice: t('.success')
    else
      render partial: 'layouts/shared/error_messages', locals: { resource: @outcome }, status: :unprocessable_entity, turbolinks: false
    end
  end

  def destroy(id)
    Tracks::Destroy.run!(track: authorize(Track.find(id)))
    redirect_to root_path, notice: t('.success')
  end
end
