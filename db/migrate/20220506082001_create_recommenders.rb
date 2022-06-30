# frozen_string_literal: true

class CreateRecommenders < ActiveRecord::Migration[6.1]
  # rubocop:disable Metrics/MethodLength
  def change
    create_table :recommenders do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :job_title
      t.string :department
      t.bigint :institution_id, null: true, foreign_key: true
      t.bigint :industry_id, null: true, foreign_key: true

      t.timestamps
    end
    add_index :recommenders, :institution_id
    add_index :recommenders, :industry_id
    add_foreign_key :recommenders, :institutions
    add_foreign_key :recommenders, :industries
  end
  # rubocop:enable Metrics/MethodLength
end
