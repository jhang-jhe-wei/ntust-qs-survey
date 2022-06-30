class NtustDepartment < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :departments, class_name: "NtustDepartment", foreign_key: "college_id"
  belongs_to :college, class_name: "NtustDepartment", optional: true
  after_save :set_college_id, if: :role_is_college?

  private
  def role_is_college?
    self.role == 'college'
  end

  def set_college_id
    self.update_column(:college_id, self.id)
  end
end
