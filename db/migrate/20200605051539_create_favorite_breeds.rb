class CreateFavoriteBreeds < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_breeds do |t|
      t.string :cat_breed

      t.timestamps
    end
  end
end
