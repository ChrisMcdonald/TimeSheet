# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)

    can :manage, :all if user.has_role? :admin
    if user.has_role? :read, User
      can :read, User
      can :view
    end
    can :manage, User if user.has_role? :edit, User

    can :read, Project if user.has_role? :read, Project
    can :manage, Project if user.has_role? :edit, Project

    can :manage, Customer if user.has_role? :read, Customer
    can :manage, Customer if user.has_role? :edit, Customer

    can :read, Invoice if user.has_role? :read, Invoice
    can :manage, Invoice if user.has_role? :edit, Invoice

    can :read, TimeSheet if user.has_role? :read, TimeSheet
    can :manage, TimeSheet if user.has_role? :edit, TimeSheet

    can :read, Travel if user.has_role? :read, Travel
    can :manage, Travel if user.has_role? :edit, Travel

    can :read, User::PayObligation if user.has_role? :read, User::PayObligation
    can :manage, User::PayObligation if user.has_role? :edit, User::PayObligation

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
