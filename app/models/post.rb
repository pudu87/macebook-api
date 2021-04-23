class Post < ApplicationRecord
  belongs_to :user
  has_one  :profile, through: :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :photo, dependent: :destroy

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
