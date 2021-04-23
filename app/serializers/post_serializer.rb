class PostSerializer
  include JSONAPI::Serializer
  has_one :profile

  attributes :id, :user_id, :content, :created_at, :updated_at, :comments_count, :likes_count
  attribute :photo do |post|
    post.photo.attached? ? url_for(post.photo) : nil
  end 
  attribute :profile do |post|
    ProfileSerializer.new(post.profile).serializable_hash[:data][:attributes]
  end
  attribute :like_id do |post, params|
    post.like_id(params[:current_user])
  end

  class << self
    delegate :url_for, to: :'Rails.application.routes.url_helpers'
  end
end
