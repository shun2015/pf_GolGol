class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :post_images, dependent: :destroy
  has_many :favorites, dependent: :destroy

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
end
