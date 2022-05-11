class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors, id: false do |t|
      t.bigint :id, options: 'PRIMARY KEY'
      t.string :first_name
      t.string :last_name
      t.bigint :affiliation_id, null: false, foreign_key: true

      t.timestamps
    end
    add_index :authors, :id
    add_index :authors, :affiliation_id
    add_foreign_key :authors, :affiliations
  end
end
