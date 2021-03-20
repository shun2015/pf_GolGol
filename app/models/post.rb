class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :post_images, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :notifications, dependent: :destroy
  
  accepts_attachments_for :post_images, attachment: :image

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.chart_date
    chart_date = []
    order(date: :asc).each do |post|
      chart_date << [ post.date.strftime('%Y-%m-%d'), post.score ]
    end
    return chart_date
    #order(date: :asc).pluck('date', 'score').to_h
    # order(date: :asc).map do |post|
    #   [ post.date.strftime('%Y年%m月%d日'), post.score ]
    # end
    # now = Time.now
    # return [
    #   [now, 60],
    #   [now.since(1.days), 65],
    #   [now.since(2.days), 68],
    # ]
  end
  def create_notification(current_user, user)
    #↓ すでに「いいね」されているかwhereで探しに行かせます。
    past_notices = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user.id, id, 'favorite'])
     #↓　blank?メソッドを使用すると、空の場合にtrueが返ります(RubyのメソッドではなくRailsに入っているActiveSupportのgemのメソッドらしいです)
    if past_notices.blank?
      #↓ blanK?がtrueの場合のみ、通知作成を行います。(いいねボタン連打したりする人がいると通知がその分作成されて困るからです)
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user.id,
        action: 'favorite'
      )
      notification.save  #バリデーションが実行された結果エラーが無い場合trueを返し，エラーが発生した場合falseを返す
    end
  end
  def create_notification_comment!(current_user, post_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
