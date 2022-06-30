# frozen_string_literal: true

class NtustDepartment < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :departments, class_name: 'NtustDepartment', foreign_key: 'college_id', dependent: :destroy,
                         inverse_of: :college
  belongs_to :college, class_name: 'NtustDepartment', optional: true, inverse_of: :departments
  after_save :set_college_id, if: :role_is_college?

  def self_or_departments
    return [self] if departments.empty?

    departments
  end

  def visible_recommenders
    Recommender.includes(users: :department).where(users: { ntust_department_id: self_or_departments })
  end

  private

  def role_is_college?
    role == 'college'
  end

  def set_college_id
    # rubocop:disable Rails/SkipsModelValidations
    update_column(:college_id, id)
    # rubocop:enable Rails/SkipsModelValidations
  end
end
