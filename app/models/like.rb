class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_one :profile, through: :user

  def as_json(options={})
    super(:include => {:profile => {:only => [:first_name, :last_name]}})
  end
end
