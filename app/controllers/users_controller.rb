class UsersController < ApplicationController
  def index
    @users = User.all
    authorize(@users)
  end

  def show(name)
    @user = authorize User.find_by!(name: name)
  end
end
