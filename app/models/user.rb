# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :department, class_name: 'NtustDepartment', foreign_key: 'ntust_department_id', inverse_of: :users
  has_many :user_and_recommender_records, dependent: :destroy
  has_many :recommenders, through: :user_and_recommender_records, dependent: :destroy
end
