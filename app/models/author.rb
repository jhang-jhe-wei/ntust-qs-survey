# frozen_string_literal: true

class Author < ApplicationRecord
  belongs_to :affiliation
  has_many :papers, through: :author_and_paper_records
end
