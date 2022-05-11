class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :department, class_name: 'NtustDepartment', foreign_key: 'ntust_department_id'
  has_many :user_and_recommender_records
  has_many :recommenders, :through => :user_and_recommender_records
end
