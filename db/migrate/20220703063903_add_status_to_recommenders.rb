class AddStatusToRecommenders < ActiveRecord::Migration[7.0]
  def change
    add_column :recommenders, :status, :string, default: 'pending'
  end
end
