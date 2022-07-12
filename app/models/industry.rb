# frozen_string_literal: true

class Industry < ApplicationRecord
  has_many :recommenders, dependent: :destroy
end
