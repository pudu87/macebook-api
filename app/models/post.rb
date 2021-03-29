class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def comments_count
    self.comments.count
  end

  def likes_count
    self.likes.count
  end
end
