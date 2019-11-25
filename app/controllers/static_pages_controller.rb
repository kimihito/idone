class StaticPagesController < ApplicationController
  def privacy
    skip_authorization
  end

  def terms
    skip_authorization
  end
end
