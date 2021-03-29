class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.belonging_to(id)
    where(user_id: id).or(Friendship.where(friend_id: id))
  end
end
