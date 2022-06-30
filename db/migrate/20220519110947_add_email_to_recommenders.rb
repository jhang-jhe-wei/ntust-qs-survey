# frozen_string_literal: true

class AddEmailToRecommenders < ActiveRecord::Migration[7.0]
  def change
    add_column :recommenders, :email, :string
  end
end
