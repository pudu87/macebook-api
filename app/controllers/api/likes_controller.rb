class Api::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    likes = Post.find(params[:id]).likes
    render json: likes.as_json(:include => {:user => {
                                  :include => {:profile => {
                                               :only => [:first_name, :last_name]}}, 
                                             :only => []}})
  end

  def create
    like = Like.create(like_params, user_id: current_user)
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
