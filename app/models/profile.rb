class Profile < ApplicationRecord
  belongs_to :user

  def as_json(options={})
    super(:only => [:first_name, :last_name, :birthdate, :location, :sex])
  end
end
