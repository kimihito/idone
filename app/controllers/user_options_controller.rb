class UserOptionsController < ApplicationController
  before_action :authenticate_user!

  permits :email_privacy

  def edit
    user = authorize User.find(current_user.id)
    user_option = user.user_option
    @income = UserOptions::Update.new(user_option.attributes.merge(user_option: user_option))
  end

  def update(user_option)
    inputs = { user_option: authorize(UserOption.find_by(user_id: current_user.id)) }.merge(user_option)
    outcome = UserOptions::Update.run(inputs)
    if outcome.valid?
      redirect_to edit_user_option_path, notice: t('.success')
    else
      render partial: 'layouts/shared/error_messages', locals: { resource: outcome }, status: :unprocessable_entity, turbolinks: false
    end
  end
end