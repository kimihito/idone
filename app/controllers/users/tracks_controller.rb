class Users::TracksController < ApplicationController
  def index(user_name:)
    @user = User.includes(tracks: :project).find_by!(name: user_name)
    @pagy, @tracks = pagy(@user.tracks.recent)
    @tracks_by_dates = @tracks.group_by_day(reverse: true, &:created_at)
    skip_authorization
  end
end