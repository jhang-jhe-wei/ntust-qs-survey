class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :department, class_name: 'NtustDepartment', foreign_key: 'ntust_department_id'
  has_many :recommenders, :through => :user_and_recommender_records
end
