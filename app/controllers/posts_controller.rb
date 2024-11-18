class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @posts = Post.includes(:author).includes(:comments).all
    @user_liked_posts = current_user.liked_posts
    @new_comment = Comment.new
  end

  private
    def post_params
      params.expect(post: [ :contents ])
    end
end
