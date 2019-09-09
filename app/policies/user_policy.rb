# frozen_string_literal: true
class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def edit?
    update?
  end

  def update?
    record == user
  end
end
