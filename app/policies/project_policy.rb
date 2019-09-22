class ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    index?
  end

  def new?
    !!user
  end

  def create?
    new?
  end

  def edit?
    record&.owner_id == user&.id
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
