class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_one :profile, through: :user
end
