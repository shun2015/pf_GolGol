class ChangeDatatypeAddressOfUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :address, :integer, null: false
  end
end
