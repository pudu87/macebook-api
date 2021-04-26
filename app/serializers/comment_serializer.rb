class CommentSerializer
  include JSONAPI::Serializer
  has_one :profile

  attributes :id, :user_id, :commentable_id, :commentable_type, :content, :created_at, :updated_at, :comments_count, :likes_count
  attribute :profile do |comment|
    ProfileSerializer.new(comment.profile).serializable_hash[:data][:attributes]
  end
  attribute :like_id do |comment, params|
    comment.like_id(params[:current_user])
  end

end
