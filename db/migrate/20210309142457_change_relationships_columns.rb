class ChangeRelationshipsColumns < ActiveRecord::Migration[5.2]
  def change
    #remove_column :relationships, :follower, :references
    #remove_column :relationships, :following_id, :references
    add_column :relationships, :follower_id, :integer
    add_column :relationships, :followed_id, :integer
  end
end
