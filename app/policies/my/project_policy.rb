class My::ProjectPolicy < ApplicationPolicy
  def index?
    !!user
  end
end