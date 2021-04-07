class Api::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    posts = (current_user.posts +
      current_user.confirmed_friends.map{ |f| f.posts }.flatten)
      .sort_by(&:created_at).reverse
    render json: posts.as_json(
      :include => {:profile => {:only => [:first_name, :last_name]}},
      :methods => [:comments_count, :likes_count]
    )
  end

  def create
    post = current_user.posts.build(post_params)
    post.save
  end

  def show
    user = User.find(params[:id])
    posts = user.posts.sort_by(&:created_at)
    render json: posts.as_json(
      :include => {:profile => {:only => [:first_name, :last_name]}},
      :methods => [:comments_count, :likes_count]
    )
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
