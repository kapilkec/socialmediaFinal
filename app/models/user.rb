class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes,dependent: :destroy
  has_one :story,dependent: :destroy
  has_many :groups,dependent: :destroy
  has_many :communitys , :through => :groups,dependent: :destroy
  has_many :posts,dependent: :destroy
  has_many :comments,dependent: :destroy

  has_many :notifications
  has_one :latest_notification, -> { order(created_at: :desc).limit(1) }, class_name: 'Notification'
  has_one :latest_friend, through: :latest_notification, source: :friend

  scope :with_zero_posts, -> { left_outer_joins(:posts).where(posts: { id: nil }) }
  
end
