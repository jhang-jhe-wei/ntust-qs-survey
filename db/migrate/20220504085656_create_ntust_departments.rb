# frozen_string_literal: true

class CreateNtustDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :ntust_departments do |t|
      t.string :name

      t.timestamps
    end
  end
end
