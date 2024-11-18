class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile

  has_many :posts, dependent: :destroy, foreign_key: "author_id"
  has_many :comments, dependent: :destroy, foreign_key: "commentor_id"

  # Fea : Follow user
  #  https://dev.to/lberge17/building-a-follower-relationship-in-rails-108n
  # has_many :followings

  # Allows association to view list of users who follow a given user i.e. user.followers
  has_many :follower_relationships, foreign_key: :followee_id, class_name: "Following"
  # has_many :followers, through: :follower_relationships, source: :follower
  has_many :followers, through: :follower_relationships

  # Allows association to view list of users who follow a given user i.e. user.followees
  has_many :followee_relationships, foreign_key: :follower_id, class_name: "Following"
  # has_many :followees, through: :followee_relationships, source: :followee
  has_many :followees, through: :followee_relationships

  # Fea : Like post
  has_many :likings
  has_many :liked_posts, through: :likings, source: :post

  # Callback
  after_create :create_profile

  private
    def create_profile
      Profile.create(user: self)
    end
end
