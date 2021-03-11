class AddAverageScoreToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :average_score, :integer
  end
end
