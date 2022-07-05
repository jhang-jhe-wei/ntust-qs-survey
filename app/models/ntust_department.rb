# frozen_string_literal: true

class NtustDepartment < ApplicationRecord
  ROLES = %w[department college admin].freeze

  ROLES.each do |role|
    define_method("#{role}?") do
      self.role == role
    end
  end

  has_many :users, dependent: :destroy
  has_many :departments, class_name: 'NtustDepartment', foreign_key: 'college_id', dependent: :destroy,
                         inverse_of: :college
  belongs_to :college, class_name: 'NtustDepartment', optional: true, inverse_of: :departments
  after_save :set_college_id, if: :college?
  validates :role, inclusion: { in: ROLES }

  def self_or_departments
    return NtustDepartment.where(id:) if department?
    return NtustDepartment.all if admin?
    return departments if college?
  end

  def visible_recommenders
    Recommender.includes(users: :department).where(users: { ntust_department_id: self_or_departments })
  end

  private

  def set_college_id
    # rubocop:disable Rails/SkipsModelValidations
    update_column(:college_id, id)
    # rubocop:enable Rails/SkipsModelValidations
  end
end
