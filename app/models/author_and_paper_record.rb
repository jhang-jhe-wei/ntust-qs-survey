class AuthorAndPaperRecord < ApplicationRecord
  belongs_to :author
  belongs_to :paper
end
