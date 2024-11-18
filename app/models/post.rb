class Post < ApplicationRecord
  belongs_to :author, class_name: "User"

  # Fea : Like post
  has_many :likings
  has_many :liked_users, through: :likings, source: :user
end
