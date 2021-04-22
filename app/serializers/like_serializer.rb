class LikeSerializer
  include JSONAPI::Serializer
  has_one :profile

  attributes :id, :user_id, :post_id, :created_at
  attribute :profile do |like|
    ProfileSerializer.new(like.profile).serializable_hash[:data][:attributes]
  end

end
