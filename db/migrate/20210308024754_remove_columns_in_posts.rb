class RemoveColumnsInPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :images, :json
    remove_column :posts, :image_id, :string
  end
end
