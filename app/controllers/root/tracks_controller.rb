class Root::TracksController < ApplicationController
  permits :raw_body, :owner_id, model_name: 'Track'

  def create(track)
    new_track = current_user.tracks.build
    authorize(new_track)
    @form = TrackForm.new(new_track, track)
    if @form.save
      render @form, layout: false
    else
      render partial: 'devise/shared/error_messages', locals: { resource: @form }, status: :unprocessable_entity
    end
  end

  private

  def authorize(record, query = nil)
    super([:root, record], query)
  end
end