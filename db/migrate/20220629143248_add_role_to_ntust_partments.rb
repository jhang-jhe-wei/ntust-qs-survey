# frozen_string_literal: true

class AddRoleToNtustPartments < ActiveRecord::Migration[7.0]
  def change
    add_column :ntust_departments, :role, :string, default: 'department'
  end
end
