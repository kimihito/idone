class Root::TracksController < ApplicationController
  permits :raw_body, :owner_id, :project_id, model_name: 'Track'

  def create(track)
    new_track = current_user.tracks.build
    authorize(new_track)
    @form = TrackForm.new(new_track, track)
    if @form.save
      redirect_to root_path, notice: t('.success', project_name: new_track.project.title)
    else
      render partial: 'layouts/shared/error_messages', locals: { resource: @form }, status: :unprocessable_entity, turbolinks: false
    end
  end

  private

  def authorize(record, query = nil)
    super([:root, record], query)
  end
end