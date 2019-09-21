class TrackPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    !!user
  end

  def new?
    !!user
  end

  def edit?
    update?
  end

  def update?
    record.owner_id == user.id
  end
end