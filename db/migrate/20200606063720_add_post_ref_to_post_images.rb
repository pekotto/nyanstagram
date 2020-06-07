class AddPostRefToPostImages < ActiveRecord::Migration[5.2]
  def change
    add_reference :post_images, :post, foreign_key: true
  end
end
