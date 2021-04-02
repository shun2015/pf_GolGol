class AddExpSumToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :exp_sum, :integer
    add_column :users, :level, :integer
  end
end
