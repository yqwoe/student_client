class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user || User.new
    @user = model
  end
  def isAdmin?
    @current_user.has_role? :admin
  end

  def isSupervisor?
    @current_user.has_role? :supervisor
  end

  def isStaff?
    @current_user.has_role? :staff
  end

end