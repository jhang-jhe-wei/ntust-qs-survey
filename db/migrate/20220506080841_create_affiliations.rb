class CreateAffiliations < ActiveRecord::Migration[6.1]
  def change
    create_table :affiliations, id: false do |t|
      t.bigint :id, options: 'PRIMARY KEY'
      t.string :title
      t.string :city
      t.bigint :country_id, null: false, foreign_key: true
      t.integer :document_count

      t.timestamps
    end
    add_index :affiliations, :id
    add_index :affiliations, :country_id
    add_foreign_key :affiliations, :countries
  end
end
