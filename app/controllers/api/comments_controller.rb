class Api::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.build(comment_params)
    comment.save
    render json: CommentSerializer.new(comment, {params: {current_user: current_user}})
      .serializable_hash[:data][:attributes]
  end

  def show
    if params[:id][0] === 'P'
      parent = Post.find(params[:id][1..-1])
    else
      parent = Comment.find(params[:id][1..-1])
    end
    comments = parent.comments.sort_by(&:created_at)
    render json: comments.map { |comment|
      CommentSerializer.new(comment, {params: {current_user: current_user}})
      .serializable_hash[:data][:attributes]
    }
  end

  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)
    render json: CommentSerializer.new(comment, {params: {current_user: current_user}})
      .serializable_hash[:data][:attributes]
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type)
  end

end
