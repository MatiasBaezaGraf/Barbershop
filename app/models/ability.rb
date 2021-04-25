# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

          if (user.id == 1) || (user.id == 2)
              can :manage, :all
          else
              can :show, User
              can :index, Barber
              can :index, Turn
              can :index, Service  
          end
  end
end
