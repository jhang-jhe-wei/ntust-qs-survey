# frozen_string_literal: true

class NtustDepartmentPolicy < ApplicationPolicy
  def index?
    user.department.self_or_departments.pluck(:id).include? record&.id
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
