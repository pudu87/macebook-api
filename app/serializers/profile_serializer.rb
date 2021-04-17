class ProfileSerializer
  include JSONAPI::Serializer

  attributes :first_name, :last_name
  attributes :birthdate, :location, :sex, if: Proc.new { |_, params|
    params && params[:all] == true
  }
  attribute :avatar do |object|
    object.avatar.attached? ? url_for(object.avatar) : nil
  end

  class << self
    delegate :url_for, to: :'Rails.application.routes.url_helpers'
  end
end
