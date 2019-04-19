class ContributionsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, contributions = pagy(Contribution.includes(:project).recent)
    authorize(contributions)
    @contributions_by_date = contributions.group_by { |contribution| contribution.created_at.to_date }
    render layout: false
  end

  def create(contribution)
    new_contribution = current_user.contributions.build
    authorize(new_contribution)
    @form = ContributionForm.new(new_contribution, contribution.permit(:raw_body))
    @form.save
  end
end
