# frozen_string_literal: true

class CreateUserAndRecommenderRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :user_and_recommender_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recommender, null: false, foreign_key: true

      t.timestamps
    end
  end
end
