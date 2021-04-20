class ProfileSerializer
  include JSONAPI::Serializer

  attributes :first_name, :last_name
  attributes :birthdate, :location, :sex, if: Proc.new { |_, params|
    params && params[:all] == true
  }
  attribute :avatar do |profile|
    profile.avatar.attached? ? url_for(profile.avatar) : nil
  end

  class << self
    delegate :url_for, to: :'Rails.application.routes.url_helpers'
  end
end
