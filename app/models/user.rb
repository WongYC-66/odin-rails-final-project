class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable,
         :omniauthable, omniauth_providers: [ :github ]

  has_one :profile, dependent: :destroy

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

  # oauth
  def self.from_omniauth(auth)
    user = find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end

    user.create_or_update_profile(auth.info.image)
    user
  end

  def create_or_update_profile(image_url = "")
    if profile
      profile.update(img_url: image_url)
    else
      Profile.create(user: self, img_url: get_avatar_url(self))
    end
  end

  # Callback
  after_create :create_or_update_profile

  private
    def get_avatar_url(user)
      # Assume you manually set the email_address here or get it from user input
      email = user.email.downcase

      # Create the SHA256 hash
      hash = Digest::SHA256.hexdigest(email)

      # Compile the full URL with URI encoding for the parameters
      image_src = "https://www.gravatar.com/avatar/#{hash}"

      # This 'image_src' can now be used in an <img> tag or wherever needed
      # puts image_src  # Example to output the result
      image_src
    end
end
