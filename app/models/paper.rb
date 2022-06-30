# frozen_string_literal: true

class Paper < ApplicationRecord
  has_many :authors, through: :author_and_paper_records
end
