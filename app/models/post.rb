class Post < ApplicationRecord
  belongs_to :user
  has_one  :profile, through: :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def comments_count
    self.comments.count
  end

  def likes_count
    self.likes.count
  end

  def as_json(options={})
    super(
      :include => {:profile => {:only => [:first_name, :last_name]}},
      :methods => [:comments_count, :likes_count]
    )
  end
end
