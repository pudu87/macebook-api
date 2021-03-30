class Api::CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    post = Post.find(comment_params[:post_id])
    comments = post.comments.sort_by(&:created_at)
    render json: comments
  end

  def create
    comment = Comment.create(comment_params, user_id: current_user)
  end

  def update
    comment = Comment.find(params[:id])
    comment.update(post_params)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, post_id)
  end

end
