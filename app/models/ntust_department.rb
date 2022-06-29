class NtustDepartment < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :departments, class_name: "NtustDepartment", foreign_key: "college_id"
  belongs_to :college, class_name: "NtustDepartment", optional: true
end
