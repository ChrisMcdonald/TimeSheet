require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  test 'user ability' do

    user = User.first
    ability = Ability.new(user)
    ap user.roles
    ap ability

    assert ability.can?(:read, Project.new(user: user))
    assert ability.can?(:read, User::PayObligation.new(user: user))
  end
end
