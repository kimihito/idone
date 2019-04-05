class RootController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, actions = pagy(Action.includes(:project).recent)
    @actions_by_date = actions.group_by { |action| action.created_at.to_date }
  end
end
