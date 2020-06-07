class AddFavoriteBreedRefToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :favorite_breed, foreign_key: true
  end
end
