class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    user || return # Unknown users get to do nothing

    if user.has_role? :admin
      can :manage, :all
    else
      can :create, Template
    end
  end
end
