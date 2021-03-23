class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|

      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.string :location
      t.string :sex

      t.belongs_to :user

      t.timestamps
    end
  end
end
