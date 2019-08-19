class Root::TrackPolicy < ApplicationPolicy
  def create?
    !!user
  end

  def new?
    create?
  end
end