class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true # this is up to you
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :posts, dependent: :destroy
end
