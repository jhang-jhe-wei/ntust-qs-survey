class CreatePapers < ActiveRecord::Migration[6.1]
  def change
    create_table :papers, id: false do |t|
      t.bigint :id, options: 'PRIMARY KEY' # point to scopus
      t.string :title

      t.timestamps
    end
    add_index :papers, :id
  end
end
