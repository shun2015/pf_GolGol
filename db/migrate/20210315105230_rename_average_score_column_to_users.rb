class RenameAverageScoreColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :average_score, :profile_score
  end
end
