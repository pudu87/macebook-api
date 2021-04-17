class CommentSerializer
  include JSONAPI::Serializer
  has_one :profile

  attributes :id, :user_id, :post_id, :content, :created_at, :updated_at
  attribute :profile do |comment|
    ProfileSerializer.new(comment.profile).serializable_hash[:data][:attributes]
  end

end
