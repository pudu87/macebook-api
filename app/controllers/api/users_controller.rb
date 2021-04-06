class Api::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    confirmed = current_user.confirmed_friends
    pending = current_user.pending_friends
    proposed = current_user.proposed_friends
    possible = current_user.possible_friends
    render json: {
      :confirmed => confirmed.as_json(:include => {:profile => {
                                                  :only => [:first_name, :last_name]}}),
      :pending   => pending.as_json(:include   => {:profile => {
                                                  :only => [:first_name, :last_name]}}),
      :proposed  => proposed.as_json(:include  => {:profile => {
                                                  :only => [:first_name, :last_name]}}),
      :possible  => possible.as_json(:include  => {:profile => {
                                                  :only => [:first_name, :last_name]}})
      }
  end

  def show
    user = User.find(params[:id])
    posts = user.posts.sort_by(&:created_at)
    render json: {
      profile: user.profile.as_json(:only => [:first_name, :last_name]),
      posts: posts.as_json(:methods => [:comments_count, :likes_count])
      }
  end

end
