# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  belongs_to :department, class_name: 'NtustDepartment', foreign_key: 'ntust_department_id', inverse_of: :users
  has_many :user_and_recommender_records, dependent: :destroy
  has_many :recommenders, through: :user_and_recommender_records, dependent: :destroy
  before_create :set_token

  private

  def set_token
    self.token = SecureRandom.base58(10)
  end
end
