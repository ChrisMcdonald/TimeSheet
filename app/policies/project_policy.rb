class ProjectPolicy < ApplicationPolicy

  attr_reader :user, :project
  class Scope < Scope
    def initialize(user, project)
      @user = user
      @project = project
    end
    def destroy?
    end

    def update?
    end
  end
end
