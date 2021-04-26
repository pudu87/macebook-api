class LikeSerializer
  include JSONAPI::Serializer
  has_one :profile

  attributes :id, :user_id, :likeable_id, :likeable_type, :created_at
  attribute :profile do |like|
    ProfileSerializer.new(like.profile).serializable_hash[:data][:attributes]
  end

end
