class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :follower, foreign_key: true
      t.references :following, foreign_key: true

      t.timestamps
    end
    add_index :relationships, [:follower_id, :following_id], unique: true
  end
end
