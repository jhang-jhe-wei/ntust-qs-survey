class Author < ApplicationRecord
  has_one :affiliation
  has_many :papers, :through => :author_and_paper_records
end
