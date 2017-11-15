class Ability
	include CanCan::Ability

	def initialize(user)
		# Define abilities for the passed in user here. For example:
		user ||= User.new # guest user (not logged in)

		if user.has_role? :admin
			can :manage, :all

		end
		if user.has_role? :read, User
			can :read, User
			can :view
		end
		if user.has_role? :edit, User
			can :manage, User
		end

		if user.has_role? :read, Project
			can :read, Project
		end
		if user.has_role? :edit, Project
			can :manage, Project

		end

		if user.has_role? :read, Customer
			can :manage, Customer
		end
		if user.has_role? :edit, Customer
			can :manage, Customer
		end

		if user.has_role? :read, Invoice
			can :read, Invoice
		end
		if user.has_role? :edit, Invoice
			can :manage, Invoice
		end

		if user.has_role? :read, TimeSheet
			can :read, TimeSheet
		end
		if user.has_role? :edit, TimeSheet
			can :manage, TimeSheet
		end

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
