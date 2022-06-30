# frozen_string_literal: true

class AddCollegeIdToNtustDepartments < ActiveRecord::Migration[7.0]
  def change
    add_column :ntust_departments, :college_id, :bigint
    add_index :ntust_departments, :college_id
  end
end
