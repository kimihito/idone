class UsersController < ApplicationController
  def index
    @users = User.all
    authorize(@users)
  end

  def show(name)
    @user = authorize User.find_by!(name: name)
    @activities = PublicActivity::Activity.where(owner: @user).order(created_at: :desc)
  end

  def edit(name)
    @user = authorize User.find_by!(name: name)
  end
end
