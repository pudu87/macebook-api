class Api::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    likes = Post.find(params[:id]).likes
    render json: likes
  end

  def create
    like = current_user.likes.build(like_params)
    like.save
    render json: like
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
