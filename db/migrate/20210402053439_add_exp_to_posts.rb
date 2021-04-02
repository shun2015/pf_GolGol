class AddExpToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :exp, :integer
  end
end
