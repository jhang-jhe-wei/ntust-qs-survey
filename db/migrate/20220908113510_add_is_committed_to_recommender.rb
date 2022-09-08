class AddIsCommittedToRecommender < ActiveRecord::Migration[7.0]
  def change
    add_column :recommenders, :is_committed, :boolean, default: false
  end
end
