class BookmarkPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    owner_or_public?
  end

  def new?
    user.present?
  end

  def create?
    new?
  end

  def edit?
    owner?
  end

  def update?
    edit?
  end

  def destroy?
    owner_or_admin?
  end

  private
  def public?
    !record.private? 
  end

  def owner?
    user && record.user == user
  end

  def owner_or_public?
    owner? || public?
  end

  def owner_or_admin?
    owner? || user&.admin?
  end
end
