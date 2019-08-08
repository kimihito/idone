class MyController < ApplicationController
  before_action :authenticate_user!

  private

  def authorize(record, query = nil)
    super([:my, record], query)
  end
end