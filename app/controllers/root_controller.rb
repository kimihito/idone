class RootController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, contributions = pagy(Contribution.includes(:project).recent)
    authorize(contributions)
    @contributions_by_date = contributions.group_by { |contribution| contribution.created_at.to_date }
  end
end
