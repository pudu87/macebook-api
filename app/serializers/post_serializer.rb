class PostSerializer
  include JSONAPI::Serializer
  has_one :profile

  attributes :id, :user_id, :content, :created_at, :updated_at, :comments_count, :likes_count
  attribute :profile do |post|
    ProfileSerializer.new(post.profile).serializable_hash[:data][:attributes]
  end

end
