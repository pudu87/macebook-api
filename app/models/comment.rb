class Comment < ApplicationRecord
  belongs_to :user
  has_one :profile, through: :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  def comments_count
    self.comments.count
  end

  def likes_count
    self.likes.count
  end

  def like_id(user)
    like = self.likes.find_by(user_id: user.id)
    like ? like.id : false
  end

end
