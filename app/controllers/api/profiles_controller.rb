class Api::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    user = User.find(params[:id])
    profile = current_user.is_friend?(user) || current_user.id == user.id ?
      user.profile : {}
    render json: ProfileSerializer.new(profile, { params: { all: true }})
                                  .serializable_hash[:data][:attributes]
  end

  def update
    profile = Profile.find_by_user_id(params[:id])
    profile.update(profile_params)
    render json: ProfileSerializer.new(profile, { params: { all: true }})
                                  .serializable_hash[:data][:attributes]
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :birthdate, :location, :sex, :avatar)
  end

end
