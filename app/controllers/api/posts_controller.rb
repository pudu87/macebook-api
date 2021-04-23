class Api::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    posts = (current_user.posts +
      current_user.confirmed_friends.map{ |f| f.posts }.flatten)
      .sort_by(&:created_at).reverse
    render json: { 
      current_user_id: current_user.id 
      }.merge({ 
        posts: posts.map { |post| PostSerializer.new(post, {params: {current_user: current_user}})
          .serializable_hash[:data][:attributes] }
      })
  end

  def create
    if post_params[:photo] == 'null'
      post = current_user.posts.build(post_params.except(:photo))
    else
      post = current_user.posts.build(post_params)
    end
    post.save
    render json: PostSerializer.new(post, {params: {current_user: current_user}})
      .serializable_hash[:data][:attributes]
  end

  def show
    user = User.find(params[:id])
    posts = current_user.is_friend?(user) || current_user.id == user.id ?
      user.posts.sort_by(&:created_at).reverse : []
    render json: posts.map { |post|
      PostSerializer.new(post, {params: {current_user: current_user}})
      .serializable_hash[:data][:attributes]
    }
  end

  def update
    post = Post.find(params[:id])
    if post_params[:photo] == 'null'
      post.photo.purge
      post.update(post_params.except(:photo))
    else
      post.update(post_params)
    end
    render json: PostSerializer.new(post, {params: {current_user: current_user}})
      .serializable_hash[:data][:attributes]
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:content, :photo)
  end

end
