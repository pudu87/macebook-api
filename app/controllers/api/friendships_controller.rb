class Api::FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(friendship_params[:friend_id])
    friendship = Friendship.create(
      user_id: current_user.id, 
      friend_id: friend.id, 
      accepted: false
    )
    render json: {
      :from => 'possible',
      :to => 'proposed',
      :data => UserSerializer.new(friend, { params: { profile: true }})
        .serializable_hash[:data][:attributes]
    }
  end

  def show
    user = User.find(params[:id])
    confirmed = user.confirmed_friends
    pending = current_user.id == user.id ?
      user.pending_friends : []
    proposed = current_user.id == user.id ?
      user.proposed_friends : []
    possible = current_user.id == user.id ?
      user.possible_friends : []
    render json: {
      :confirmed => confirmed.map { |friend| 
        UserSerializer.new(friend, { params: { profile: true }})
        .serializable_hash[:data][:attributes]},
      :pending => pending.map { |friend| 
        UserSerializer.new(friend, { params: { profile: true }})
        .serializable_hash[:data][:attributes]},
      :proposed => proposed.map { |friend| 
        UserSerializer.new(friend, { params: { profile: true }})
        .serializable_hash[:data][:attributes]},
      :possible => possible.map { |friend| 
        UserSerializer.new(friend, { params: { profile: true }})
        .serializable_hash[:data][:attributes]}
    }
  end

  def update
    friend = User.find(params[:id])
    friendship = current_user.inverse_friendships.find_by_user_id(params[:id])
    friendship.update(accepted: true)
    render json: {
      :from => 'pending',
      :to => 'confirmed',
      :data => UserSerializer.new(friend, { params: { profile: true }})
        .serializable_hash[:data][:attributes]
    }
  end

  def destroy
    friend = User.find(params[:id])
    friendship = current_user.inverse_friendships.find_by_user_id(params[:id])
    friendship ||= current_user.friendships.find_by_friend_id(params[:id])
    friendship.destroy
    render json: {
      :from => 'confirmed',
      :to => 'possible',
      :data => UserSerializer.new(friend, { params: { profile: true }})
        .serializable_hash[:data][:attributes]
    }
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
