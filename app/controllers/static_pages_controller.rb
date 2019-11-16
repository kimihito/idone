class StaticPagesController < ApplicationController
  def privacy
    skip_authorization
  end
end
