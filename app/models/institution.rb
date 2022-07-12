# frozen_string_literal: true

class Institution < ApplicationRecord
  belongs_to :country
  validates :name, presence: true, format: { with: /\A[A-Za-z0-9. ,_-]*\z/, message: "限以英文 (半形) 填入，並勿填寫如É、Ÿ等特殊字元。" }
end
