# frozen_string_literal: true

class AddCategoryToRecommenders < ActiveRecord::Migration[7.0]
  def change
    add_column :recommenders, :category, :string
  end
end
