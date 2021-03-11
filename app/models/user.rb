class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed
  has_many :followers, through: :follower_relationships, source: :follower
  
  has_many :user_rooms
  has_many :chats

  validates :name, presence: true
  validates :age, presence: true
  validates :address, presence: true
  validates :gender, presence: true

  attachment :profile_image
  enum gender: { 男性: 0, 女性: 1}
  enum address:{
     "---":0,
     北海道:1,青森県:2,岩手県:3,宮城県:4
   }

  def follow(user_id)
    following_relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following.include?(user)
  end
end
