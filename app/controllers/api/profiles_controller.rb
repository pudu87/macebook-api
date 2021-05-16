class Api::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    user = User.find(params[:id])
    profile = current_user.is_friend?(user) || current_user.id == user.id ?
      user.profile : false
    if profile
      render json: ProfileSerializer.new(profile, { params: { all: true }})
                                    .serializable_hash[:data][:attributes]
    else
      render json: {}
    end
  end

  def update
    profile = Profile.find_by_user_id(params[:id])
    if profile_params[:avatar] == 'null'
      profile.avatar.purge
      profile.update(profile_params.except(:avatar))
    else
      profile.update(profile_params)
    end
    render json: ProfileSerializer.new(profile, { params: { all: true }})
                                  .serializable_hash[:data][:attributes]
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :birthdate, :location, :sex, :avatar)
  end

end
