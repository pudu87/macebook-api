class Api::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    like = current_user.likes.build(like_params)
    like.save
    render json: LikeSerializer.new(like).serializable_hash[:data][:attributes]
  end

  def show
    if params[:id][0] === 'P'
      parent = Post.find(params[:id][1..-1])
    else
      parent = Comment.find(params[:id][1..-1])
    end
    likes = parent.likes.sort_by(&:created_at)
    render json: likes.map { |like|
      LikeSerializer.new(like).serializable_hash[:data][:attributes]
    }
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
