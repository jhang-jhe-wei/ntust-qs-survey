class NtustDepartment < ApplicationRecord
  has_many :users, dependent: :destroy
end
