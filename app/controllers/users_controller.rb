class UsersController < ApplicationController
  def index
    @users = User
      .all
      .filter { |user| user != current_user }

    @user_followers = current_user.followers
    @user_followees = current_user.followees  # to be removed
  end

  def follow
    current_user_followers = current_user.followers
    target_user = User.find(params[:user_id])

    # cant subscribe self
    # if havent follower, add to user's followers list
    if target_user != current_user && !current_user_followers.any? { |follower| follower.id == target_user.id }
      current_user_followers << target_user
    end

    redirect_to users_path
  end

  def unfollow
    current_user_followers = current_user.followers
    target_user = User.find(params[:user_id])

    # cant unsubscribe self
    # if have followed, remove from user's followers list
    if target_user != current_user && current_user_followers.any? { |follower| follower.id == target_user.id }
      current_user_followers.delete(target_user)
    end
    redirect_to users_path
  end
end
