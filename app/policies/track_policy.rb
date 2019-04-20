class TrackPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    !!user
  end
end