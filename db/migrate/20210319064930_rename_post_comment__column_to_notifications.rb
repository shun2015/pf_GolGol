class RenamePostCommentColumnToNotifications < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :post_comment_, :post_comment_id
  end
end
