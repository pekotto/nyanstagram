class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :user_name, :string
    add_column :users, :plofile_image_id, :string
    add_column :users, :introduction, :text
  end
end
