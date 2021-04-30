# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

          if (user.admin == 1)
              can :manage, :all
          else
              can :index, Barber
              can :create, Turn
              can :show, Turn
              can :edit, Turn
              can :edit2, Turn
              can :update, Turn
              can :index, Service  
          end
  end
end
