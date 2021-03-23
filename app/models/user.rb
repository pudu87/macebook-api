class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend'
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one  :profile, dependent: :destroy
end
