class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #  https://dev.to/lberge17/building-a-follower-relationship-in-rails-108n
  has_many :followings

  # Allows association to view list of users who follow a given user i.e. user.followers
  has_many :follower_relationships, foreign_key: :followee_id, class_name: "Following"
  has_many :followers, through: :follower_relationships, source: :follower

  # Allows association to view list of users who follow a given user i.e. user.following
  has_many :followee_relationships, foreign_key: :follower_id, class_name: "Following"
  has_many :followees, through: :followee_relationships, source: :followee
end
