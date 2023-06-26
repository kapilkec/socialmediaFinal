class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes ,as: :likeable,dependent: :destroy
  validates :comment,presence: true, length: { minimum: 2, maximum: 30}
  
   scope :likes_greater_than_one, -> {
    joins("LEFT JOIN (SELECT likeable_id, COUNT(id) AS count_likes FROM likes WHERE likeable_type = 'Comment' GROUP BY likeable_id) subquery ON subquery.likeable_id = comments.id")
    .select('comments.*, subquery.count_likes')
    .where('subquery.count_likes > ?', 1)
  }
end
