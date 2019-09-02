class UsersController < ApplicationController
  def index
    @users = User.all
    authorize(@users)
  end

  def show(name)
    @user = User.find_by(name: name)
    authorize(@user)
  end
end
