class Users::TracksController < ApplicationController
  def index(user_name:)
    @user = User.includes(tracks: :project).find_by!(name: user_name)
    @pagy, @tracks = pagy(@user.tracks.order(created_at: :desc))
    skip_authorization
  end
end