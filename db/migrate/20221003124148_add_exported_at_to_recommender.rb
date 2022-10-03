# frozen_string_literal: true

class AddExportedAtToRecommender < ActiveRecord::Migration[7.0]
  def change
    add_column :recommenders, :exported_at, :datetime
  end
end
