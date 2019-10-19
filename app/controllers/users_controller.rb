class UsersController < ApplicationController
  include Pagy::Backend
  def index
    @pagy, @users = pagy(User.includes(:tracks, :projects).recent)
    skip_authorization
  end

  def edit(name)
    @user = authorize User.find_by!(name: name)
  end
end
