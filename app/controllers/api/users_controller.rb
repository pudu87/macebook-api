class Api::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    user = User.find(params[:id])
    render json: {
      is_friend: current_user.is_friend?(user),
      is_current_user: user.id == current_user.id,
      data: user
    }
  end
end
