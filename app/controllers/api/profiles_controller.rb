class Api::ProfilesController < ApplicationController

  def show
    profile = Profile.find_by_user_id(current_user.id)
    render json: profile
  end

  def update
    profile = Profile.find_by_user_id(current_user.id)
    profile.update(profile_params)
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :birthdate, :location, :sex)
  end

end
