class WikiPolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.role == 'admin' || wiki.user == user
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def show?
    user.present? && (!wiki.private || user.admin? || wiki.user_id == user.id || user.collaborator?(wiki))
  end

  def edit?
    user.present? && ( user.admin? || wiki.user_id == user.id || user.collaborator?(wiki))
  end

  class Scope
  attr_reader :user, :scope
  
  def initialize(user, scope)
    @user = user
    @scope = scope
  end
  
    def resolve
      if @user.admin? || @user.premium?
        return @scope.all
      elsif @user.standard?
        return @scope.joins(:collaborators).where(collaborators: {user_id: @user.id}) + @scope.where(private: false)
      else
        return @scope.none
      end
    end
  end

end