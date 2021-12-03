class User < ApplicationRecord
  validates :name, presence: true # this is up to you
  has_many :posts, dependent: :destroy
end
