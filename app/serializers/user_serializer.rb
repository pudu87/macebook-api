class UserSerializer
  include JSONAPI::Serializer
  has_one :profile

  attributes :id, :email, :created_at
  attribute :profile, if: Proc.new { |_, params|
    params && params[:profile] == true
  } do |user|
    ProfileSerializer.new(user.profile).serializable_hash[:data][:attributes]
  end

end
