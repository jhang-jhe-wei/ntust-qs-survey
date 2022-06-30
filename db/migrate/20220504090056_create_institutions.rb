# frozen_string_literal: true

class CreateInstitutions < ActiveRecord::Migration[6.1]
  def change
    create_table :institutions do |t|
      t.string :name
      t.bigint :country_id, null: false, foreign_key: true

      t.timestamps
    end
    add_index :institutions, :country_id
    add_foreign_key :institutions, :countries
  end
end
