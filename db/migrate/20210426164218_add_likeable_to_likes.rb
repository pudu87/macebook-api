class AddLikeableToLikes < ActiveRecord::Migration[6.1]
  def change
    add_reference :likes, :likeable, polymorphic: true
    remove_reference :likes, :post
  end
end
