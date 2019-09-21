class Users::OverviewsController < ApplicationController
  def show(user_name:)
    @user = User.includes(:projects, :tracks).find_by(name: user_name)
    @projects = @user.projects.recent.limit(6)
    @tracks_by_dates = @user.tracks.recent.limit(10).group_by_day(reverse: true, &:created_at)
    skip_authorization
  end
end
