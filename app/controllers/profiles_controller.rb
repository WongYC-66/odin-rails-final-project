require "digest"
require "uri"

class ProfilesController < ApplicationController
  before_action :get_profile
  def edit
    if @profile != current_user.profile
      flash[:notice] = "Un-authorized"
      redirect_to root_path
    end
  end

  def show
    if !@profile
      flash[:notice] = "profile not found"
      redirect_to root_path
    end
    @posts = @profile.user.posts
    @user_liked_posts = current_user.liked_posts
    @new_comment = Comment.new
  end

  def update
    if @profile.update(edit_params)
      redirect_to profile_path(@profile)
    else
      flash[:notice] = "something went wrong"
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def edit_params
      params.expect(profile: [ :first_name, :last_name, :description, :img_url ])
    end

    def get_profile
      @profile = Profile
      .includes(:user)
      .find_by(id: params[:id])
    end
end
