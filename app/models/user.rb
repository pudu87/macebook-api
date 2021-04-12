class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :jwt_authenticatable,
    jwt_revocation_strategy: self

  after_create :init_profile

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend'
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one  :profile, dependent: :destroy

  def confirmed_friends
    User.find_by_sql ["
    SELECT users.*
    FROM users
    JOIN friendships
      ON ((friendships.user_id = users.id AND friendships.friend_id = :id) 
      OR (friendships.friend_id = users.id AND friendships.user_id = :id))
    WHERE accepted IS TRUE
    ", {:id => self.id}]
  end

  # users that have SENT a request (to current_user)
  def pending_friends
    inverse_friends.where(friendships: {accepted: false})
  end

  # users that have RECEIVED a request (from current_user)
  def proposed_friends
    friends.where(friendships: {accepted: false})
  end

  # no friend and no request
  def possible_friends
    User.find_by_sql ["
      SELECT users.*
      FROM users
      LEFT OUTER JOIN friendships
        ON ((friendships.user_id = users.id AND friendships.friend_id = :id) 
        OR (friendships.friend_id = users.id AND friendships.user_id = :id))
      WHERE friendships.id IS NULL
        AND users.id != :id
      ", {:id => self.id}]      
  end

  def init_profile
    self.create_profile
  end

  def is_friend?(user)
    user.confirmed_friends.any?{ |f| self.id == f.id}
  end

  def as_json(options={})
    super(
      :include => {:profile => {
        :only => [:first_name, :last_name]}},
      :only => [:id]
    )
  end
end
