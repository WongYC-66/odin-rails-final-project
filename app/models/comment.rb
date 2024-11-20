class Comment < ApplicationRecord
  validates :contents, length: { minimum: 1 }

  belongs_to :commentor, class_name: "User"
  belongs_to :post
end
