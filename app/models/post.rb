class Post < ApplicationRecord
  belongs_to :user
  has_one :profile, through: :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_one_attached :photo, dependent: :destroy

  def comments_count
    self.comments.count + 
      self.comments.reduce(0) { |sum, comment| sum + comment.comments.count }
  end

  def likes_count
    self.likes.count
  end

  def like_id(user)
    like = self.likes.find_by(user_id: user.id)
    like ? like.id : false
  end
end
