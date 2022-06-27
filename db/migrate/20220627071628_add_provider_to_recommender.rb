class AddProviderToRecommender < ActiveRecord::Migration[7.0]
  def change
    add_column :recommenders, :provider_name, :string
    add_column :recommenders, :provider_email, :string
  end
end
