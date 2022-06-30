# frozen_string_literal: true

module ApplicationHelper
  def all_ntust_departments_options
    options_for_select(NtustDepartment.all.map { |department| [department.name, department.id] })
  end
end
