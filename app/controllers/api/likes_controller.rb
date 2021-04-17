class Api::LikesController < ApplicationController
  before_action :authenticate_user!

  def show
    likes = Post.find(params[:id]).likes
    render json: likes.map { |like|
      LikeSerializer.new(likes).serializable_hash[:data][:attributes]
    }
  end

  def create
    like = current_user.likes.build(like_params)
    like.save
    render json: LikeSerializer.new(like).serializable_hash[:data][:attributes]
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
