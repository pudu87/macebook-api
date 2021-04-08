class Api::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    profile = Profile.find_by_user_id(params[:id])
    render json: profile
  end

  def update
    profile = Profile.find_by_user_id(params[:id])
    profile.update(profile_params)
    render json: profile
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :birthdate, :location, :sex)
  end

end
