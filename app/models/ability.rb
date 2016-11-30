class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case
    when user.admin?
      can :manage, :all
      cannot :destroy, User, id: user.id
    when user.manager?
      can :manage, :all
      cannot :destroy, User, id: user.id
      cannot [:update, :destroy], User,
        role: [User.roles[:admin], User.roles[:manager]]
      can :update, User, id: user.id
    else
      can :update, User, id: user.id
      can :read, :all
      can :create, User
    end
  end
end
