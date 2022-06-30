# frozen_string_literal: true

class CreateAuthorAndPaperRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :author_and_paper_records do |t|
      t.references :author, null: false, foreign_key: true
      t.references :paper, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
