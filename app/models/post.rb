class Post < ApplicationRecord
  validates :contents, length: { minimum: 1 }

  belongs_to :author, class_name: "User"

  has_many :comments, dependent: :destroy

  has_one_attached :post_image # active storage

  # Fea : Like post
  has_many :likings
  has_many :liked_users, through: :likings, source: :user
end
