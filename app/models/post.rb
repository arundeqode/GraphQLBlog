class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, uniqueness: true
  belongs_to :user
end
