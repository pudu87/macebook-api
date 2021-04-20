class Api::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    user = User.find(params[:id])
    render json: {
      current_user_id: current_user.id,
      is_current_user: current_user.id === user.id,
      is_friend: current_user.is_friend?(user)
    }.merge({ 
      data: UserSerializer.new(user, { params: { profile: true }})
      .serializable_hash[:data][:attributes] 
    })
  end
end
