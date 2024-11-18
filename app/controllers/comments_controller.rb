class CommentsController < ApplicationController
  def create
    post = Post.find_by(id: params[:comment]["post_id"])
    new_comment = post.comments.new(comment_params)
    new_comment.commentor = current_user
    new_comment.save!

    redirect_to root_path
  end

  private
    def comment_params
      params.expect(comment: [ :contents ])
    end
end
