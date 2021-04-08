class Api::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.build(comment_params)
    comment.save
    render json: comment
  end

  def show
    post = Post.find(params[:id])
    comments = post.comments.sort_by(&:created_at)
    render json: comments
  end

  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)
    render json: comment
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

end
