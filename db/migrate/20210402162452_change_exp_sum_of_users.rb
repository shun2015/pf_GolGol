class ChangeExpSumOfUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :exp_sum, :integer, default: 0
  end

  def down
    change_column :users, :exp_sum, :integer
  end
end
