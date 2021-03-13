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
    order(date: :asc).pluck('date', 'score').to_h
  end
end
