class Root::TrackPolicy < ApplicationPolicy
  def create?
    !!user
  end
end