class Users::OverviewsController < ApplicationController
  def show(user_name:)
    @user = User.includes(:projects, :tracks).find_by(name: user_name)
    @projects = @user.projects.limit(6)
    @tracks = @user.tracks.limit(10)
    skip_authorization
  end
end
