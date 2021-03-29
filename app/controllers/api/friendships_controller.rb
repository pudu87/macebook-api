class Api::FriendshipsController < ApplicationController

  def create
    friend = User.find(params[:friend_id])
    friendship = Friendship.new(user_id: current_user.id, friend_id: friend.id, accepted: false)
    friendship.save
  end

  def update
    friend = User.find(params[:friend_id])
    friendship = current_user.inverse_friendships.find_by_user_id(friend.id)
    friendship.update(accepted: true)
  end

  def destroy
    friend = User.find(params[:friend_id])
    friendship = current_user.inverse_friendships.find_by_user_id(friend.id)
    friendship ||= current_user.friendships.find_by_friend_id(friend.id)
    friendship.destroy
  end
end
