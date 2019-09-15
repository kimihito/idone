class Users::OverviewsController < ApplicationController
  def show(user_name:)
    @user = User.includes(:projects).find_by(name: user_name)
    @projects = @user.projects
    @activities = PublicActivity::Activity.where(owner: @user).group_by_day(reverse: true) { |a| a.created_at }
    binding.pry
    skip_authorization
  end
end
