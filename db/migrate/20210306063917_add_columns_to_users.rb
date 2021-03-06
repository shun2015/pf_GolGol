class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, :integer, null: false
    add_column :users, :gender, :integer, null: false
    add_column :users, :address, :string, null: false
    add_column :users, :introduction, :text, null: false
  end
end
