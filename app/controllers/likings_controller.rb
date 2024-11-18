class LikingsController < ApplicationController
  def like
    target_post = Post.find(params[:post_id])

    # if havent like, add to user's liked_posts
    if !current_user.liked_posts.any? { |post| post == target_post }
      current_user.liked_posts << target_post
    end
    redirect_to root_path
  end

  def unlike
    target_post = Post.find(params[:post_id])

    # if have liked, removed from to user's liked_posts
    if current_user.liked_posts.any? { |post| post == target_post }
      current_user.liked_posts.delete(target_post)
    end
    redirect_to root_path
  end
end
