class ActionsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, actions = pagy(Action.recent)
    @actions_by_date = actions.group_by(&:created_at)
    render layout: false
  end
end
