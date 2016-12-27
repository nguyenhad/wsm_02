class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case
    when user.admin?
      admin_permission user
    when user.manager?
      manager_permission user
    else
      normal_user_permission user
    end
  end

  private

  def admin_permission user
    can :manage, :all
    cannot :destroy, User, id: user.id
  end

  def manager_permission user
    can :manage, :all
    cannot :destroy, User, id: user.id
    cannot [:update, :destroy], User,
      role: [User.roles[:admin], User.roles[:manager]]
    can :update, User, id: user.id
  end

  def normal_user_permission user
    can :update, User, id: user.id
    can :read, :all
    can :create, User
    can :manage, RequestOff, user_id: user.id
    can :manage, RequestLeave, user_id: user.id
    can :manage, PersonalIssue, user_id: user.id
  end
end
