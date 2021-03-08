class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id, :null => false
      t.datetime :date, :null => false
      t.integer :score
      # t.string :image_id
      t.text :impression, :null => false
      t.string :title, :null => false

      t.timestamps
    end
  end
end
