class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, :integer, null: false, default: 0 
    add_column :users, :gender, :integer, null: false, default: 0 
    add_column :users, :address, :string, null: false, default: ''
    add_column :users, :introduction, :text, null: false, default: ''
  end
end
