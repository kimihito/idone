class Users::OverviewsController < ApplicationController
  def show(user_name:)
    @user = User.includes(:projects).find_by(name: user_name)
    @projects = @user.projects
    @activities = PublicActivity::Activity.where(owner: @user).order(created_at: :desc)
    skip_authorization
  end
end
