class ProjectPolicy < ApplicationPolicy

  attr_reader :user, :project
  class Scope < Scope
    def initialize(user, prokect)
      @user = user
      @project = project
    end
    def destroy?
      @project.user == 1
    end

    def update?
      @project.user == 1r
    end
  end
end
